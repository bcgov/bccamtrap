read_sample_station_csv <- function(path, as_sf = TRUE) {

  spec <- sample_station_csv_spec("readr_spec")
  ssi <- readr::read_csv(path, col_types = spec)

  if (as_sf) {
    ssi <- sf::st_as_sf(ssi, coords = c("x", "y"), crs = 4326, remove = FALSE)
  }

  spi_names <- invert(sample_station_csv_spec("spi_name"))
  out <- dplyr::rename(ssi, dplyr::any_of(spi_names))

  as.sample_station_info(out)
}

read_deployments_csv <- function(path, as_sf = TRUE) {
  spec <- deployments_csv_spec("readr_spec")
  deployments <- readr::read_csv(path, col_types = spec)

  spi_names <- invert(deployments_csv_spec("spi_name"))
  deployments <- dplyr::select(deployments, dplyr::any_of(spi_names))

  if (as_sf) {
    deployments <- sf::st_as_sf(
      deployments,
      coords = c("longitude", "latitude"),
      crs = 4326,
      remove = FALSE
    )
  }

  as.deployments(deployments)
}

deployments_csv_spec <- function(what = c("readr_spec", "spi_name")) {
  what = match.arg(what)
  x <- list(
    OBJECTID = list(
      readr_spec = readr::col_skip(),
      spi_name = "objectid"
    ),
    Station_ID = list(
      readr_spec = readr::col_character(),
      spi_name = "station_id"
    ),
    Deployment_ID = list(
      readr_spec = readr::col_character(),
      spi_name = "deployment_id"
    ),
    Longitude = list(
      readr_spec = readr::col_double(),
      spi_name = "longitude"
    ),
    Latitude = list(
      readr_spec = readr::col_double(),
      spi_name = "latitude"
    ),
    Date_Set = list(
      readr_spec = readr::col_datetime("%m/%d/%Y %H:%M:%S %p"),
      spi_name = "date_set"
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
      spi_name = "time_zone_set"
    ),
    Time_lapse_Start_Set = list(
      readr_spec = readr::col_time(format = ""),
      spi_name = "time_lapse_start_set"
    ),
    Time_lapse_End_Set = list(
      readr_spec = readr::col_time(format = ""),
      spi_name = "time_lapse_end_set"
    ),
    Time_lapse_Interval_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "time_lapse_interval_set"
    ),
    Video_Length_Per_Trigger_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "video_length_per_trigger_set"
    ),
    Photos_Per_Trigger_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "photos_per_trigger_set"
    ),
    Trigger_Timing_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "trigger_timing_set"
    ),
    Trigger_Sensitivity_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "trigger_sensitivity_set"
    ),
    Quiet_Period_Set = list(
      readr_spec = readr::col_double(),
      spi_name = "quiet_period_set"
    ),
    Camera_Visit_Comments_Set = list(
      readr_spec = readr::col_character(),
      spi_name = "camera_visit_comments_set"
    ),
    Form_Status = list(
      readr_spec = readr::col_character(),
      spi_name = "form_status"
    ),
    Date_Check = list(
      readr_spec = readr::col_datetime("%m/%d/%Y %H:%M:%S %p"),
      spi_name = "date_check"
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
    Project_ID = list(
      readr_spec = readr::col_character(),
      spi_name = "project_id"
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
