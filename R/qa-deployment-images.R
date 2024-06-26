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
#' @param ... passed on to [ggiraph::girafe()] for setting options for interactive graphs
#'
#' @return a `ggplot2` object if `interactive = FALSE`, a `ggiraph` object if `TRUE`
#' @export
plot_deployments <- function(deployments,
                             date_breaks = "1 month",
                             study_area_name = NULL,
                             interactive = FALSE,
                             ...) {
  check_deployments(deployments)

  deployments <- process_invalid_deployments(deployments)

  if (!is.null(study_area_name) && "study_area_name" %in% names(deployments)) {
    study_area_name <- deployments$study_area_name[1]
  }

  deployments$id <- seq_len(nrow(deployments))
  deployments$tooltip <- glue::glue(
    "Deployment:  {deployments$deployment_label}
     Start Date:  {deployments$deployment_start_date}
     End Date:    {deployments$deployment_end_date}
     Valid Deployment:  {deployments$valid_deployment}"
  )

  p <- ggplot2::ggplot(deployments) +
    ggiraph::geom_linerange_interactive(
      ggplot2::aes(
        xmin = .data$deployment_start_date,
        xmax = .data$deployment_end_date,
        y = .data$sample_station_label,
        group = .data$deployment_label,
        colour = .data$valid_deployment,
        data_id = .data$id,
        tooltip = .data$tooltip
      ),
      linewidth = 1.1,
      position = ggplot2::position_dodge(width = 0.5)
    ) +
    ggplot2::scale_colour_manual(values = c("Valid" = "black", "Invalid" = "lightpink")) +
    ggiraph::geom_point_interactive(
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
    ggiraph::geom_point_interactive(
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
    p <- p +
      ggplot2::theme_minimal(base_size = 7)
    p <- ggiraph::girafe(ggobj = p, width_svg = 8, ...)
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

#' Check for mismatched deployment labels in deployment data and image data
#'
#' This function is mainly called for its messaging - alerting you to deployment labels that are
#' in the sample deployment data but not in the image data, and vice versa.
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

  bad_tl_times <- check_timelapse_times(deployments, image_data)

  if (length(bad_tl_times) > 0) {
    cli::cli_alert_warning(c(
      "There is a mismatch in {.var timelapse_time} in {.arg {rlang::caller_arg(deployments)}}",
      "and {.var date_time} in {.arg {rlang::caller_arg(image_data)}} for ",
      "timelapse images in the following deployments: {.val {bad_tl_times}}."
    )
    )
  }

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
      deployment_dep_labels_not_in_images = s_dep_labs_extra,
      mismatched_timelapse_image_times = bad_tl_times
    )
  )
}

check_timelapse_times <- function(deployments, image_data) {
  image_data <- image_data[grepl("^[Tt]", image_data$trigger_mode),
                           c("deployment_label", "date_time")]

  image_data$time <- format(image_data$date_time, "%H:%M:%S")

  deployments$tl_time = format(deployments$timelapse_time, "%H:%M:%S")

  dat <- dplyr::left_join(
    dplyr::select(deployments, "deployment_label", "tl_time"),
    dplyr::distinct(image_data, .data$deployment_label, .data$time),
    by = "deployment_label"
  )

  bad_tl_times <- dat$deployment_label[dat$tl_time != dat$time]

  bad_tl_times <- bad_tl_times[!is.na(bad_tl_times)]

  bad_tl_times
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
plot_deployment_detections <- function(deployments, image_data, date_breaks = "1 month", interactive = FALSE, ...) {
  check_deployments(deployments)
  check_image_data(image_data)

  deployments <- process_invalid_deployments(deployments)

  pt_symbol <- "|"

  img_data_grouped <- image_data %>%
    dplyr::mutate(img_date = as.Date(.data$date_time)) %>%
    dplyr::group_by(.data$deployment_label, .data$img_date, .data$lens_obscured) %>%
    dplyr::summarise(n = dplyr::n())

  img_data_grouped$id <- seq_len(nrow(img_data_grouped))

  img_data_grouped$tooltip <- glue::glue(
    "Deployment:  {img_data_grouped$deployment_label}
     Date:  {img_data_grouped$img_date}
     Lens Obscured:  {img_data_grouped$lens_obscured}
     # Photos: {img_data_grouped$n}"
  )

  deployments$id <- seq_len(nrow(deployments))

  p <- ggplot2::ggplot() +
    ggiraph::geom_point_interactive(
      data = img_data_grouped,
      ggplot2::aes(
        x = .data$img_date,
        y = .data$deployment_label,
        colour = .data$lens_obscured,
        data_id = .data$id,
        tooltip = .data$tooltip
      ),
      shape = pt_symbol,
      size = 3
    ) +
    ggiraph::geom_linerange_interactive(
      data = deployments,
      ggplot2::aes(
        xmin = .data$deployment_start_date,
        xmax = .data$deployment_end_date,
        y = .data$deployment_label,
        alpha = .data$valid_deployment
      ),
      linewidth = 0.8,
      position = ggplot2::position_dodge(width = 0.5)
    ) +
    ggplot2::scale_colour_manual(values = c("TRUE" = "#f7941d", "FALSE" = "#400456")) +
    ggplot2::scale_alpha_manual(values = c("Valid" = 1, "Invalid" = 0.3)) +
    ggplot2::scale_x_date(date_breaks = date_breaks) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Camera Deployments and detections at ", deployments$study_area_name[1]),
      x = "Date", y = "Deployment Label" , colour = "Lens Obscured", alpha = "Valid Deployment"
    )

  if (interactive) {
    p <- p +
      ggplot2::theme_minimal(base_size = 7)
    p <- ggiraph::girafe(ggobj = p, width_svg = 8, ...)
  }
  p
}

#' Plot daily activity of species detected by motion detection
#'
#' @inheritParams plot_deployment_detections
#'
#' @inherit plot_deployments return
#' @export
plot_diel_activity <- function(image_data, interactive = FALSE, ...) {
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

  plot_data$id <- seq_len(nrow(plot_data))
  plot_data$tooltip <- glue::glue(
    "Time of day: {format(plot_data$date_time, '%T')}
     Species: {plot_data$species}
     Total Count: {plot_data$total_count_episode}
     Deployment: {plot_data$deployment_label}
    "
  )

  p <- ggplot2::ggplot(plot_data) +
    ggiraph::geom_point_interactive(
      ggplot2::aes(
        x = .data$time_of_day,
        y = .data$species,
        size = .data$total_count_episode,
        group = .data$deployment_label,
        data_id = .data$id,
        tooltip = .data$tooltip
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
    p <- p +
      ggplot2::theme_minimal(base_size = 7)
    p <- ggiraph::girafe(ggobj = p, width_svg = 8, ...)
  }
  p
}

#' Merge image data with deployment data
#'
#' Attach deployment metadata with image data.
#'
#' @inheritParams qa_deployment_images
#' @inheritParams read_sample_station_info
#' @param drop_unjoined if there are unmatched `deployment_labels` between
#'   deployments and image data, should they be dropped from the output
#'   (this is equivalent to a [dplyr::inner_join()])? Default is `FALSE`.
#'
#' @return `data.frame` of class `image_data`, with `deployment` columns attached
#' @export
merge_deployments_images <- function(deployments, image_data, drop_unjoined = FALSE, as_sf = TRUE) {

  qa_deployment_images(deployments, image_data)

  if (!as_sf) {
    deployments <- sf::st_drop_geometry(deployments)
  }

  join_fun <- if (drop_unjoined) {
    dplyr::inner_join
  } else {
    dplyr::left_join
  }

  all_data <- join_fun(
    dplyr::select(image_data, -"study_area_name", -"sample_station_label"),
    deployments,
    by = "deployment_label"
  )

  if (as_sf) {
    sf::st_geometry(all_data) <- "geometry"
  }

  class(all_data) <- setdiff(class(all_data), "deployments")
  all_data
}
