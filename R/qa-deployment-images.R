plot_deployments <- function(sessions, interactive = FALSE) {
  check_sample_sessions(sessions)

  sessions$sampling_start <- as.Date(sessions$sampling_start)
  sessions$sampling_end <- as.Date(sessions$sampling_end)

  p <- ggplot(sessions) +
    geom_linerange(
      aes(xmin = sampling_start, xmax = sampling_end,
          y = sample_station_label, group = deployment_label),
      position = position_dodge(width = 0.5)
    ) +
    geom_point(
      aes(x = sampling_start, y = sample_station_label, group = deployment_label),
      position = position_dodge(width = 0.5),
      shape = 19,
      colour = "#f7941d"
    ) +
    geom_point(
      aes(x = sampling_end, y = sample_station_label, group = deployment_label),
      position = position_dodge(width = 0.5),
      shape = 15,
      colour = "#400456"
    ) +
    scale_x_date(date_breaks = "1 month") +
    theme_bw() +
    labs(
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
