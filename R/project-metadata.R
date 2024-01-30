# Copyright 2024 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

#' Read project-level data from the RISC worksheet 'Project Information' tab
#'
#' This will read in the project information from a RISC worksheet following the
#' 'v20230518' template
#'
#' @param path path to the RISC workbook
#' @param ... arguments passed on to [readxl::read_excel()]
#'
#' @return a `data.frame` of project-level information
#' @export
read_project_info <- function(path, ...) {
  read_sheet_impl_(
    path,
    sheet = "Project Information",
    col_types = "text",
    ...
  )
}

#' Read the "Sample Station Information" tab from the RISC worksheet.
#'
#' This will read in the sample station information from a RISC worksheet following the
#' 'v20230518' template
#'
#' @inheritParams read_project_info
#' @param as_sf should the data be returned as an `sf` object of the station locations? Default `TRUE`
#'
#' @return a `data.frame` of station information, as an `sf` object if specified.
#' @export
read_sample_station_info <- function(path, as_sf = TRUE, ...) {

  sheet <- "Sample Station Information"
  header <- read_sheet_impl_(path, sheet, col_types = "text", n_max = 0)
  col_types <- sample_station_info_fields(header)

  ss_info <- read_sheet_impl_(
    path,
    sheet = sheet,
    col_types = col_types,
    ...
  ) |>
    dplyr::mutate(set_date = excel_to_date(.data$set_date))

  # Read and join relevant info from Camera Information tab

  if (as_sf) {
    return(to_sf(ss_info))
  }
  ss_info
}

#' Read the "Camera Setup and Checks" tab from the RISC worksheet.
#'
#' This will read in the camera setup information from a RISC worksheet following the
#' 'v20230518' template
#'
#' @inheritParams read_project_info
#'
#' @return a `data.frame` of camera setup information
#' @export
read_cam_setup_checks <- function(path, ...) {

  sheet <- "Camera Setup and Checks"
  header <- read_sheet_impl_(path, sheet, col_types = "text", n_max = 0)

  col_types <- cam_setup_checks_fields(header)

  raw_inp <- read_sheet_impl_(path, sheet, col_types = col_types)

  parse_cam_setup_checks_fields(raw_inp)
}

read_sheet_impl_ <- function(path, sheet, col_types, ...) {
  readxl::read_excel(
    path = path,
    sheet = sheet,
    col_types = col_types,
    na = c("", "NA", "N/A"),
    .name_repair = janitor::make_clean_names,
    ...
  )
}

cam_setup_checks_fields <- function(x) {
  col_types <- c(
    study_area_name = "text",
    sample_station_label = "text",
    deployment_label = "text",
    camera_label = "text",
    surveyors = "text",
    date_checked = "text",
    time_checked = "text",
    sampling_start_date = "text",
    start_time = "text",
    sampling_end_date = "text",
    end_time = "text",
    total_visit_or_deployment_time = "numeric",
    unit_of_total_time_code = "text",
    visit_type = "text",
    camera_status_on_arrival = "text",
    battery_level = "text",
    batteries_changed = "text",
    number_of_photos = "numeric",
    quiet_period_s = "text",
    trigger_sensitivity = "text",
    trigger_timing_s = "numeric",
    photos_per_trigger = "numeric",
    video_length_per_trigger_s = "numeric",
    timelapse_photos = "numeric",
    timelapse_time = "text",
    time_zone = "text",
    bait_lure_type = "text",
    camera_visit_comments = "text",
    camera_visit_photos = "text",
    sd_downloaded_y_n = "text",
    images_classified_y_n = "text",
    timelapse_template_used = "text",
    data_qc_complete = "text",
    general_sampling_comments = "text"
  )

  col_types[intersect(names(col_types), names(x))]
}

sample_station_info_fields <- function(x) {
  col_types <- c(
    study_area_name = "text",
    study_area_photos = "text",
    sample_station_label = "text",
    utm_zone_sample_station = "numeric",
    easting_sample_station = "numeric",
    northing_sample_station = "numeric",
    latitude_sample_station_dd = "numeric",
    longitude_sample_station_dd = "numeric",
    station_status = "text",
    number_of_cameras = "numeric",
    set_date = "text",
    general_location = "text",
    elevation_m = "numeric",
    slope_percent = "numeric",
    aspect_degrees = "numeric",
    crown_closure_percent = "numeric",
    camera_bearing_degrees = "numeric",
    camera_height_cm = "numeric",
    distance_to_feature_m = "numeric",
    visible_range_m = "numeric",
    habitat_feature = "text",
    lock = "text",
    code = "text",
    sample_station_comments = "text",
    sample_station_photos = "text",
    site_description_comments = "text",
    site_description_date = "date",
    access_notes = "text"
  )

  col_types[intersect(names(col_types), names(x))]
}


parse_cam_setup_checks_fields <- function(x) {
  dplyr::mutate(
    x,
    dplyr::across(dplyr::contains("date"), .fns = excel_to_date),
    dplyr::across(
      c("time_checked", "start_time", "end_time", "timelapse_time"),
      .fns = excel_to_time
    ),
    date_time_checked = combine_dt_tm(.data$date_checked, .data$time_checked),
    sampling_start = combine_dt_tm(.data$sampling_start_date, .data$start_time),
    sampling_end = combine_dt_tm(.data$sampling_end_date, .data$end_time),
    .after = "surveyors"
  ) %>%
    dplyr::mutate(
      timelapse_time = format(.data$timelapse_time, "%H:%M:%S")
    ) %>%
    dplyr::select(
      -c("date_checked", "time_checked", "sampling_start_date", "start_time",
         "sampling_end_date", "end_time")
    )
}

excel_to_date <- function(x) {
  formats <- c("%d-%b-%Y", "%d/%b/%Y")

  # Fist convert date-ish characters to date
  out_dateish <- suppressWarnings(lubridate::as_date(x, format = formats))
  dateish <- !is.na(out_dateish)

  # Then try numerics
  numberish <- !is.na(suppressWarnings(as.numeric(x)))
  out_numberish <- lubridate::as_date(
    as.numeric(x[numberish]),
    origin = excel_origin()
  )

  # Instantiate an empty POSIXct vector to hold the results
  out_dt <- lubridate::POSIXct(length(x))
  out_dt[] <- NA_real_

  # Fill in the elements from above
  out_dt <- out_dateish
  out_dt[numberish] <- out_numberish
  out_dt
}

excel_to_time <- function(x) {
  timeish <- grepl("[0-9]:[0-9]", x)
  out_timeish <- lubridate::as_datetime(paste0(excel_origin(), x[timeish]))

  numberish <- !is.na(suppressWarnings(as.numeric(x)))
  out_numberish <- lubridate::as_datetime(excel_origin()) +
    as.numeric(x[numberish]) * 24 * 3600

  # Instantiate an empty POSIXct vector to hold the results
  out_dt <- lubridate::POSIXct(length(x))
  out_dt[] <- NA_real_

  # Fill in the elements from above
  out_dt[timeish] <- out_timeish
  out_dt[numberish] <- out_numberish
  out_dt
}

excel_origin <- function() "1899-12-30"

combine_dt_tm <- function(dt, tm) {
  tm_char <- format(tm, "%H:%M:%S")
  lubridate::ymd_hms(paste(as.character(dt), tm_char), quiet = TRUE)
}

to_sf <- function(x, ...) {

  x_utm <- dplyr::filter(
    x,
    !is.na(.data$utm_zone_sample_station),
    !is.na(.data$easting_sample_station),
    !is.na(.data$northing_sample_station)
  )

  if (nrow(x_utm) > 0) {
    x_utm <- bcmaps::utm_convert(
      x_utm,
      easting = "easting_sample_station",
      northing = "northing_sample_station",
      zone = "utm_zone_sample_station",
      crs = "EPSG:4326",
      xycols = FALSE
    )
  }

  x_ll <- dplyr::filter(
    x,
    !is.na(.data$latitude_sample_station_dd),
    !is.na(.data$longitude_sample_station_dd)
  )

  if (nrow(x_ll) > 0) {
    x_ll <- sf::st_as_sf(
      x_ll,
      coords = c("longitude_sample_station_dd", "latitude_sample_station_dd"),
      crs = "EPSG:4326",
      remove = FALSE
    )
  }

  n_invalid_rows <- nrow(x) - (nrow(x_utm) + nrow(x_ll))
  if (n_invalid_rows > 0) {
    warning("Data has some entries with missing or invalid UTMs or Lat/Lon values",
            call. = FALSE)
  }

  dplyr::bind_rows(Filter(\(x) nrow(x) > 0, list(x_utm, x_ll)))
}

