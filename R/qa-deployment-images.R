#' Plot timelines of image deployments
#'
#' Make a plot of sampling deployments. The plot indicates start and end times
#' of each deployment, by station. It also shows "invalid" sample deployments,
#' for example if a camera was moved, stolen, ran out of batteries etc.
#' This is indicated by a light grey line and no end point.
#'
#' @param deployments deployments data, as created by [make_deployments()]
#' @param date_breaks How to break up the dates on the x axis. See [scales::date_breaks()]. Default `"1 month"`
#' @param interactive should the plot be interactive? Default `FALSE`
#' @param study_area_name Study area name for the plot. It will be used if it is
#'   already in the data in a `study_area_name` column, otherwise provide it here.
#'
#' @return a `ggplot2` object if `interactive = FALSE`, a `plotly` object if `TRUE`
#' @export
plot_deployments <- function(deployments,
                             date_breaks = "1 month",
                             study_area_name = NULL,
                             interactive = FALSE) {
  check_deployments(deployments)

  deployments <- process_invalid_deployments(deployments)

  if (!is.null(study_area_name) && "study_area_name" %in% names(deployments)) {
    study_area_name <- deployments$study_area_name[1]
  }

  p <- ggplot2::ggplot(deployments) +
    ggplot2::geom_linerange(
      ggplot2::aes(
        xmin = .data$deployment_start_date,
        xmax = .data$deployment_end_date,
        y = .data$sample_station_label,
        group = .data$deployment_label,
        colour = .data$valid_deployment
      ),
      linewidth = 1.1,
      position = ggplot2::position_dodge(width = 0.5)
    ) +
    ggplot2::scale_colour_manual(values = c("Valid" = "black", "Invalid" = "lightpink")) +
    ggplot2::geom_point(
      ggplot2::aes(
        x = .data$deployment_start_date,
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
        x = .data$deployment_end_date,
        y = .data$sample_station_label,
        group = .data$deployment_label,
        size = .data$valid_deployment,
        shape = .data$valid_deployment
      ),
      position = ggplot2::position_dodge(width = 0.5),
      colour = "#400456"
    ) +
    ggplot2::scale_size_manual(values = c("Valid" = 2, "Invalid" = 0.1)) +
    ggplot2::scale_shape_manual(values = c("Valid" = 15, "Invalid" = 4)) +
    ggplot2::scale_x_date(date_breaks = date_breaks) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Camera Deployments at ", study_area_name),
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

process_invalid_deployments <- function(deployments) {
  deployments$deployment_start_date <- as.Date(deployments$deployment_start)
  deployments$deployment_end_date <- as.Date(deployments$deployment_end)

  invalid_rows <- is.na(deployments$deployment_end) & !deployments$deployment_duration_valid

  if ("date_time_checked" %in% names(deployments)) {
    deployments$deployment_end_date[invalid_rows] <- as.Date(deployments$date_time_checked)[invalid_rows]
  }
  deployments$valid_deployment <- ifelse(deployments$deployment_duration_valid, "Valid", "Invalid")
  deployments
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
qa_deployment_images <- function(deployments, image_data) {
  check_deployments(deployments)
  check_image_data(image_data)

  s_dep_labs <- unique(deployments$deployment_label)
  i_dep_labs <- unique(image_data$deployment_label)

  i_dep_labs_extra <- setdiff(i_dep_labs, s_dep_labs)
  s_dep_labs_extra <- setdiff(s_dep_labs, i_dep_labs)

  i_dep_labs_ok <- length(i_dep_labs_extra) == 0
  s_dep_labs_ok <- length(s_dep_labs_extra) == 0

  if (length(intersect(s_dep_labs, i_dep_labs)) == 0) {
    cli::cli_abort(
      "There are no matching deployment labels in {.arg {rlang::caller_arg(deployments)}}
      and {.arg {rlang::caller_arg(image_data)}}."
    )
  }

  if (!i_dep_labs_ok) {
    cli::cli_alert_warning(c(
      "The following deployment labels are present in {.arg {rlang::caller_arg(image_data)}}",
      " but not {.arg {rlang::caller_arg(deployments)}}:",
      " {.val {i_dep_labs_extra}}"
    ))
  }

  if (!s_dep_labs_ok) {
    cli::cli_alert_warning(c(
      "The following deployment labels are present in {.arg {rlang::caller_arg(deployments)}}",
      " but not {.arg {rlang::caller_arg(image_data)}}:",
      " {.val {s_dep_labs_extra}}"
    ))
  }

  invisible(
    list(
      img_dep_labels_not_in_deployments = i_dep_labs_extra,
      deployment_dep_labels_not_in_images = s_dep_labs_extra
    )
  )
}

#' Plot image timestamps over deployment periods
#'
#' Plot detections over sample deployments to check for misaligned time stamps
#'
#' @inheritParams plot_deployments
#' @inheritParams qa_image_data
#'
#' @inherit plot_deployments return
#' @export
plot_deployment_detections <- function(deployments, image_data, date_breaks = "1 month", interactive = FALSE) {
  check_deployments(deployments)
  check_image_data(image_data)

  deployments <- process_invalid_deployments(deployments)

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
      data = deployments,
      ggplot2::aes(
        xmin = .data$deployment_start_date,
        xmax = .data$deployment_end_date,
        y = .data$deployment_label,
        colour = .data$valid_deployment
      ),
      linewidth = 1.1,
      position = ggplot2::position_dodge(width = 0.5)
    ) +
    ggplot2::scale_colour_manual(values = c("Valid" = "black", "Invalid" = "lightpink")) +
    ggplot2::scale_x_date(date_breaks = date_breaks) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Camera Deployments and detections at ", deployments$study_area_name[1]),
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

#' Plot daily activity of species detected by motion detection
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
        tolower(.data$trigger_mode) %in% c("m", "timelapse"),
      .data$trigger_mode == "Motion Detection"
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

#' Merge image data with deployment data
#'
#' Attach deployment metadata with image data.
#'
#' @inheritParams qa_deployment_images
#' @inheritParams read_sample_station_info
#'
#' @return `data.frame` of class `image_data`, with `deployment` columns attached
#' @export
merge_deployments_images <- function(deployments, image_data, as_sf = TRUE) {

  qa_deployment_images(deployments, image_data)

  all_data <- dplyr::left_join(
    dplyr::select(image_data, -"study_area_name", -"sample_station_label"),
    deployments,
    by = "deployment_label"
  )

  class(all_data) <- setdiff(class(all_data), "deployments")
  all_data
}
