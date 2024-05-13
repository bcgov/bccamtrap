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
  ret <- read_sheet_impl_(
    path,
    sheet = "Project Information",
    col_types = "text",
    ...
  )
  as.project_info(ret)
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
  )
  ss_info <- dplyr::mutate(
    ss_info,
    set_date = excel_to_date(.data$set_date)
  )

  ss_info <- add_project_name_from_spi_sheet(path, ss_info)

  ss_info <- as.sample_station_info(ss_info, "spi-sheet")
  if (as_sf) {
    ss_info <- to_sf(ss_info, subclass = "spi-sheet")
  }
  ss_info
}

#' Read the "Camera Information" tab from the RISC worksheet.
#'
#' This will read in the camera information from a RISC worksheet following the
#' 'v20230518' template
#'
#' @inheritParams read_sample_station_info
#'
#' @return a `data.frame` of station information, as an `sf` object if specified.
#' @export
read_camera_info <- function(path, as_sf = TRUE, ...) {

  sheet <- "Camera Information"
  header <- read_sheet_impl_(path, sheet, col_types = "text", n_max = 0)
  col_types <- camera_info_fields(header)

  cam_info <- read_sheet_impl_(
    path,
    sheet = sheet,
    col_types = col_types,
    ...
  )

  cam_info <- dplyr::mutate(
    cam_info,
    site_description_date = excel_to_date(.data$site_description_date)
  )

  cam_info <- add_project_name_from_spi_sheet(path, cam_info)

  cam_info <- as.camera_info(cam_info)

  if (as_sf) {
    cam_info <- to_sf(cam_info, sublass = "spi-sheet")
  }
  cam_info
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

  ret <- parse_cam_setup_checks_fields(raw_inp)

  ret <- add_project_name_from_spi_sheet(path, ret)

  as.cam_setup_checks(ret)
}

read_sheet_impl_ <- function(path, sheet, col_types, ...) {
  if (!file.exists(path)) {
    cli::cli_abort("RISC worksheet {.path {path}} does not exist.")
  }
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

  finalize_col_spec(names(x), col_types)
}

camera_info_fields <- function(x) {
  col_types <- c(
    study_area_name = "text",
    parent_sample_station_label = "text",
    camera_label = "text",
    utm_zone_camera = "numeric",
    easting_camera = "numeric",
    northing_camera = "numeric",
    latitude_camera_dd = "numeric",
    longitude_camera_dd = "numeric",
    make_of_camera_code = "text",
    model_of_camera = "text",
    camera_comments = "text",
    site_description_comments = "text",
    site_description_date = "text"
  )

  finalize_col_spec(names(x), col_types)
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

  finalize_col_spec(names(x), col_types)

}

finalize_col_spec <- function(data_cols, col_spec) {
  col_names <- names(col_spec)
  spec_miss <- setdiff(data_cols, col_names)
  if (length(spec_miss) > 0) {
    cli::cli_alert_warning("Unexpected column{?s} in data: {.val {spec_miss}}")
    spec_miss <- stats::setNames("skip", spec_miss)
  }

  data_miss <- setdiff(col_names, data_cols)
  if (length(data_miss) > 0) {
    cli::cli_alert_warning("Data is missing expected column{?s}: {.val {data_miss}}")
  }

  c(col_spec[intersect(col_names, data_cols)], spec_miss)
}


parse_cam_setup_checks_fields <- function(x) {
  ret <- dplyr::mutate(
    x,
    dplyr::across(dplyr::contains("date"), .fns = excel_to_date),
    dplyr::across(
      c("time_checked", "start_time", "end_time", "timelapse_time"),
      .fns = excel_to_time
    ),
    date_time_checked = combine_date_time(.data$date_checked, .data$time_checked),
    sampling_start = combine_date_time(.data$sampling_start_date, .data$start_time),
    sampling_end = combine_date_time(.data$sampling_end_date, .data$end_time),
    .after = "surveyors"
  )

  ret$timelapse_time = readr::parse_time(format(ret$timelapse_time, "%H:%M:%S"))

  dplyr::select(
    ret,
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
  out_dt[] <- out_dateish
  out_dt[numberish] <- out_numberish
  lubridate::as_datetime(out_dt)
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

combine_date_time <- function(dt, tm) {
  dt_char <- format(dt, "%Y-%m-%d")
  time_char <- format(tm, "%H:%M:%S")
  lubridate::ymd_hms(paste(dt_char, time_char), quiet = TRUE, truncated = 3)
}

#' Convert Sample Station Info or Camera Info to a spatial `sf` boject
#' #'
#' @param x Object of class `sample_station_info` or `camera_info`
#' @param ... arguments passed on to [sf::st_as_sf()]
#'
#' @return input as a an `sf` object
#' @export
to_sf <- function(x, ...) {
  UseMethod("to_sf")
}

#' @export
to_sf.default <- function(x, ...) {
  cli::cli_abort("No method defined for object of class {class(x)}")
}

#' @export
to_sf.camera_info <- function(x, ...) {
  out <- to_sf_impl_(x, type = "camera")
  as.camera_info(out, ...)
}

#' @export
to_sf.sample_station_info <- function(x, ...) {
  out <- to_sf_impl_(x, type = "sample_station")
  as.sample_station_info(out, ...)
}

to_sf_impl_ <- function(x, type = c("camera", "sample_station")) {

  type <- match.arg(type)
  zone_col <- paste0("utm_zone_", type)
  easting_col <- paste0("easting_", type)
  northing_col <- paste0("northing_", type)
  lat_col <- paste0("latitude_", type, "_dd")
  lon_col <- paste0("longitude_", type, "_dd")

  x <- sf::st_as_sf(
    x,
    geometry = sf::st_sfc(
      lapply(seq_len(nrow(x)), function(x) sf::st_point()),
      crs = "EPSG:4326"
    ),
    remove = FALSE
  )

  # Convert the utms to sf
  utm_rows <- !is.na(x[[zone_col]]) &
    !is.na(x[[easting_col]]) &
    !is.na(x[[northing_col]])
  if (any(utm_rows)) {

    x_utm <- bcmaps::utm_convert(
      sf::st_drop_geometry(x[utm_rows, ]),
      easting = easting_col,
      northing = northing_col,
      zone = zone_col,
      crs = "EPSG:4326",
      xycols = FALSE
    )

    # update the columns in x with geom from utms
    sf::st_geometry(x[utm_rows, ]) <- sf::st_geometry(x_utm)
  }

  # convert the lat/lons to sf
  ll_rows <- !is.na(x[[lat_col]]) & !is.na(x[[lon_col]])
  if (any(ll_rows)) {
    if (any(x[[lat_col]][!is.na(x[[lat_col]])] < 0) ||
        any(x[[lon_col]][!is.na(x[[lon_col]])] > 0)) {
      cli::cli_warn("It looks like you have latitude and longitude columns switched.")
    }
    x_ll <- sf::st_as_sf(
      sf::st_drop_geometry(x[ll_rows, ]),
      coords = c(lon_col, lat_col),
      crs = "EPSG:4326",
      remove = FALSE
    )
    # If all rows have good lat/lon data, just use that
    if (nrow(x_ll) == nrow(x)) {
      return(x_ll)
    }

    # update the columns in x with geom from lat/lons
    # prefer lats and lons, so we overwrite those from utms if they are there
    sf::st_geometry(x[ll_rows, ]) <- sf::st_geometry(x_ll)
  }

  if (any(sf::st_is_empty(x))) {
    cli::cli_warn("Data has entries with missing or invalid UTMs or Lat/Lon values")
  }

  x
}

add_project_name_from_spi_sheet <- function(path, data) {
  proj_info <- read_project_info(path)
  proj_name <- proj_info$project_name[1]

  dplyr::mutate(data, wlrs_project_name = proj_name, .before = 1)
}
