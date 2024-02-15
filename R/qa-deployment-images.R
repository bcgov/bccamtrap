plot_deployments <- function(sessions,
                             date_breaks = "1 month",
                             interactive = FALSE) {
  check_sample_sessions(sessions)

  sessions$sampling_start_date <- as.Date(sessions$sampling_start)
  sessions$sampling_end_date <- as.Date(sessions$sampling_end)

  invalid_rows <- is.na(sessions$sampling_end) & !sessions$sample_duration_valid

  half_date <- make_halfway_date(sessions[invalid_rows, ])

  sessions$sampling_end_date[invalid_rows] <- half_date
  sessions$valid_session <- ifelse(sessions$sample_duration_valid, "Valid", "Invalid")

  p <- ggplot2::ggplot(sessions) +
    ggplot2::geom_linerange(
      ggplot2::aes(
        xmin = .data$sampling_start_date,
        xmax = .data$sampling_end_date,
        y = .data$sample_station_label,
        group = .data$deployment_label,
        colour = .data$valid_session
      ),
      linewidth = 1.1,
      position = ggplot2::position_dodge(width = 0.5)
    ) +
    ggplot2::scale_colour_manual(values = c("Valid" = "black", "Invalid" = "lightgrey")) +
    ggplot2::geom_point(
      ggplot2::aes(
        x = .data$sampling_start_date,
        y = .data$sample_station_label,
        group = .data$deployment_label
      ),
      position = ggplot2::position_dodge(width = 0.5),
      size = 2,
      shape = 19,
      colour = "#f7941d"
    ) +
    ggplot2::geom_point(
      ggplot2::aes(
        x = .data$sampling_end_date,
        y = .data$sample_station_label,
        group = .data$deployment_label,
        size = .data$valid_session,
        shape = .data$valid_session
      ),
      position = ggplot2::position_dodge(width = 0.5),
      colour = "#400456"
    ) +
    ggplot2::scale_size_manual(values = c("Valid" = 2, "Invalid" = 0.1)) +
    ggplot2::scale_shape_manual(values = c("Valid" = 15, "Invalid" = 4)) +
    ggplot2::scale_x_date(date_breaks = date_breaks) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Camera Deployments at ", sessions$study_area_name[1]),
      x = "Date", y = "Sample Station", size = "Valid Session", shape = "Valid Session",
      colour = "Valid Session"
    )

  if (interactive) {
    p <- plotly::ggplotly(
      p = p,
      tooltip = c("x", "y", "size", "color", "group")
    )
    p <- plotly::style(p, showlegend = FALSE, traces = c(1,2))
  }
  p
}

make_halfway_date <- function(x) {
  interval <- lubridate::interval(x$sampling_start_date, x$date_time_checked)
  duration <- lubridate::as.duration(interval)
  x$sampling_start_date + duration / 2
}

check_deployment_images <- function(sessions, image_data) {
  check_sample_sessions(sessions)
  check_image_data(image_data)

  s_dep_labs <- unique(sessions$deployment_label)
  i_dep_labs <- unique(image_data$deployment_label)

  i_dep_labs_extra <- setdiff(i_dep_labs, s_dep_labs)
  s_dep_labs_extra <- setdiff(s_dep_labs, i_dep_labs)

  i_dep_labs_ok <- length(i_dep_labs_extra) == 0
  s_dep_labs_ok <- length(s_dep_labs_extra) == 0

  if (!i_dep_labs_ok && !s_dep_labs_ok) {
    cli::cli_abort(
      "There are no matching deployment labels in {.arg {rlang::caller_arg(sessions)}}
      and {.arg {rlang::caller_arg(image_data)}}."
    )
  }

  if (!i_dep_labs_ok) {
    cli::cli_alert_warning(
      "The following deployment labels are present in {.arg {rlang::caller_arg(image_data)}}:
      {.val {i_dep_labs_extra}} but not {.arg {rlang::caller_arg(sessions)}}"
    )
  }

  if (!s_dep_labs_ok) {
    cli::cli_alert_warning(
      "The following deployment labels are present in {.arg {rlang::caller_arg(sessions)}}:
      {.val {s_dep_labs_extra}} but not {.arg {rlang::caller_arg(image_data)}}"
    )
  }

  invisible(
    list(
      img_dep_labels_not_in_sessions = i_dep_labs_extra,
      session_dep_labels_not_in_images = s_dep_labs_extra
    )
  )
}

plot_deployment_images <- function(sessions, image_data) {
  check_sample_sessions(sessions)
  check_image_data(image_data)


}
