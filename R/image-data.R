#' Read image data from a collection of csvs from TimeLapse
#'
#' In addition to reading in the data, this function copies snow depth data
#' from the timelapse photo for each day into the motion photos for that day,
#' to facilitate analysis.
#'
#' @param path path to directory of image files.
#' @param pattern an optional regular expression. Only file names which match
#'   the regular expression will read. Default `FALSE`.
#' @param recursive should files found within subfolders of `path` also be read?
#' @param ... arguments passed on to [readr::read_csv()]
#'
#' @return a `data.frame` of Timelapse image data from the files found in `path`
#' @export
read_image_data <- function(path, pattern, recursive = FALSE, ...) {
  if (!file.exists(path)) {
    cli::cli_abort("Directory {.path {path}} does not exist")
  }

  if (grepl("\\.csv$", path)) {
    csvfiles <- path
  } else {
    csvfiles <- list.files(
      path,
      pattern = ".csv$",
      full.names = TRUE,
      recursive = recursive
    )
  }

  if (!missing(pattern)) {
    csvfiles <- grep(pattern, csvfiles, value = TRUE)
  }

  if (length(csvfiles) == 0) {
    cli::cli_abort("No appropriate files found in {.path {path}}")
  }

  template <- check_template(csvfiles)

  df_list <- lapply(csvfiles, read_one_image_csv, template = template, ...)

  df <- dplyr::bind_rows(df_list)
  df <- janitor::clean_names(df)
  df <- dplyr::relocate(df, "date_time", .after = "deployment_label")

  df <- standardize_trigger_mode(df)
  df <- fill_snow_values(df)
  df <- make_snow_range_cols(df)

  as.image_data(df)
}

check_template <- function(files) {
  pattern <- ".+Template_(v[0-9]{8}.*)\\.csv$"
  if (!any(grepl(pattern, files))) {
    cli::cli_abort("No recognized Timelapse template in filenames")
  }

  templates <- gsub(pattern, "\\1", files)
  template <- unique(templates)

  if (length(template) == 0) {
    cli::cli_warn("Unrecognized Timelapse template in filenames")
  }

  if (length(template) > 1) {
    cli::cli_warn("More than one image labelling template found in
                  {.path {dirname(files)[1]}}: {.str {template}}")
  }
  template
}

read_one_image_csv <- function(path, template, ...) {
    col_names <- strsplit(readLines(path, n = 1), ",")[[1]]
    col_spec <- image_file_cols(template, col_names)
    df <- readr::read_csv(path, col_types = col_spec, name_repair = "unique_quiet", ...)
    reconcile_date_time_fields(df, path)
}

reconcile_date_time_fields <- function(df, path) {
  if ("DateTime" %in% names(df)) return(df)

  if (!("Date" %in% names(df) && "Time" %in% names(df))) {
    cli::cli_abort("{.path {path}}: File must have either DateTime, or Date and Time columns")
  }

  df$DateTime <- lubridate::parse_date_time(paste(df$Date, df$Time), "dbY HMS")
  df$Date <- NULL
  df$Time <- NULL
  df
}

image_file_cols <- function(template, names) {
  all_col_names <- list(
    v20230518 = readr::cols_only(
      RootFolder = readr::col_character(),
      Study_Area_Name = readr::col_character(),
      Sample_Station_Label = readr::col_character(),
      Deployment_Label = readr::col_character(),
      Date = readr::col_character(),
      Time = readr::col_character(),
      DateTime = readr::col_datetime(),
      Episode = readr::col_character(),
      Species = readr::col_character(),
      Total_Count_Episode = readr::col_double(),
      Obj_Count_Image = readr::col_integer(),
      Adult_Male = readr::col_integer(),
      Adult_Female = readr::col_integer(),
      Adult_Unclassified_Sex = readr::col_integer(),
      Yearling_Male = readr::col_integer(),
      Yearling_Female = readr::col_integer(),
      Yearling_Unclassified_Sex = readr::col_integer(),
      Young_of_Year_Unclassified_Sex = readr::col_integer(),
      Juvenile_Unclassified_Sex = readr::col_integer(),
      Male_Unclassified_Age = readr::col_integer(),
      Female_Unclassified_Age = readr::col_integer(),
      Unclassified_Life_Stage_and_Sex = readr::col_integer(),
      Antler_Class = readr::col_character(),
      Animal_Identifiable = readr::col_logical(),
      Animal_Tagged = readr::col_logical(),
      Behaviour_1 = readr::col_character(),
      Behaviour_2 = readr::col_character(),
      Behaviour_3 = readr::col_character(),
      Human_Use_Type = readr::col_character(),
      Human_Transport_Mode = readr::col_character(),
      Temperature = readr::col_number(),
      Snow_Depth = readr::col_character(),
      Lens_Obscured = readr::col_logical(),
      Starred = readr::col_logical(),
      Needs_Review = readr::col_logical(),
      Comment = readr::col_character(),
      Surveyor = readr::col_character(),
      Trigger_Mode = readr::col_character(),
      File = readr::col_character(),
      RelativePath = readr::col_character(),
      DeleteFlag = readr::col_logical()
    )
  )

  # Get the cols that match the template
  col_types <- all_col_names[[template]]

  # Subset to match the names in the data
  col_types$cols <- col_types$cols[names]
  col_types
}

make_snow_range_cols <- function(x) {
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
    dplyr::relocate(x, "snow_index", "snow_is_est", "snow_depth_lower", "snow_depth_upper",
                    .after = "snow_depth")
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
  out <- cut(x, breaks = c(0,5,15,30,60,120), labels = FALSE,
      include.lowest = TRUE, right = FALSE)
  out[x == 0] <- 0
  out[x >= 120] <- 6
  out
}

fill_snow_values <- function(x) {
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
