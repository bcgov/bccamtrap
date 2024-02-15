plot_deployments <- function(sessions, date_breaks = "1 month", interactive = FALSE) {
  check_sample_sessions(sessions)

  sessions$sampling_start_date <- as.Date(sessions$sampling_start)
  sessions$sampling_end_date <- as.Date(sessions$sampling_end)

  invalid_rows <- is.na(sessions$sampling_end) & !sessions$sample_duration_valid
  sessions$sampling_end_date[invalid_rows] <- as.Date(sessions$date_time_checked[invalid_rows])
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
    ggplot2::scale_x_date(date_breaks = .data$date_breaks) +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = paste0("Camera Deployments at ", sessions$study_area_name[1]),
      x = "Date", y = "Sample Station"
    )

  if (interactive) return(plotly::ggplotly(p))

  p
}

check_deployment_images <- function(sessions, image_data) {
  check_sample_sessions(sessions)
  check_image_data(image_data)


}
