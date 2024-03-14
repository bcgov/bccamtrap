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

  csc <- dplyr::rename_with(
    csc,
    function(x) gsub("sampling_", "deployment_", x),
    .cols = dplyr::starts_with("sampling")
  )

  ci <- dplyr::select(
    ci,
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
    by = c("study_area_name", "sample_station_label")
  )

  ret <- dplyr::left_join(
    csc,
    ci_ss,
    by = dplyr::join_by(
      "study_area_name",
      "sample_station_label",
      # Join it to the most recent location, in case a sample station has moved
      # and thus multiple rows for a station in sample station info sheet
      closest("deployment_start_date" >= "set_date")
    )
  )

  ret <- dplyr::select(ret, -"deployment_start_date")
  ret <- make_deployment_validity_columns(ret)

  if (inherits(ss, "sf")) {
    sf::st_geometry(ret) <- attr(ss, "sf_column")
  }

  as.deployments(ret)
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
      .data$deployment_duration_days > 0
  )
  dplyr::relocate(
    x,
    dplyr::starts_with("deployment_duration"),
    .after = "deployment_end"
  )
}
