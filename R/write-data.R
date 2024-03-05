#' Write image data to a csv file
#'
#' This is a very thin wrapper around [readr::write_csv()]. You can use that
#' function directly for more control
#'
#'
#' @param image_data image data object.
#' @param file path to the output csv file
#' @param na How should missing values be written. Default empty (`""`)
#' @param ... other parameters passed on to [readr::write_csv()]
#'
#' @return input `image_data`, invisibly
#' @export
#'
#' @examples
#' \dontrun{
#' write_image_data(image_data, "my_spi_submission.xlsx")
#' write_image_data(image_data, "my_spi_submission.xlsx", Surveyor = surveyor,
#'    `Survey Observation Photos` = file)
#' }
write_image_data <- function(image_data, file, na = "", ...) {
  check_image_data(image_data)
  check_name(file)

  readr::write_csv(image_data, file, na = na, ...)
}

#' Write all data to a new SPI submission file
#'
#' This will write only the default columns for each of the tabs in the SPI
#' template. For more fine-grained control, use [write_to_spi_sheet()] on each
#' of `sample_station_info`, `camera_info`, `cam_setup_checks`, `image_data`.
#'
#' @param sample_station_info object of class `sample_station_info`
#' @param camera_info object of class `camera_info`
#' @param camera_setup_checks object of class `camera_setup_checks`
#' @param image_data object of class `image_data`
#' @inheritParams write_to_spi_sheet
#'
#' @return path to the output `file`
#' @export
fill_spi_template <- function(sample_station_info,
                              camera_info,
                              camera_setup_checks,
                              image_data,
                              file,
                              template = default_spi_template()) {

  check_sample_station_info(sample_station_info)
  check_camera_info(camera_info)
  check_cam_setup_checks(camera_setup_checks)
  check_image_data(image_data)
  check_name(file)

  if (!tools::file_ext(file) %in% c("xls", "xlsx", "xlsm")) {
    cli::cli_abort("file must be an Excel file name")
  }

  # First one uses the template, subsequent ones need to write to the new file
  write_to_spi_sheet(sample_station_info, file, template = template)
  write_to_spi_sheet(camera_info, file, template = file)
  write_to_spi_sheet(camera_setup_checks, file, template = file)
  write_to_spi_sheet(image_data, file, template = file)

  invisible(file)
}

#' Write a single data frame to SPI submission template
#'
#' @param x object of class `sample_station_info`, `camera_info`, `cam_setup_checks`, or `image_data`
#' @param file path to the output file (`.xls*`)
#' @param ... extra columns in `x` to write out. Must be paired column
#'   names in the form \code{`Destination Column` = data_column}. If the left-hand side
#'   is a syntactically valid name it can be provided as-is, but if it has spaces in it
#'   it must be wrapped in backticks or quotes. See examples.
#' @param template SPI submission template to use. Default is included in the
#'   package, accessed by
#'   `system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")`
#'
#' @return input `x`, invisibly
#' @export
#'
#' @examples
#' \dontrun{
#' write_to_spi_sheet(camera_setup_checks_data, "my_spi_submission.xlsx")
#' write_to_spi_sheet(image_data, "my_spi_submission.xlsx", Surveyor = surveyor,
#'    `Survey Observation Photos` = file)
#' }
write_to_spi_sheet <- function(x,
                               file,
                               ...,
                               template = default_spi_template()) {
  UseMethod("write_to_spi_sheet")
}

#' @export
write_to_spi_sheet.default <- function(x, file, ..., template) {
  cli::cli_abort("No method for object of class {class(x)}")
}

#' @export
write_to_spi_sheet.sample_station_info <- function(x,
                                                   file,
                                                   ...,
                                                   template = default_spi_template()) {
  write_to_spi_sheet_impl_(
    x,
    file,
    sheet = "Sample Station Information",
    ...,
    template = template
  )
}

#' @export
write_to_spi_sheet.camera_info <- function(x,
                                           file,
                                           ...,
                                           template = default_spi_template()) {
  write_to_spi_sheet_impl_(
    x,
    file,
    sheet = "Camera Information",
    ...,
    template = template
  )
}

#' @export
write_to_spi_sheet.cam_setup_checks <- function(x,
                                                file,
                                                ...,
                                                template = default_spi_template()) {
  write_to_spi_sheet_impl_(
    x,
    file,
    sheet = "Camera Setup and Checks",
    ...,
    template = template
  )
}

#' @export
write_to_spi_sheet.image_data <- function(x,
                                          file,
                                          ...,
                                          template = default_spi_template()) {
  write_to_spi_sheet_impl_(
    x,
    file,
    sheet = "Sequence Image Data",
    ...,
    template = template
  )
}

write_to_spi_sheet_impl_ <- function(x,
                                     output_file,
                                     sheet,
                                     ...,
                                     template = default_spi_template()) {
  wb <- openxlsx2::wb_load(template)

  sheets <- wb$get_sheet_names()

  if (!sheet %in% sheets) {
    cli::cli_abort("Sheet {.val {sheet}} not found in template")
  }

  template_colnames <- names(openxlsx2::wb_data(wb, sheet, rows = 1))

  template_df <- as.data.frame(matrix(
    NA_character_,
    nrow(x),
    length(template_colnames),
    dimnames = list(NULL, template_colnames)
  ))

  default_columns <- get_default_columns(x, sheet)

  other_columns <- eval(substitute(list(...)), envir = x)

  invalid_columns <- setdiff(
    c(names(default_columns), names(other_columns)),
      template_colnames
  )
  if (length(invalid_columns) > 0) {
    cli::cli_abort("Column{?s} {.var {invalid_columns}} not in template.")
  }

  output_data <- utils::modifyList(
    template_df,
    c(default_columns, other_columns)
  )

  wb$add_data(
    sheet,
    output_data,
    start_col = 1,
    start_row = 2,
    col_names = FALSE
  )

  wb$save(file = output_file)
  invisible(x)
}

get_default_columns <- function(x, sheet) {
  switch(
    sheet,
    "Sample Station Information" = list(
      `Study Area Name` = x$study_area_name,
      `Sample Station Label` = x$sample_station_label,
      `Longitude Sample Station (DD)` = lon_from_sf(x),
      `Latitude Sample Station (DD)` = lat_from_sf(x)
    ),
    "Camera Information" = list(
      `Study Area Name` = x$study_area_name,
      `Camera Label` = x$camera_label,
      `Longitude Camera (DD)` = lon_from_sf(x),
      `Latitude Camera (DD)` = lat_from_sf(x)
    ),
    "Camera Setup and Checks" = list(
      `Study Area Name` = x$study_area_name,
      `Camera Label` = x$camera_label,
      `Date` = format(x$sampling_start, "%d-%b-%Y"),
      `Visit End Date` = format(x$sampling_end, "%d-%b-%Y")
    ),
    "Sequence Image Data" = list(
      `Study Area Name` = x$study_area_name,
      `Camera Label` = x$sample_station_label, # TODO: Join cam setup and checks to get camera label
      `Detection Date` = format(x$date_time, "%d-%b-%Y"),
      `Detection Time` = format(x$date_time, "%H:%M:%S"),
      `Species Code` = x$species,
      `Count` = x$total_count_episode
    ),
    cli::cli_abort("Invalid sheet name: {sheet}")
  )
}

lat_from_sf <- function(x) {
  x <- sf::st_transform(x, 4326)
  sf::st_coordinates(x)[,2]
}

lon_from_sf <- function(x) {
  x <- sf::st_transform(x, 4326)
  sf::st_coordinates(x)[,1]
}

default_spi_template <- function() {
  system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")
}
