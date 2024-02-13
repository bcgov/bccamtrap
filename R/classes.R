as.project_info <- function(x, ...) {
  structure(x, class = c("cam_project_info", class(x)), ...)
}

as.sample_station_info <- function(x, ...) {
  structure(x, class = c("sample_station_info", class(x)), ...)
}

as.cam_setup_checks <- function(x, ...) {
  structure(x, class = c("cam_setup_checks", class(x)), ...)
}

as.sample_sessions <- function(x, ...) {
  structure(x, class = c("sample_sessions", class(x)), ...)
}

as.image_data <- function(x, ...) {
  structure(x, class = c("image_data", class(x)), ...)
}

