#' Plot timelines of image deployments
#'
#' Make a plot of sampling sessions. The plot indicates start and end times
#' of each deployment, by station. It also shows "invalid" sample sessions,
#' for example if a camera was moved, stolen, ran out of batteries etc.
#' This is indicated by a light grey line and no end point.
#'
#' @param sessions sessions data, as created by [make_sample_sessions()]
#' @param date_breaks How to break up the dates on the x axis. See [scales::date_breaks()]. Default `"1 month"`
#' @param interactive should the plot be interactive? Default `FALSE`
#'
#' @return a `ggplot2` object if `interactive = FALSE`, a `plotly` object if `TRUE`
#' @export
plot_deployments <- function(sessions,
                             date_breaks = "1 month",
                             interactive = FALSE) {
  check_sample_sessions(sessions)

  sessions <- process_invalid_sessions(sessions)

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

process_invalid_sessions <- function(sessions) {
  sessions$sampling_start_date <- as.Date(sessions$sampling_start)
  sessions$sampling_end_date <- as.Date(sessions$sampling_end)

  invalid_rows <- is.na(sessions$sampling_end) & !sessions$sample_duration_valid

  sessions$sampling_end_date[invalid_rows] <- as.Date(sessions$date_time_checked)[invalid_rows]
  sessions$valid_session <- ifelse(sessions$sample_duration_valid, "Valid", "Invalid")
  sessions
}

#' Check for mismatched deployment labels in session data and image data
#'
#' This function is mainly called for its messaging - alerting you to deployment labels that are
#' in the sample session data but not in the image data, and vice versa.
#'
#' @inheritParams plot_deployment_detections
#'
#' @return a list of two vectors containing mismatched deployment labels
#' @export
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
    cli::cli_alert_warning(c(
      "The following deployment labels are present in {.arg {rlang::caller_arg(image_data)}}",
      " but not {.arg {rlang::caller_arg(sessions)}}:",
      " {.val {i_dep_labs_extra}}"
    ))
  }

  if (!s_dep_labs_ok) {
    cli::cli_alert_warning(c(
      "The following deployment labels are present in {.arg {rlang::caller_arg(sessions)}}",
      " but not {.arg {rlang::caller_arg(image_data)}}:",
      " {.val {s_dep_labs_extra}}"
    ))
  }

  invisible(
    list(
      img_dep_labels_not_in_sessions = i_dep_labs_extra,
      session_dep_labels_not_in_images = s_dep_labs_extra
    )
  )
}

#' Plot image timestamps over deployment periods
#'
#' Plot detections over sample sessions to check for misaligned time stamps
#'
#' @inheritParams plot_deployments
#' @param image_data data.frame of image sequence data, as read via [read_image_data()]
#'
#' @inherit plot_deployments return
#' @export
plot_deployment_detections <- function(sessions, image_data, date_breaks = "1 month", interactive = FALSE) {
  check_sample_sessions(sessions)
  check_image_data(image_data)

  sessions <- process_invalid_sessions(sessions)

  pt_symbol <- "|"

  img_data_grouped <- image_data %>%
    dplyr::mutate(img_date = as.Date(.data$date_time)) %>%
    dplyr::group_by(.data$deployment_label, .data$img_date) %>%
    dplyr::summarise()

  p <- ggplot2::ggplot() +
    ggplot2::geom_point(
      data = img_data_grouped,
      ggplot2::aes(
        x = .data$img_date,
        y = .data$deployment_label
      ),
      shape = pt_symbol,
      colour = "red",
      size = 3
    ) +
    ggplot2::geom_linerange(
      data = sessions,
      ggplot2::aes(
        xmin = .data$sampling_start_date,
        xmax = .data$sampling_end_date,
        y = .data$deployment_label,
        colour = .data$valid_session
      ),
      linewidth = 1.1,
      position = ggplot2::position_dodge(width = 0.5)
    ) +
    ggplot2::scale_colour_manual(values = c("Valid" = "black", "Invalid" = "lightgrey")) +
    ggplot2::scale_x_date(date_breaks = date_breaks) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Camera Deployments and detections at ", sessions$study_area_name[1]),
      x = "Date", y = "Deployment Label", colour = "Valid Session"
    )

  if (interactive) {
    p <- plotly::plotly_build(p)
    # Hack plotly object to replace markers with text
    p$x$data[[1]]$mode <- "text"
    p$x$data[[1]]$hovertext <- p$x$data[[1]]$text
    p$x$data[[1]]$text <- pt_symbol
    p$x$data[[1]]$textfont$size <- p$x$data[[1]]$marker$size
    p$x$data[[1]]$textfont$color <- p$x$data[[1]]$marker$color
    p$x$data[[1]]$textfont$opacity <- p$x$data[[1]]$marker$opacity
    p$x$data[[1]]$marker <- NULL
  }
  p
}

#' Plot daily activity of species
#'
#' @inheritParams plot_deployment_detections
#'
#' @inherit plot_deployments return
#' @export
plot_diel_activity <- function(image_data, interactive = FALSE) {
  plot_data <- image_data %>%
    dplyr::filter(
      !is.na(.data$species) |
        (!is.na(.data$total_count_episode) & .data$total_count_episode > 0) |
        !is.na(.data$human_use_type) |
        grepl("crew", tolower(.data$comment)) |
        tolower(.data$trigger_mode) %in% c("m", "timelapse")
    ) %>%
    dplyr::mutate(
      time_of_day = (lubridate::hour(.data$date_time) * 60 +
                       lubridate::minute(.data$date_time) +
                       lubridate::second(.data$date_time)) / 60,
      total_count_episode = ifelse(is.na(.data$total_count_episode), 1, .data$total_count_episode)
    )

  p <- ggplot2::ggplot(plot_data) +
    ggplot2::geom_point(
      ggplot2::aes(
        x = .data$time_of_day,
        y = .data$species,
        size = .data$total_count_episode,
        group = .data$deployment_label
      ),
      alpha = 0.3,
      colour = "#400456"
    ) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Daily activity of different species at ", image_data$study_area_name[1]),
      x = "Time of Day (hours)",
      y = "Species*",
      caption = "*NA usually denotes human activity"
    )

  if (interactive) {
    p <- plotly::ggplotly(
      p = p
    )
  }
  p
}

merge_sessions_images <- function(sessions, image_data) {

  check_deployment_images(sessions, image_data)

  all_data <- dplyr::left_join(
    sessions, image_data, by = "deployment_label"
  )

  all_data
}
