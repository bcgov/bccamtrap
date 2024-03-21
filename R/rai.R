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

  dat <- filter_if_not_null(dat, deployment_label)
  dat <- filter_if_not_null(dat, species)

  # check for missing counts

  dplyr::summarize(
    dat,
    total_count = sum(.data$total_count_episode, na.rm = TRUE),
    rai = sum(.data$total_count, na.rm = TRUE) / max(as.numeric(.data$sample_period_length, units = "days")),
    .groups = "drop"
  )

}

filter_if_not_null <- function(data, var, env = rlang::current_env()) {
  if (is.null(var)) return(data)
  varname <- deparse(substitute(var, env = env))
  if (!var %in% data[[varname]]) {
    cli::cli_abort("{.val {var}} is not a valid value in {.var {varname}}")
  }
  dplyr::filter(data, .data[[varname]] %in% var)
}


