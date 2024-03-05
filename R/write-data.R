#' Write image data to a csv or SPI submission template
#'
#' if output `file` specified is a csv file, this will output all of the image
#' data to a single csv file. If it is a `xls*` file, it will populate the
#' `Sequence Image Data` tab in a new SPI submission sheet, using a template.
#'
#' @param image_data image data object.
#' @param file path to the output file
#' @param ... extra columns in `image_data` to write out. Must be paired column
#'   names in the form \code{`Destination Column` = data_column}. If the left-hand side
#'   is a syntactically valid name it can be provided as-is, but if it has spaces in it
#'   it must be wrapped in backticks or quotes. See examples.
#' @param na How should missing values be written. Default empty (`""`)
#' @param template SPI submission template to use. Default is included in the
#'   package, accessed by
#'   `system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")`
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
write_image_data <- function(image_data, file, ..., na = "", template = system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")) {
  check_image_data(image_data)
  check_name(file)

  ext <- tools::file_ext(file)

  if (!ext %in% c("csv", "xls", "xlsx", "xlsm")) {
    cli::cli_abort("file must be a csv or Excel file name")
  }

  if (ext == "csv") {
    return(
      readr::write_csv(image_data, file, na = na, ...)
    )
  }

  write_to_tl_sheet(
    image_data,
    output_file = file,
    template = template,
    ...
  )
}

write_to_tl_sheet <- function(image_data, output_file, template, ...) {
  wb <- openxlsx2::wb_load(template)

  sheets <- wb$get_sheet_names()

  sheet <- "Sequence Image Data"

  if (!sheet %in% sheets) {
    cli::cli_abort("Sheet {.val {sheet}} not found in template")
  }

  template_colnames <- names(openxlsx2::wb_data(wb, sheet, rows = 1))

  template_df <- as.data.frame(matrix(
    NA_character_,
    nrow(image_data),
    length(template_colnames),
    dimnames = list(NULL, template_colnames)
  ))

  default_columns <- list(
    `Study Area Name` = image_data$study_area_name,
    `Camera Label` = image_data$sample_station_label,
    `Detection Date` = format(image_data$date_time, "%d-%b-%Y"),
    `Detection Time` = format(image_data$date_time, "%H:%M:%S"),
    `Species Code` = image_data$species,
    `Count` = image_data$total_count_episode
  )

  other_columns <- eval(substitute(list(...)), envir = image_data)

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
  invisible(image_data)
}
