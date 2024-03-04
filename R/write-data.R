write_timelapse <- function(image_data, file, na = "", ..., template = system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")) {
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

  if (!file.exists(file)) {
    cli::cli_abort("File {.var {file}} does not exist")
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

  output_data <- dplyr::mutate(
    image_data,
    `Study Area Name` = .data$study_area_name,
    `Camera Label` = .data$sample_station_label,
    `Detection Date` = format(.data$date_time, "%d-%b-%Y"),
    `Detection Time` = format(.data$date_time, "%H:%M:%S"),
    `Air Temperature (C)` = .data$temperature,
    `Sequence Definition (s)` = NA_integer_,
    `Species Code` = .data$species,
    `Count` = .data$total_count_episode,
    ...,
    .keep = "none"
  )

  wb$add_data(
    "Sequence Image Data",
    output_data,
    start_col = 1,
    start_row = 2,
    col_names = FALSE
  )

  wb$save(file = output_file)
}
