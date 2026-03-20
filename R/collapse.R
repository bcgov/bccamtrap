#' Collapse motion detection events into episodes
#'
#' @param df a data frame of migration image data, read in with `read_image_data()`.
#' @param migration_map A small data.frame defining the upstream
#' direction(s) of travel for each sample station. Valid upstream values are:
#'  `"L to R"`, `"R to L"`, `"T to B"`, `"B to T"`.
#' Columns must include:
#' - `sample_station_label`
#' - `upstream`
#'
#' @returns a data frame with motion detection events collapsed into 1 row per
#' episode, and summary information about each episode (e.g. duration, number
#' of triggers, total count, direction of travel, ...).
#'
#' @export
collapse_migration_episodes <- function(df, migration_map) {
  df <- prep_for_collapse(df)
  df_collapsed <- collapse_episodes(df, "migration")
  make_travel_direction(df_collapsed, migration_map)
}

#' Collapse Wallow Episodes
#'
#' @param df a data frame of wallow image data, read in with `read_image_data()`.
#'
#' @returns a data frame with wallow image data collapsed into 1 row per
#' episode, and summary information about each episode (e.g. duration, number
#' of triggers, total count, social and wallow behaviour, ...).
#'
#' @export
collapse_wallow_episodes <- function(df) {
  df <- prep_for_collapse(df)
  df_collapsed <- collapse_episodes(df, "wallow")
  make_wallow_behaviour_columns(df_collapsed)
}

prep_for_collapse <- function(df) {
  if (length(grep("antler_?class", names(df))) > 1) {
    cli::cli_abort("More than one column with antler class data")
  }

  df |>
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
}

collapse_episodes <- function(df, which = c("migration", "wallow")) {
  which <- match.arg(which)

  collapsed_df <- df |>
    dplyr::group_by(.data$episode_num, .data$species) |>
    dplyr::summarise(
      sample_station_label = dplyr::first(.data$sample_station_label),
      first_date_time = min(.data$date_time, na.rm = TRUE),
      last_date_time = max(.data$date_time, na.rm = TRUE),
      duration_s = as.numeric(difftime(
        .data$last_date_time,
        .data$first_date_time,
        units = "secs"
      )),
      n_triggers = dplyr::n(),
      wallow_behaviour_list = if (which == "wallow") {
        list(unique(stats::na.omit(unlist(strsplit(
          .data$elk_behaviour_wallow,
          ",(\\s*)?"
        )))))
      },
      social_behaviour_list = if (which == "wallow") {
        list(unique(stats::na.omit(unlist(strsplit(
          .data$elk_behaviour_social,
          ",(\\s*)?"
        )))))
      },
      direction_of_travel = if (which == "migration") {
        dplyr::first(.data$direction_of_travel)
      },
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
        combine_strings
      ),
      dplyr::across(dplyr::where(is.logical), \(x) any(x, na.rm = TRUE)),
      total_count = sum(.data$total_count_episode, na.rm = TRUE),
      antler_class_1 = any(grepl("Class 1", .data$antler_class)),
      antler_class_2 = any(grepl("Class 2", .data$antler_class)),
      antler_class_3 = any(grepl("Class 3", .data$antler_class)),
      antler_class_4 = any(grepl("Class 4", .data$antler_class)),
      .groups = "drop"
    ) |>
    dplyr::arrange(.data$first_date_time, .data$episode_num, .data$species)

  collapsed_df
}

combine_strings <- function(x) {
  x <- paste(unique(stats::na.omit(x)), collapse = "; ")
  if (x == "") {
    return(NA_character_)
  }
  x
}

make_travel_direction <- function(df_collapsed, migration_map) {
  if (
    !all(
      c("sample_station_label", "upstream") %in% names(migration_map)
    )
  ) {
    cli::cli_abort(
      "migration_map must have columns: sample_station_label, upstream"
    )
  }

  df_collapsed |>
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
        .default = NA_character_
      )
    ) |>
    dplyr::select(-"upstream", )
}

make_wallow_behaviour_columns <- function(df_collapsed) {
  df_collapsed <- df_collapsed |>
    dplyr::mutate(
      wallow_behaviour_list = list_to_named_logical(
        .data$wallow_behaviour_list,
        prefix = "wallow_"
      ),
      social_behaviour_list = list_to_named_logical(
        .data$social_behaviour_list,
        prefix = "social_"
      )
    )

  df_collapsed |>
    dplyr::relocate(
      "wallow_behaviour_list",
      "social_behaviour_list",
      .after = "total_count"
    ) |>
    tidyr::unnest_wider(
      .data$wallow_behaviour_list,
      names_repair = janitor::make_clean_names,
      transform = \(x) ifelse(is.na(x), FALSE, x)
    ) |>
    tidyr::unnest_wider(
      .data$social_behaviour_list,
      names_repair = janitor::make_clean_names,
      transform = \(x) ifelse(is.na(x), FALSE, x)
    )
}

list_to_named_logical <- function(x, prefix) {
  lapply(
    x,
    \(y) {
      nm <- y
      y <- rep(TRUE, length(y))
      names(y) <- if (length(nm) == 0) character(0) else paste0(prefix, nm)
      y
    }
  )
}
