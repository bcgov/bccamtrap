as.project_info <- function(x, ...) {
  structure(x, class = c("cam_project_info", class(x)), ...)
}

as.sample_station_info <- function(x, subclass, ...) {
  structure(x, class = c("sample_station_info", subclass, class(x)), ...)
}

as.camera_info <- function(x, ...) {
  structure(x, class = c("camera_info", class(x)), ...)
}

as.cam_setup_checks <- function(x, ...) {
  structure(x, class = c("cam_setup_checks", class(x)), ...)
}

as.deployments <- function(x, subclass, ...) {
  structure(
    x,
    class = c("deployments", subclass,  setdiff(class(x), "cam_setup_checks")),
    ...
  )
}

as.image_data <- function(x, ...) {
  structure(x, class = c("image_data", class(x)), ...)
}

as.sample_sessions <- function(x, ...) {
  structure(x, class = c("sample_sessions", class(x)), ...)
}


# Define classes as a subclass of sf so that it works
# with S4 methods for sf (eg mapview)
methods::setOldClass(c("deployments", "sf"))
methods::setOldClass(c("camera_info", "sf"))
methods::setOldClass(c("sample_station_info", "sf"))
methods::setOldClass(c("sample_sessions", "sf"))

## Checkers
check_project_info <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "project_info")) {
    cli::cli_abort("{.arg {arg}} must be a 'project_info' object, a result of {.fn read_project_info}",
                   arg = arg,
                   call = call)
  }
}

check_sample_station_info <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "sample_station_info")) {
    cli::cli_abort("{.arg {arg}} must be a 'sample_station_info' object, a result of {.fn read_sample_station_info}",
                   arg = arg,
                   call = call)
  }
}

check_camera_info <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "camera_info")) {
    cli::cli_abort("{.arg {arg}} must be a 'camera_info' object, a result of {.fn read_camera_info}",
                   arg = arg,
                   call = call)
  }
}

check_cam_setup_checks <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "cam_setup_checks")) {
    cli::cli_abort("{.arg {arg}} must be a 'cam_setup_checks' object, a result of {.fn read_cam_setup_checks}",
                   arg = arg,
                   call = call)
  }
}

check_deployments <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "deployments")) {
    cli::cli_abort("{.arg {arg}} must be a 'deployments' object, a result of {.fn make_deployments}",
                   arg = arg,
                   call = call)
  }
}

check_image_data <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "image_data")) {
    cli::cli_abort("{.arg {arg}} must be a 'image_data' object.",
                   arg = arg,
                   call = call)
  }
}

check_is_sf <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "sf")) {
    cli::cli_abort("{.arg {arg}} must be an 'sf' object, a result of {.fn read_image_data}",
                   arg = arg,
                   call = call)
  }
}
