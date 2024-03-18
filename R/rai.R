rai <- function(sessions, image_data, deployment_label = NULL, species = NULL, sample_start_date = NULL, sample_end_date = NULL) {
  dat <- dplyr::right_join(
    sessions,
    image_data,
    by = c("sample_station_label", "deployment_label")
  )

  dat <- dplyr::group_by(
    dat,
    .data$deployment_label,
    .data$sample_start_date,
    sample_end_date = .data$max_tl_date,
    .data$sample_period_length,
    .data$species
  )

  dat <- dplyr::filter(dat, !is.na(.data$species))

  # check for missing counts

  dplyr::summarize(
    dat,
    n_animals = sum(.data$total_count_episode, na.rm = TRUE),
    rai = sum(.data$n_animals, na.rm = TRUE) / max(as.numeric(.data$sample_period_length, units = "days")),
    .groups = "drop"
  )

}
