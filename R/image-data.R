#' Read image data from a collection of csvs from TimeLapse
#'
#' In addition to reading in the data, this function copies snow depth data
#' from the timelapse photo for each day into the motion photos for that day,
#' to facilitate analysis. It also does basic standardization of trigger mode values,
#' creates numeric snow depth columns, and checks for the presence of a
#' total_count_episode column, adding one if missing. If the data has separate
#' Date and Time columns instead of a combined DateTime column,
#' these will be reconciled into a single DateTime column. All column names are
#' standardized to snake_case.
#'
#' For wallow data, this also removes static images (both timelapse and motion activated),
#' and only keeps the video records.
#'
#' @param path path to directory of image files, a single .csv file, or a character
#'   vector of .csv files.
#' @param pattern an optional regular expression. Only file names which match
#'   the regular expression will read. Default `FALSE`.
#' @param recursive should files found within subfolders of `path` also be read?
#' @param template path to a "`.tdb`" TimeLapse Template file. Optional; if not provided,
#' the function will attempt to identify the appropriate internal template
#' based on the file names in `path`.
#' @param ... arguments passed on to [readr::read_csv()]
#'
#' @return a `data.frame` of Timelapse image data from the files found in `path`.
#' The data.frame will have an "image_data" class, and an attribute "template"
#' with the name of the template used to read the data.
#' @export
read_image_data <- function(
  path,
  pattern,
  recursive = FALSE,
  template = NULL,
  ...
) {
  if (!all(file.exists(path))) {
    cli::cli_abort("Directory {.path {path}} does not exist")
  }

  if (!any(grepl("\\.csv$", path))) {
    path <- list.files(
      path,
      pattern = ".csv$",
      full.names = TRUE,
      recursive = recursive
    )
  }

  if (!missing(pattern)) {
    path <- grep(pattern, path, value = TRUE)
  }

  if (length(path) == 0) {
    cli::cli_abort("No appropriate files found in {.path {path}}")
  }

  template <- check_template(path, template)

  df_list <- lapply(path, read_one_image_csv, template = template, ...)

  df <- dplyr::bind_rows(df_list)
  df <- janitor::clean_names(df)
  df <- dplyr::relocate(df, "date_time", .after = "deployment_label")

  df <- clean_timelapse_video_data(df)
  df <- standardize_trigger_mode(df)
  df <- fill_snow_values(df)
  df <- make_snow_range_cols(df)
  df <- check_add_total_count_episode(df)

  as.image_data(df, template = basename(template))
}

check_template <- function(files, template = NULL) {
  if (!is.null(template)) {
    if (!file.exists(template)) {
      cli::cli_abort("Provided template {.path {template}} does not exist")
    }
    return(template)
  }

  # This is an escape hatch for shiny - since the file names assigned from
  # fileInput() are random, we assign the csv files vector names from the original
  # filenames, and use those here to find the template
  files <- names(files) %||% files
  pattern <- ".+Template_(.+)\\.csv$"

  if (!any(grepl(pattern, files))) {
    if (rlang::is_interactive()) {
      return(choose_package_template())
    }
    cli::cli_abort("No recognized Timelapse template in filenames")
  }

  templates <- unique(gsub(pattern, "\\1", files))
  template <- sort(templates)[length(templates)]

  if (length(templates) > 1) {
    # use the one with the latest version number
    cli::cli_warn(
      "More than one image labelling template found in
      {.path {dirname(files)[1]}}: {.str {templates}}. 
      Using {.path {template}}."
    )
  }

  pkg_templates <- get_package_templates()

  template_tdb <- grep(template, pkg_templates, value = TRUE)

  if (length(template_tdb) == 0) {
    cli::cli_abort("Unrecognized Timelapse template in filenames")
  }

  template_tdb[length(template_tdb)]
}

choose_package_template <- function(error_call = rlang::caller_env()) {
  pkg_templates <- get_package_templates()
  # Exclude the master picklist, which is not a labelling template
  pkg_templates <- pkg_templates[
    !grepl("MasterTemplateFieldPicklist", basename(pkg_templates))
  ]

  names <- tools::file_path_sans_ext(basename(pkg_templates))
  title <- cli::format_inline(
    "No Timelapse template found in filenames. Which template do you want to use? (0 to exit)"
  )
  choice <- utils::menu(
    choices = cli::style_bold(names),
    title = title
  )
  if (choice == 0L) {
    cli::cli_abort("No template selected", call = error_call)
  }

  pkg_templates[[choice]]
}

read_one_image_csv <- function(path, template, ...) {
  col_names <- strsplit(readLines(path, n = 1), ",")[[1]]
  col_spec <- tdb_to_colspec(template, col_names)

  df <- readr::read_csv(
    path,
    col_types = col_spec,
    name_repair = "unique_quiet",
    ...
  )

  df <- drop_empty_unnamed_cols(df)

  if (length(setdiff(names(df), names(col_spec$cols))) > 0) {
    cli::cli_warn(
      "File {.path {path}} has unexpected columns: {.str {setdiff(names(df), names(col_spec$cols))}}"
    )
  }
  reconcile_date_time_fields(df, path)
}

drop_empty_unnamed_cols <- function(df) {
  # Drop auto-generated column names (e.g. `...41`) that arise from trailing
  # commas in CSV, but only when the column contains no data.
  auto_named <- grep("^[.]{3}[0-9]+$", names(df), value = TRUE)
  empty_auto <- auto_named[vapply(
    df[auto_named],
    \(col) all(is.na(col)),
    logical(1)
  )]
  df[, !names(df) %in% empty_auto, drop = FALSE]
}

reconcile_date_time_fields <- function(df, path) {
  if ("DateTime" %in% names(df)) {
    return(df)
  }

  if (!("Date" %in% names(df) && "Time" %in% names(df))) {
    cli::cli_abort(
      "{.path {path}}: File must have either DateTime, or Date and Time columns"
    )
  }

  df$DateTime <- lubridate::parse_date_time(paste(df$Date, df$Time), "dbY HMS")
  df$Date <- NULL
  df$Time <- NULL
  df
}

make_snow_range_cols <- function(x) {
  if (!"snow_depth" %in% names(x)) {
    return(x)
  }

  x <- dplyr::mutate(
    x,
    snow_is_est = grepl("Est", .data$snow_depth),
    snow_depth_lower = dplyr::case_when(
      grepl("Est\\. Trace", .data$snow_depth) ~ 1,
      grepl("Est\\. Low", .data$snow_depth) ~ 5,
      grepl("Est\\. Mod", .data$snow_depth) ~ 15,
      grepl("Est\\. Deep", .data$snow_depth) ~ 30,
      grepl("Est\\. Very Deep", .data$snow_depth) ~ 60,
      grepl("Est\\. Over", .data$snow_depth) ~ 120,
      .default = suppressWarnings(as.numeric(.data$snow_depth))
    ),
    snow_depth_upper = dplyr::case_when(
      grepl("Est\\. Trace", .data$snow_depth) ~ 5,
      grepl("Est\\. Low", .data$snow_depth) ~ 15,
      grepl("Est\\. Mod", .data$snow_depth) ~ 30,
      grepl("Est\\. Deep", .data$snow_depth) ~ 60,
      grepl("Est\\. Very Deep", .data$snow_depth) ~ 120,
      grepl("Est\\. Over", .data$snow_depth) ~ Inf,
      .default = .data$snow_depth_lower
    ),
    snow_index = bin_snow_depths(.data$snow_depth_lower)
  )
  dplyr::relocate(
    x,
    "snow_index",
    "snow_is_est",
    "snow_depth_lower",
    "snow_depth_upper",
    .after = "snow_depth"
  )
}

standardize_trigger_mode <- function(x) {
  if (!"trigger_mode" %in% names(x)) {
    return(x)
  }

  x$trigger_mode <- dplyr::case_when(
    x$trigger_mode == "M" ~ "Motion Detection",
    x$trigger_mode == "T" ~ "Time Lapse",
    .default = x$trigger_mode
  )
  if (
    !all(x$trigger_mode %in% c("Motion Detection", "Time Lapse", NA_character_))
  ) {
    cli::cli_abort(
      "Unexpected values found in {.var trigger_mode} column."
    )
  }
  x
}

bin_snow_depths <- function(x) {
  out <- cut(
    x,
    breaks = c(0, 5, 15, 30, 60, 120),
    labels = FALSE,
    include.lowest = TRUE,
    right = FALSE
  )
  out[x == 0] <- 0
  out[x >= 120] <- 6
  out
}

fill_snow_values <- function(x) {
  if (!"snow_depth" %in% names(x)) {
    return(x)
  }

  snow_vals <- dplyr::filter(
    x,
    !is.na(.data$snow_depth),
    .data$trigger_mode == "Time Lapse"
  ) %>%
    dplyr::mutate(date = as.Date(.data$date_time)) %>%
    dplyr::select("deployment_label", "date", "snow_depth_src" = "snow_depth")

  x <- dplyr::left_join(
    dplyr::mutate(x, date = as.Date(.data$date_time)),
    snow_vals,
    by = c("deployment_label", "date")
  )

  x$snow_depth[is.na(x$snow_depth)] <- x$snow_depth_src[is.na(x$snow_depth)]

  dplyr::select(x, , -"date", -"snow_depth_src")
}

check_add_total_count_episode <- function(df) {
  if ("total_count_episode" %in% names(df)) {
    return(df)
  }

  df |>
    dplyr::rowwise() |>
    dplyr::mutate(
      total_count_episode = sum(
        dplyr::c_across(dplyr::any_of(animal_count_cols())),
        na.rm = TRUE
      )
    ) |>
    dplyr::ungroup()
}

animal_count_cols <- function() {
  c(
    "adult_male",
    "adult_female",
    "adult_unclassified_sex",
    "yearling_male",
    "yearling_female",
    "yearling_unclassified_sex",
    "young_of_year_unclassified_sex",
    "juvenile_unclassified_sex",
    "male_unclassified_age",
    "female_unclassified_age",
    "unclassified_life_stage_and_sex"
  )
}

clean_timelapse_video_data <- function(df) {
  file_ext <- tolower(tools::file_ext(df$file))

  img_file_types <- c("jpg", "jpeg", "png")
  video_file_types <- c("mp4", "avi", "mov", "mkv", "wmv")

  file_ext[file_ext %in% img_file_types] <- "image"
  file_ext[file_ext %in% video_file_types] <- "video"

  if (length(unique(file_ext)) %in% 0:1 && !anyNA(df$trigger_mode)) {
    # should be just videos, not blank lines where trigger mode
    return(df)
  }

  df |>
    dplyr::mutate(file_type = file_ext) |>
    dplyr::filter(
      # Take out rows where the file is not a video and trigger mode is time lapse
      !(file_type == "image" &
        .data$trigger_mode == "Time Lapse"),
      # Take out rows where the file is not a video and episode is NA
      !(file_type == "image" &
        is.na(.data$episode))
    ) |>
    dplyr::mutate(
      trigger_mode = ifelse(
        is.na(.data$trigger_mode),
        "Motion Detection",
        .data$trigger_mode
      )
    ) |>
    dplyr::select(-"file_type")
}
