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
