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

make_sample_sessions <- function(path, as_sf = TRUE) {
  csc <- read_cam_setup_checks(path)
  ss <- read_sample_station_info(path, as_sf = as_sf)

  csc <- dplyr::mutate(csc, sample_start_date = as.Date(.data$sampling_start))
  csc <- dplyr::filter(csc, .data$visit_type != "Deployment")

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

  ret <- dplyr::left_join(
    csc,
    ss,
    by = dplyr::join_by(
      "study_area_name",
      "sample_station_label",
      # Join it to the most recent location
      closest("sample_start_date" >= "set_date")
    )
  )

  ret <- dplyr::select(ret, -"sample_start_date")
  ret <- dplyr::mutate(
    ret,
    sample_duration_days = lubridate::interval(
      .data$sampling_start,
      .data$sampling_end
    ) / lubridate::ddays(1),
    sample_duration_valid = !is.na(.data$sample_duration_days) &
      .data$sample_duration_days > 0
  )
  ret <- dplyr::relocate(
    ret,
    dplyr::starts_with("sample_duration"),
    .after = "sampling_end"
  )

  if (inherits(ss, "sf")) {
    sf::st_geometry(ret) <- attr(ss, "sf_column")
  }

  as.sample_sessions(ret)
}
