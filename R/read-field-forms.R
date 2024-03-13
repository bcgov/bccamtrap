read_sample_station_csv <- function(path, as_sf = TRUE) {

  spec <- sample_station_csv_spec("readr_spec")
  ssi <- readr::read_csv(path, col_types = spec)

  if (as_sf) {
    ssi <- sf::st_as_sf(ssi, coords = c("x", "y"), crs = 4326)
  }

  ssi
}

sample_station_csv_spec <- function(what = c("readr_spec", "spi_name")) {
  what = match.arg(what)
  x <- list(
    OBJECTID = list(
      readr_spec = readr::col_skip(),
      spi_name = ""
    ),
    Project_ID = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    General_Location = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Station_ID = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Station_Status = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Set_Date = list(
      readr_spec = readr::col_datetime("%m/%d/%Y %H:%M:%S %p"),
      spi_name = ""
    ),
    Elevation = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Slope = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Aspect = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Crown_Closure = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Camera_Bearing = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Camera_Height = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Distance_to_Feature = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Visible_Range = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    Habitat_Feature = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Locked = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Code = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Linked_Project = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Access_Notes = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Site_Description = list(
      readr_spec = readr::col_character(),
      spi_name = ""
    ),
    Latitude = list(
      readr_spec = readr::col_skip(),
      spi_name = ""
    ),
    Longitude = list(
      readr_spec = readr::col_skip(),
      spi_name = ""
    ),
    GlobalID = list(
      readr_spec = readr::col_skip(),
      spi_name = ""
    ),
    x = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    ),
    y = list(
      readr_spec = readr::col_double(),
      spi_name = ""
    )
  )
  ret <- lapply(x, `[[`, what)

  if (what == "readr_spec") return(readr::as.col_spec(ret))
  ret
}
