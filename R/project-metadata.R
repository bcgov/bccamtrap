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

open_project <- function(path) {
}

read_project_info <- function(path, ...) {
  readxl::read_excel(
    path,
    sheet = "Project Information",
    col_types = "text",
    .name_repair = janitor::make_clean_names,
    ...
  )
}

read_sample_station_info <- function(path, ...) {
  readxl::read_excel(
    path,
    sheet = "Sample Station Information",
    col_types = c(
      rep("text", 3),
      rep("numeric", 5),
      "text",
      "numeric",
      "date",
      "text",
      rep("numeric", 8),
      rep("text", 6),
      "date",
      "text"
    ),
    na = c("NA", "N/A", ""),
    .name_repair = janitor::make_clean_names,
    ...
  )

  # Read and join relevant info from Camera Information tab
}

read_cam_setup_checks <- function(path, ...) {

  header <- readxl::read_excel(
    path,
    sheet = "Camera Setup and Checks",
    col_types = "text",
    n_max = 1,
    .name_repair = janitor::make_clean_names,
    ...
  )

  col_types <- cam_setup_checks_fields(header)

  raw_inp <- readxl::read_excel(
    path,
    sheet = "Camera Setup and Checks",
    col_types = col_types,
    na = c("NA", "N/A", ""),
    .name_repair = janitor::make_clean_names,
    ...
  )
  parse_cam_setup_checks_fields(raw_inp)
}

cam_setup_checks_fields <- function(x) {
  col_types <- c(
    study_area_name = "text",
    sample_station_label = "text",
    deployment_label = "text",
    camera_label = "text",
    surveyors = "text",
    date_checked = "text",
    time_checked = "date",
    sampling_start_date = "text",
    start_time = "date",
    sampling_end_date = "text",
    end_time = "date",
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
    timelapse_time = "date",
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

parse_cam_setup_checks_fields <- function(x) {
  dplyr::mutate(x, dplyr::across(dplyr::contains("date"), .fns = excel_to_date))
}

excel_to_date <- function(x) {
  excel_origin <- "1899-12-30"
  formats <- c("%d-%b-%Y", "%d/%b/%Y")

  # Fist convert date-ish characters to date
  out_date <- suppressWarnings(lubridate::as_date(x, format = formats))

  # Then try numerics
  numeric_dates <- as.numeric(x[is.na(out_date)])
  parsed_numeric_dates <- lubridate::as_date(numeric_dates, origin = excel_origin)

  # Fill them in
  out_date[is.na(out_date)] <- parsed_numeric_dates
  out_date
}

