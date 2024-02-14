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

#' @export
summary.sample_station_info <- function(object, ...) {
  cli::cat_boxx(object$study_area_name[1], "Study Area", col = "lightgreen")
  cli::cli_alert_info(c(
    "{.val {length(unique(object$sample_station_label))}}",
    " sample station{?s} in {.val {nrow(object)}} location{?s}."
  ))
  if ("spatial_outlier" %in% names(object)) {
    n_outliers <- sum(as.numeric(object$spatial_outlier))
    cli::cli_alert_danger(
      "Detected {.val {n_outliers}} potential spatial outlier{?s}."
    )
  }
  cli::cli_alert_info(
    "Station status summary:"
  )
  summary_table_helper(object$station_status)
  cli::cli_alert_info("Set dates: Between {.val {range(object$set_date)}}")
  cli::cli_alert_warning("Run {.code map_stations(object)} to view stations on a map.")
}

#' @export
summary.sample_sessions <- function(object, ...) {
  cli::cat_boxx(object$study_area_name[1], "Study Area", col = "lightgreen")
  cli::cli_alert_info(c(
    "{.val {length(unique(object$sample_station_label))}}",
    " sample station{?s} in {.val {length(unique(object$deployment_label))}} deployments{?s}."
  ))
  dep_dur_range <- round(range(object$sample_duration_days, na.rm = TRUE))
  n_invalid_samples <- sum(!object$sample_duration_valid)
  cli::cli_alert_info(
    "Sample sessions lengths range between {.val {dep_dur_range}} days."
  )
  if (sum(n_invalid_samples) > 0) {
    cli::cli_alert_danger(
    "There {?is/are} {.val {n_invalid_samples}} invalid sample session{?s}."
    )
  }
  cli::cli_alert_info(
    "Camera status on arrival summary:"
  )
  summary_table_helper(object$camera_status_on_arrival)
  n_photos_range <- range(object$number_of_photos, na.rm = TRUE)
  cli::cli_alert_info(c(
    "There are {.val {sum(object$number_of_photos)}} images. ",
    "Photos per session range betwen {.val {n_photos_range}}."
  ))
}

summary_table_helper <- function(x, col_names = c("Status", "n")) {
  cli::cat_boxx(
    knitr::kable(
      table(x, useNA = "ifany"),
      col.names = col_names,
      row.names = FALSE),
    padding = 0
  )
}
