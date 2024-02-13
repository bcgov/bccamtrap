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

check_cam_setup_checks <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "cam_setup_checks")) {
    cli::cli_abort("{.arg {arg}} must be a 'cam_setup_checks' object, a result of {.fn read_cam_setup_checks}",
                   arg = arg,
                   call = call)
  }
}

check_sample_sessions <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "sample_sessions")) {
    cli::cli_abort("{.arg {arg}} must be a 'sample_sessions' object, a result of {.fn make_sample_sessions}",
                   arg = arg,
                   call = call)
  }
}

check_image_data <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, "image_data")) {
    cli::cli_abort("{.arg {arg}} must be a 'image_data' object, a result of {.fn read_image_data}",
                   arg = arg,
                   call = call)
  }
}
