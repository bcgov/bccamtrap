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

#' Create a spatial data frame of deployments
#'
#' Merge data from "Sample Station Info", "Camera Information",  and "Camera
#' Setup and Checks" tabs to create deployments - the time that a camera was
#' deployed and running at a site. "Invalid" deployments are flagged when there
#' is no sampling end date in "Camera Setup and Checks" or the sampling period
#' is 0 days
#'
#' @inheritParams read_sample_station_info
#'
#' @return a spatial data.frame (`sf`) of deployments
#' @export
make_deployments <- function(path, as_sf = TRUE) {
  csc <- read_cam_setup_checks(path)
  ss <- read_sample_station_info(path, as_sf = as_sf)
  ci <- read_camera_info(path, as_sf = FALSE)

  csc <- dplyr::filter(csc, .data$visit_type != "Deployment")

  # sample session starts when deployment starts
  csc$deployment_start <- csc$sampling_start

  # Make the *deployment* end be when the card was pulled.
  # Session end manually set in sampling_end
  csc$deployment_end <- csc$date_time_checked

  ci <- dplyr::select(
    ci,
    "wlrs_project_name",
    "study_area_name",
    sample_station_label = "parent_sample_station_label",
    camera_make = "make_of_camera_code",
    camera_model = "model_of_camera"
  )

  ci <- dplyr::distinct(ci)

  # csc <- dplyr::select(
  #   csc,
  #   "study_area_name",
  #   "sample_station_label",
  #   # "camera_label",
  #   "deployment_label",
  #   "date_time_checked", # _set and _check
  #   "deployment_start", # date_set
  #   "deployment_end", # date_set
  #   "surveyors", # _set and _check
  #   "battery_level", # _set and _check
  #   "batteries_changed", # _set only
  #   "camera_status_on_arrival", # camera_status _set and _check
  #   "visit_type", # _set and _check
  #   "sd_downloaded_y_n", # sd_removed
  #   "number_of_photos",
  #   "quiet_period_s",
  #   "trigger_sensitivity",
  #   "trigger_timing_s",
  #   "photos_per_trigger",
  #   "video_length_per_trigger_s",
  #   "timelapse_photos",
  #   "timelapse_time",
  #   "time_zone",
  #   "camera_visit_comments"
  # )
  #
  # ss <- dplyr::select(
  #   ss,
  #   "study_area_name",
  #   "sample_station_label",
  #   "utm_zone_sample_station",
  #   "easting_sample_station",
  #   "northing_sample_station",
  #   "latitude_sample_station_dd",
  #   "longitude_sample_station_dd",
  #   "station_status",
  #   "set_date",
  #   "elevation_m":"habitat_feature",
  #   "site_description_date"
  # )

  # temporary variable for joining, since
  csc$deployment_start_date <- as.Date(csc$deployment_start)

  ci_ss <- dplyr::left_join(
    ss, ci,
    by = c("wlrs_project_name", "study_area_name", "sample_station_label")
  )

  ret <- dplyr::left_join(
    csc,
    ci_ss,
    by = dplyr::join_by(
      "wlrs_project_name",
      "study_area_name",
      "sample_station_label",
      # Join it to the most recent location, in case a sample station has moved
      # and thus multiple rows for a station in sample station info sheet
      closest("deployment_start_date" >= "set_date")
    )
  )

  ret <- dplyr::select(ret, -"deployment_start_date", -"sampling_start")
  ret <- make_deployment_validity_columns(ret)

  if (inherits(ss, "sf")) {
    sf::st_geometry(ret) <- attr(ss, "sf_column")
  }

  as.deployments(ret, "spi-sheet")
}

make_deployment_validity_columns <- function(x) {
  x <- dplyr::mutate(
    x,
    deployment_duration_days = lubridate::interval(
      as.Date(.data$deployment_start),
      as.Date(.data$deployment_end)
    ) / lubridate::ddays(1),
    deployment_duration_valid = !is.na(.data$deployment_duration_days) &
      !is.na(.data$deployment_end) &
      if ("sampling_end" %in% names(x)) {
        !is.na(.data$sampling_end)
      } else {
        TRUE
      } &
      .data$deployment_duration_days > 0
  )
  dplyr::relocate(
    x,
    dplyr::starts_with("deployment_duration"),
    .after = "deployment_end"
  )
}

#' Identify distinct sample sessions from timelapse image data
#'
#' For each deployment label, this function:
#' - Sets sampling_start as first image date
#' - Counts photos (total, and motion-detection)
#' - Determines gaps in sampling period due to obscured lens
#' - Determines total length of sample period (number of days with Time Lapse photos - number of days with lens obscured)
#'
#'
#' @inheritParams qa_image_data
#' @param sample_start_date a custom start date. Note that this will apply the
#'   same start date to all deployments/sessions in the data.
#' @param sample_end_date a custom end date. Note that this will apply the same
#'   start date to all deployments/sessions in the data.
#'
#' @return a data.frame of class `sample_sessions` with one row (sample session) per deployment
#' @export
make_sample_sessions <- function(image_data, sample_start_date = NULL, sample_end_date = NULL) {

  dat <- dplyr::mutate(
    image_data,
    trigger_mode = ifelse(grepl("^[Mm]", .data$trigger_mode), "motion", "timelapse")
  )

  dat <- filter_start_end(dat, sample_start_date, sample_end_date)

  dat <- dplyr::group_by(
    dat,
    dplyr::across(c("study_area_name", "sample_station_label", "deployment_label"))
  )

  out <- dplyr::summarize(
    dat,
    sample_start_date = as.Date(min(.data$date_time, na.rm = TRUE)),
    sample_end_date = as.Date(max(.data$date_time, na.rm = TRUE)),
    n_photos = dplyr::n(),
    n_photos_spp_id = sum(.data$total_count_episode > 0, na.rm = TRUE),
    n_species = dplyr::n_distinct(.data$species, na.rm = TRUE),
    n_individuals = sum(.data$total_count_episode, na.rm = TRUE),
    n_motion_photos = sum(.data$trigger_mode == "motion", na.rm = TRUE),
    n_motion_photos_lens_obscured = sum(
      .data$trigger_mode == "motion" & .data$lens_obscured,
      na.rm = TRUE
    ),
    n_tl_photos = sum(.data$trigger_mode == "timelapse", na.rm = TRUE),
    n_tl_photos_lens_obscured = sum(
      .data$trigger_mode == "timelapse" & .data$lens_obscured,
      na.rm = TRUE
    ),
    sample_gaps = .data$n_tl_photos_lens_obscured > 0,,
    trap_days = .data$n_tl_photos - .data$n_tl_photos_lens_obscured,
    .groups = "drop"
  )

  as.sample_sessions(out)
}

filter_start_end <- function(x, sample_start_date, sample_end_date) {
  if (!is.null(sample_start_date)) {
    x <- dplyr::filter(
      x,
      .data$date_time >= lubridate::as_datetime(paste(sample_start_date, "00:00:00"))
    )
  }

  if (!is.null(sample_end_date)) {
    x <- dplyr::filter(
      x,
      .data$date_time <= lubridate::as_datetime(paste(sample_end_date, "23:59:59"))
    )
  }
  x
}
