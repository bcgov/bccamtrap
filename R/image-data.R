#' Read image data from a collection of csvs from TimeLapse
#'
#' In addition to reading in the data, this function copies snow depth data
#' from the timelapse photo for each day into the motion photos for that day,
#' to facilitate analysis.
#'
#' @param path path to directory of image files, a single .csv file, or a character
#'   vector of .csv files.
#' @param pattern an optional regular expression. Only file names which match
#'   the regular expression will read. Default `FALSE`.
#' @param recursive should files found within subfolders of `path` also be read?
#' @param ... arguments passed on to [readr::read_csv()]
#'
#' @return a `data.frame` of Timelapse image data from the files found in `path`
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

  template <- check_template(path)

  df_list <- lapply(path, read_one_image_csv, template = template, ...)

  df <- dplyr::bind_rows(df_list)
  df <- janitor::clean_names(df)
  df <- dplyr::relocate(df, "date_time", .after = "deployment_label")

  df <- standardize_trigger_mode(df)
  df <- fill_snow_values(df)
  df <- make_snow_range_cols(df)

  as.image_data(df)
}

check_template <- function(files) {
  # This is an escape hatch for shiny - since the file names assigned from
  # fileInput() are random, we assign the csv files vector names from the original
  # filenames, and use those here to find the template
  files <- names(files) %||% files
  pattern <- ".+Template_(.+)\\.csv$"

  if (!any(grepl(pattern, files))) {
    cli::cli_abort("No recognized Timelapse template in filenames")
  }

  templates <- gsub(pattern, "\\1", files)
  template <- unique(templates)

  if (length(template) == 0) {
    cli::cli_warn("Unrecognized Timelapse template in filenames")
  }

  if (length(template) > 1) {
    # use the one with the latest version number
    template <- sort(template)[length(template)]
    cli::cli_warn(
      "More than one image labelling template found in
                  {.path {dirname(files)[1]}}: {.str {template}}. 
                  Using {.path {template}}."
    )
  }

  pkg_templates <- fs::dir_ls(system.file(
    "extdata",
    "timelapse-templates",
    package = "bccamtrap"
  ))

  template_tdb <- grep(template, pkg_templates, value = TRUE)

  template_tdb[length(template_tdb)]
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
  x$trigger_mode <- dplyr::case_when(
    x$trigger_mode == "M" ~ "Motion Detection",
    x$trigger_mode == "T" ~ "Time Lapse",
    .default = x$trigger_mode
  )
  if (!all(x$trigger_mode %in% c("Motion Detection", "Time Lapse"))) {
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
