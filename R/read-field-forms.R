#' Read csv output from sample station field form
#'
#' @param path path to the csv file exported from the field form
#' @param wlrs_project_name If you want to subset to a particular project or projects,
#'   supply the WLRS Project Names(s) as a character vector. If `NULL` (the default),
#'   reads all rows in the csv.
#' @inheritParams read_sample_station_info
#'
#' @return a data.frame (sf object if `as_sf = TRUE`) containing sample station csv contents
#' @export
read_sample_station_csv <- function(path, wlrs_project_name = NULL, as_sf = TRUE) {

  spec <- sample_station_csv_spec("readr_spec")
  ssi <- readr::read_csv(path, col_types = spec, lazy = TRUE)


  spi_names <- invert(sample_station_csv_spec("spi_name"))
  ssi <- dplyr::rename(ssi, dplyr::any_of(spi_names))

  if (!is.null(wlrs_project_name)) {
    check_project_name(ssi, wlrs_project_name)
    ssi <- filter(ssi, .data$wlrs_project_name %in% wlrs_project_name)
  }

  if (as_sf) {
    ssi <- sf::st_as_sf(
      ssi,
      coords = c("longitude_sample_station_dd", "latitude_sample_station_dd"),
      crs = 4326,
      remove = FALSE
    )
  }

  as.sample_station_info(ssi)
}

#' Read csv output from deployments field form
#'
#' @inheritParams read_sample_station_csv
#'
#' @return a data.frame (sf object if `as_sf = TRUE`) containing deployments csv contents
#' @export
read_deployments_csv <- function(path, wlrs_project_name = NULL, as_sf = TRUE) {
  spec <- deployments_csv_spec("readr_spec")
  deployments <- readr::read_csv(path, col_types = spec, lazy = TRUE)


  spi_names <- invert(deployments_csv_spec("spi_name"))
  deployments <- dplyr::select(deployments, dplyr::any_of(spi_names))

  if (!is.null(wlrs_project_name)) {
    check_project_name(deployments, wlrs_project_name)
    deployments <- filter(deployments, .data$wlrs_project_name %in% wlrs_project_name)
  }

  if (as_sf) {
    deployments <- sf::st_as_sf(
      deployments,
      coords = c("longitude_sample_station_dd", "latitude_sample_station_dd"),
      crs = 4326,
      remove = FALSE
    )
  }

  deployments <- make_deployment_validity_columns(deployments)

  as.deployments(deployments)
}

deployments_csv_spec <- function(what = c("readr_spec", "spi_name")) {
  what = match.arg(what)
  x <- list(
    OBJECTID = list(
      readr_spec = readr::col_skip(),
      spi_name = "objectid"
    ),
    WLRS_Project_Name = list(
      readr_spec = readr::col_character(),
      spi_name = "wlrs_project_name"
    ),
    Station_ID = list(
      readr_spec = readr::col_character(),
      spi_name = "sample_station_label"
    ),
    Deployment_ID = list(
      readr_spec = readr::col_character(),
      spi_name = "deployment_label"
    ),
    Longitude = list(
      readr_spec = readr::col_double(),
      spi_name = "longitude_sample_station_dd"
    ),
    Latitude = list(
      readr_spec = readr::col_double(),
      spi_name = "latitude_sample_station_dd"
    ),
    Date_Set = list(
      readr_spec = readr::col_datetime("%m/%d/%Y %H:%M:%S %p"),
      spi_name = "deployment_start"
    ),
    Camera_Label = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_label"
    ),
    Camera_Make = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_make"
    ),
    Camera_Model = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_model"
    ),
    Surveyor_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "surveyor_set"
    ),
    Visit_Type_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "visit_type_set"
    ),
    Battery_Level_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "battery_level_set"
    ),
    Battery_Changed_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "battery_changed_set"
    ),
    Snow_Stake_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "snow_stake_set"
    ),
    Time_Zone_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "time_zone"
    ),
    Time_lapse_Start_Set = list(
      readr_spec = readr::col_time(format = ""),
      spi_name = "timelapse_time"
    ),
    Time_lapse_End_Set = list(
      readr_spec = readr::col_time(format = ""),
      spi_name = "time_lapse_end"
    ),
    Time_lapse_Interval_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "time_lapse_interval"
    ),
    Video_Length_Per_Trigger_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "video_length_per_trigger_s"
    ),
    Photos_Per_Trigger_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "photos_per_trigger"
    ),
    Trigger_Timing_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "trigger_timing_s"
    ),
    Trigger_Sensitivity_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "trigger_sensitivity"
    ),
    Quiet_Period_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "quiet_period_s"
    ),
    Camera_Visit_Comments_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_visit_comments"
    ),
    Form_Status = list(
      readr_spec = readr::col_character(),
      spi_name = "form_status"
    ),
    Date_Check = list(
      readr_spec = readr::col_datetime("%m/%d/%Y %H:%M:%S %p"),
      spi_name = "deployment_end"
    ),
    Visit_Type_Check = list(
      readr_spec = readr::col_character(),
      spi_name = "visit_type_check"
    ),
    Battery_Level_Check = list(
      readr_spec = readr::col_character(),
      spi_name = "battery_level_check"
    ),
    Camera_Status_Description_Check = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_status_description_check"
    ),
    Camera_Status_Check = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_status_check"
    ),
    Surveyor_Check = list(
      readr_spec = readr::col_character(),
      spi_name = "surveyor_check"
    ),
    SD_Removed_Check = list(
      readr_spec = readr::col_character(),
      spi_name = "sd_removed_check"
      ),# logical
    GlobalID = list(
      readr_spec = readr::col_skip(),
      spi_name = "globalid"
    ),
    CreationDate = list(
      readr_spec = readr::col_skip(),
      spi_name = "creationdate"
    ),
    Creator = list(
      readr_spec = readr::col_skip(),
      spi_name = "creator"
    ),
    EditDate = list(
      readr_spec = readr::col_skip(),
      spi_name = "editdate"
    ),
    Editor = list(
      readr_spec = readr::col_skip(),
      spi_name = "editor"
    )
  )

  ret <- lapply(x, `[[`, what)

  if (what == "readr_spec") {
    return(readr::as.col_spec(ret))
  }

  unlist(compact(ret))
}

sample_station_csv_spec <- function(what = c("readr_spec", "spi_name")) {
  what = match.arg(what)
  x <- list(
    OBJECTID = list(
      readr_spec = readr::col_skip(),
      spi_name = NULL
    ),
    WLRS_Project_Name = list(
      readr_spec = readr::col_character(),
      spi_name = "wlrs_project_name"
    ),
    General_Location = list(
      readr_spec = readr::col_character(),
      spi_name = "study_area_name"
    ),
    Station_ID = list(
      readr_spec = readr::col_character(),
      spi_name = "sample_station_label"
    ),
    Station_Status = list(
      readr_spec = readr::col_character(),
      spi_name = "station_status"
    ),
    Set_Date = list(
      readr_spec = readr::col_datetime("%m/%d/%Y %H:%M:%S %p"),
      spi_name = "set_date"
    ),
    Elevation = list(
      readr_spec = readr::col_double(),
      spi_name = "elevation_m"
    ),
    Slope = list(
      readr_spec = readr::col_double(),
      spi_name = "slope_percent"
    ),
    Aspect = list(
      readr_spec = readr::col_double(),
      spi_name = "aspect_degrees"
    ),
    Crown_Closure = list(
      readr_spec = readr::col_double(),
      spi_name = "crown_closure_percent"
    ),
    Camera_Bearing = list(
      readr_spec = readr::col_double(),
      spi_name = "camera_bearing_degrees"
    ),
    Camera_Height = list(
      readr_spec = readr::col_double(),
      spi_name = "camera_height_cm"
    ),
    Distance_to_Feature = list(
      readr_spec = readr::col_double(),
      spi_name = "distance_to_feature_m"
    ),
    Visible_Range = list(
      readr_spec = readr::col_double(),
      spi_name = "visible_range_m"
    ),
    Habitat_Feature = list(
      readr_spec = readr::col_character(),
      spi_name = "habitat_feature"
    ),
    Locked = list(
      readr_spec = readr::col_character(),
      spi_name = "lock"
    ),
    Code = list(
      readr_spec = readr::col_character(),
      spi_name = "code"
    ),
    Linked_Project = list(
      readr_spec = readr::col_character(),
      spi_name = "linked_project"
    ),
    Access_Notes = list(
      readr_spec = readr::col_character(),
      spi_name = "access_notes"
    ),
    Site_Description = list(
      readr_spec = readr::col_character(),
      spi_name = "site_description_comments"
    ),
    Latitude = list(
      readr_spec = readr::col_skip(),
      spi_name = NULL
    ),
    Longitude = list(
      readr_spec = readr::col_skip(),
      spi_name = NULL
    ),
    GlobalID = list(
      readr_spec = readr::col_skip(),
      spi_name = NULL
    ),
    x = list(
      readr_spec = readr::col_double(),
      spi_name = "longitude_sample_station_dd"
    ),
    y = list(
      readr_spec = readr::col_double(),
      spi_name = "latitude_sample_station_dd"
    )
  )
  ret <- lapply(x, `[[`, what)

  if (what == "readr_spec") {
    return(readr::as.col_spec(ret))
  }

  unlist(compact(ret))
}

check_project_name <- function(data, project_name, project_name_col = "wlrs_project_name",
                               arg = rlang::caller_arg(project_name), call = rlang::caller_env()) {
  if (is.null(project_name)) return(invisible(FALSE))
  projects <- unique(data[[project_name_col]])
  if (!project_name %in% projects) {
    cli::cli_abort("{.arg {arg}} is not present in the data. Choose one of: {.val {projects}}",
                   arg = arg, call = call)
  }
  invisible(TRUE)
}
