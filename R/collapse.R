#' Collapse motion detection events into episodes
#'
#' @param df a data frame of image data, read in with `read_image_data()`.
#' @param migration_map A small data.frame defining the upstream
#' direction(s) of travel for each sample station. Valid upstream values are:
#'  `"L to R"`, `"R to L"`, `"T to B"`, `"B to T"`.
#' Columns must include:
#' - `sample_station_label`
#' - `upstream`
#'
#' @returns a data frame with motion detection events collapsed into 1 row per
#' episode, and summary information about each episode (e.g. duration, number
#' of triggers, total count).
#'
#' @export
collapse_migration_episodes <- function(df, migration_map) {
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
      episode_num = gsub("^([0-9]+).*", "\\1", .data$episode)
    )

  df_collapsed <- df |>
    dplyr::group_by(.data$episode_num, .data$species) |>
    dplyr::summarise(
      sample_station_label = dplyr::first(.data$sample_station_label), # retain site
      direction_of_travel = dplyr::first(.data$direction_of_travel), # keep first travel dir
      first_date_time = min(.data$date_time, na.rm = TRUE),
      last_date_time = max(.data$date_time, na.rm = TRUE),
      duration_s = as.numeric(difftime(
        .data$last_date_time,
        .data$first_date_time,
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
    dplyr::arrange(.data$first_date_time, .data$episode_num, .data$species)

  make_travel_direction(df_collapsed, migration_map)
}

make_travel_direction <- function(df_collapsed, migration_map) {
  if (
    !all(
      c("sample_station_label", "upstream", "downstream") %in%
        names(migration_map)
    )
  ) {
    cli::cli_abort(
      "migration_map must have columns: sample_station_label, upstream, downstream"
    )
  }

  df_collapsed <- df_collapsed |>
    dplyr::mutate(direction_of_travel = tolower(.data$direction_of_travel)) |>
    dplyr::left_join(migration_map, by = "sample_station_label") |>
    dplyr::mutate(
      migration_direction = dplyr::case_when(
        .data$direction_of_travel == "unk" ~ NA_character_,
        .data$direction_of_travel == "enters from top" &
          .data$upstream == "T to B" ~ "upstream",
        .data$direction_of_travel == "enters from bottom" &
          .data$upstream == "T to B" ~ "downstream",
        .data$direction_of_travel == "enters from top" &
          .data$upstream == "B to T" ~ "downstream",
        .data$direction_of_travel == "enters from bottom" &
          .data$upstream == "B to T" ~ "upstream",
        .data$direction_of_travel == "enters from left" &
          .data$upstream == "L to R" ~ "upstream",
        .data$direction_of_travel == "enters from right" &
          .data$upstream == "L to R" ~ "downstream",
        .data$direction_of_travel == "enters from left" &
          .data$upstream == "R to L" ~ "downstream",
        .data$direction_of_travel == "enters from right" &
          .data$upstream == "R to L" ~ "upstream",
        .default ~ NA_character_
      )
    ) |>
    dplyr::select(-"upstream", -"downstream")
}
