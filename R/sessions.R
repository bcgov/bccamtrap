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
#' Merge data from "Sample Station Info" and "Camera Setup and Checks" tabs to
#' create deployments - the time that a camera was deployed and running
#' at a site. "Invalid" deployments are flagged when there is no sampling end date
#' in "Camera Setup and Checks" or the sampling period is 0 days
#'
#' @inheritParams read_sample_station_info
#'
#' @return a spatial data.frame (`sf`) of deployments
#' @export
make_deployments <- function(path, as_sf = TRUE) {
  csc <- read_cam_setup_checks(path)
  ss <- read_sample_station_info(path, as_sf = as_sf)

  csc <- dplyr::filter(csc, .data$visit_type != "Deployment")

  # sample session starts when deployment starts
  csc$deployment_start <- csc$sampling_start

  # Make the *deployment* end be when the card was pulled.
  # Session end manually set in sampling_end
  csc$deployment_end <- csc$date_time_checked

  # TODO: Decide what columns we want to keep in both datasets
  # csc <- dplyr::select(
  #   csc,
  #   "study_area_name",
  #   "sample_station_label",
  #   "deployment_label",
  #   dplyr::contains("date"),
  #   dplyr::contains("start"),
  #   dplyr::contains("end")
  # )

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
  #   "geometry"
  # )


  # temporary variable for joining, since
  csc$deployment_start_date <- as.Date(csc$deployment_start)

  ret <- dplyr::left_join(
    csc,
    ss,
    by = dplyr::join_by(
      "study_area_name",
      "sample_station_label",
      # Join it to the most recent location, in case a sample station has moved
      # and thus multiple rows for a station in sample station info sheet
      closest("deployment_start_date" >= "set_date")
    )
  )

  ret <- dplyr::select(ret, -"deployment_start_date", -"date_time_checked")
  ret <- dplyr::mutate(
    ret,
    deployment_duration_days = lubridate::interval(
      .data$deployment_start,
      .data$deployment_end
    ) / lubridate::ddays(1),
    deployment_duration_valid = !is.na(.data$deployment_duration_days) &
      !is.na(.data$deployment_end) &
      .data$deployment_duration_days > 0
  )
  ret <- dplyr::relocate(
    ret,
    dplyr::starts_with("deployment_"),
    .before = "sampling_start"
  )

  if (inherits(ss, "sf")) {
    sf::st_geometry(ret) <- attr(ss, "sf_column")
  }

  as.deployments(ret)
}
