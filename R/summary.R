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
  cli::cat_boxx(object$study_area_name[1], "Study Area")
  cli::cli_alert_info(c(
    "{.val {length(unique(object$sample_station_label))}}",
    " sample station{?s} in {.val {nrow(object)}} location{?s}."
  ))
  if ("spatial_outlier" %in% names(object)) {
    n_outliers <- sum(as.numeric(object$spatial_outlier))
    cli::cli_alert_warning(
      "Detected {.val {n_outliers}} potential spatial outlier{?s}."
    )
  }
  cli::cli_alert_info(
    "Station status summary:"
  )
  cli::cat_boxx(
    knitr::kable(
      table(object$station_status, useNA = "ifany"),
      col.names = c("Status", "n"),
      row.names = FALSE),
    padding = 0
  )
  cli::cli_alert_info("Set dates: Between {.val {range(object$set_date)}}")
}
