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
  cli::cat_boxx("Sample Stations", object$study_area_name[1], col = "lightblue")
  cli::cli_alert_info(c(
    "{.val {length(unique(object$sample_station_label))}}",
    " sample station{?s} in {.val {nrow(object)}} location{?s}."
  ))
  cli::cat_line("")
  cli::cli_alert_info(
    "Summary of station distances (m):"
  )
  print(summarize_distances(object))
  if ("spatial_outlier" %in% names(object)) {
    n_outliers <- sum(as.numeric(object$spatial_outlier))
    cli::cli_alert_danger(
      "Detected {.val {n_outliers}} potential spatial outlier{?s}."
    )
  }
  cli::cat_line("")
  cli::cli_alert_info(
    "Station status summary:"
  )
  table_print_helper(object$station_status)
  cli::cat_line("")
  cli::cli_alert_info("Set dates: Between {.val {range(object$set_date, na.rm = TRUE)}}")
  cli::cat_line("")
  cli::cli_alert_warning("Run {.code map_stations(object)} to view stations on a map.")
}

#' @export
summary.sample_sessions <- function(object, ...) {
  cli::cat_boxx("Sample Sessions", object$study_area_name[1], col = "lightgreen")
  cli::cli_alert_info(c(
    "{.val {length(unique(object$sample_station_label))}}",
    " sample station{?s} in {.val {length(unique(object$deployment_label))}} deployments{?s}."
  ))
  dep_dur_range <- round(range(object$sample_duration_days, na.rm = TRUE))
  n_invalid_samples <- sum(!object$sample_duration_valid, na.rm = TRUE)
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
  table_print_helper(object$camera_status_on_arrival)
  n_photos_range <- range(object$number_of_photos, na.rm = TRUE)
  cli::cli_alert_info(c(
    "There are {.val {sum(object$number_of_photos, na.rm = TRUE)}} images. ",
    "Photos per session range betwen {.val {n_photos_range}}."
  ))
}

#' @export
summary.image_data <- function(object, ...) {
  cli::cat_boxx("Image summary", object$study_area_name[1], col = "pink")

  cli::cli_alert_info(c(
    "{.val {nrow(object)}} images in ",
    "{.val {length(unique(object$deployment_label))}} deployments at ",
    "{.val {length(unique(object$sample_station_label))}} sample stations."
  ))

  cli::cli_alert_info(
    "{.val {sum(object$lens_obscured, na.rm = TRUE)}} images with lens obscured."
  )

  cli::cli_alert_info(
    "{.val {sum(object$needs_review, na.rm = TRUE)}} images starred."
  )

  cli::cli_alert_warning(
    "{.val {sum(object$needs_review, na.rm = TRUE)}} images flagged for review."
  )

  cli::cli_alert_info(
    "Dates are between {.val {range(as.Date(object$date_time), na.rm = TRUE)}}."
  )

  cli::cli_alert_info(
    "Temperatures are between {.val {range(object$temperature, na.rm = TRUE)}} C."
  )

  cli::cli_alert_info(
    "Snow depths are between {.val {range(object$snow_depth_lower, na.rm = TRUE)}} cm."
  )

  cli::cli_alert_info("Species counts:")
  table_print_helper(object$species)

  cli::cat_line("")
  cli::cli_alert_warning(
    "Run {.fn check_deployment_images} to crosscheck images with deployments."
  )
}

table_print_helper <- function(x, ...) {
  print(table(x, useNA = "ifany", dnn = NULL), na.print = "NA", ...)
}
