collapse_episodes <- function(df) {
  if (length(grep("antler_?class", names(df))) > 1) {
    cli::cli_abort("More than one column with antler class data")
  }

  df <- df |>
    dplyr::filter(
      .data$trigger_mode == "Motion Detection",
      .data$species != "",
      !is.na(.data$species)
    ) |>
    dplyr::rename(
      "antler_class" = matches("antler_?class")
    ) |>
    dplyr::mutate(
      episode_num = gsub("^([0-9]+).*", "\\1", episode)
    )

  df_collapsed <- df |>
    dplyr::group_by(episode_num, species) |>
    dplyr::summarise(
      sample_station_label = dplyr::first(sample_station_label), # retain site
      direction_of_travel = dplyr::first(direction_of_travel), # keep first travel dir
      dplyr::across(dplyr::where(is.numeric), \(x) sum(x, na.rm = TRUE)),
      first_date_time = min(date_time, na.rm = TRUE),
      dplyr::across(
        c(
          dplyr::where(is.character),
          -any_of(c("sample_station_label", "direction_of_travel", "episode"))
        ),
        ~ paste(unique(na.omit(.)), collapse = "; ")
      ),
      .groups = "drop",
      total_count = sum(.data$total_count_episode, na.rm = TRUE)
    ) |>
    dplyr::arrange(as.POSIXct(first_date_time), episode_num, species)

  df_collapsed
}
