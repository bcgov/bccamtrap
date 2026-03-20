#' Collapse motion detection events into episodes
#'
#' @param df a data frame of image data, read in with `read_image_data()`.
#'
#' @returns a data frame with motion detection events collapsed into 1 row per
#' episode, and summary information about each episode (e.g. duration, number
#' of triggers, total count).
#'
#' @export
collapse_migration_episodes <- function(df) {
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
      first_date_time = min(date_time, na.rm = TRUE),
      last_date_time = max(date_time, na.rm = TRUE),
      duration_s = as.numeric(difftime(
        last_date_time,
        first_date_time,
        units = "secs"
      )),
      n_triggers = dplyr::n(),
      dplyr::across(dplyr::where(is.numeric), \(x) sum(x, na.rm = TRUE)),
      dplyr::across(
        c(
          dplyr::where(is.character),
          -any_of(c(
            "sample_station_label",
            "direction_of_travel",
            "episode"
          ))
        ),
        ~ paste(unique(na.omit(.)), collapse = "; ")
      ),
      total_count = sum(.data$total_count_episode, na.rm = TRUE),
      antler_class_1 = any(grepl("Class 1", .data$antler_class)),
      antler_class_2 = any(grepl("Class 2", .data$antler_class)),
      antler_class_3 = any(grepl("Class 3", .data$antler_class)),
      antler_class_4 = any(grepl("Class 4", .data$antler_class)),
      .groups = "drop"
    ) |>
    dplyr::arrange(as.POSIXct(first_date_time), episode_num, species)

  df_collapsed
}
