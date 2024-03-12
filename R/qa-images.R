#' Perform a series of QA checks on the Timelapse Image data
#'
#' * Check for blanks in key fields (study area, station label, deployment date,
#'   surveyor, trigger mode, temperature, episode)
#' * Species detected with no count data
#' * Count data with no species
#' * Sum of subcount fields equals Total Count
#' * Multiple entries under same Episode number (indicating possible double entry)
#' * Ensure dates for timelapse images are continuous and in order.
#' * Snow data
#'     - No blanks unless lens obscured is TRUE
#'     - Look for erroneous values (e.g., 10, 10, 110, 10, 15, 20)
#'
#' @param image_data data.frame of class `image_data`, as read in by [read_image_data()].
#' @param exclude_human_use should images where `human_use_type` indicates a motion
#'   detection event from humans be excluded from the count/species checks? Default `TRUE`.
#' @param check_snow show `QA` be performed on snow measurements? Default `TRUE`
#'
#' @return input data frame with additional `QA_*` columns appended, and
#'   subset only to rows where a QA issue was flagged.
#' @export
qa_image_data <- function(image_data, exclude_human_use = TRUE, check_snow = TRUE) {
  check_image_data(image_data)

  image_data <- check_blanks(image_data)

  image_data <- check_unmatched(
    image_data,
    "species",
    "total_count_episode",
    exclude_human_use = exclude_human_use
  )
  image_data <- check_unmatched(
    image_data,
    "total_count_episode",
    "species",
    exclude_human_use = exclude_human_use
  )

  image_data <- check_counts(
    image_data,
    exclude_human_use = exclude_human_use
  )

  image_data <- check_dup_episode(image_data)

  image_data <- check_timestamp_order(image_data)

  if (check_snow) {
    image_data <- check_snow_data(image_data)
  }

  dplyr::filter(
    image_data,
    dplyr::if_any(dplyr::starts_with("QA"))
  )
}

check_blanks <- function(x) {
  cols <- c(
    "study_area_name",
    "sample_station_label",
    "deployment_label",
    "date_time",
    "surveyor",
    "trigger_mode",
    "temperature",
    "episode"
  )
  names(cols) <- paste0("QA_BLANK_", cols)

  dplyr::mutate(
    x,
    dplyr::across(dplyr::any_of(cols), is_blank)
  )
}

is_blank <- function(x) {
  is.na(x) | !nzchar(x) | grepl("^\\s+$", x)
}

check_unmatched <- function(x, y, z, exclude_human_use) {
  colname <- paste("QA", y, "UNMATCHED", z, sep = "_")
  x[[colname]] <- !is_blank(x[[y]]) & is_blank(x[[z]])

  if (exclude_human_use) {
    x[[colname]] <- x[[colname]] & is_blank(x$human_use_type)
  }
  x
}

check_counts <- function(x, exclude_human_use) {
  x <- dplyr::mutate(
    x,
    sum_counts = rowSums(dplyr::pick(
      "adult_male",
      "adult_female",
      "adult_unclassified_sex",
      "yearling_male",
      "yearling_female",
      "yearling_unclassified_sex",
      "young_of_year_unclassified_sex",
      "juvenile_unclassified_sex",
      "male_unclassified_age",
      "female_unclassified_age",
      "unclassified_life_stage_and_sex"
    ),
    na.rm = TRUE
    ),
    QA_sum_counts = is_true_vec(
      .data$sum_counts != .data$total_count_episode |
        .data$sum_counts > 0 & is.na(.data$total_count_episode)
    )
  )

  if (exclude_human_use) {
    x$QA_sum_counts <- x$QA_sum_counts & is_blank(x$human_use_type)
  }

  dplyr::select(x, -dplyr::any_of("sum_counts"))
}

is_true_vec <- Vectorize(isTRUE)

check_dup_episode <- function(x) {

  extract_ep_num <- function(x) {
    vapply(
      strsplit(x, "[^0-9]"),
      \(y) as.integer(y[1]),
      FUN.VALUE = integer(1)
    )
  }

  x <- dplyr::mutate(
    x,
    episode_num = extract_ep_num(.data$episode),
    .before = "episode"
  )

  cols <- c("episode_num", "deployment_label", "species")

  y <- dplyr::select(x, dplyr::all_of(cols))
  y <- janitor::get_dupes(y, dplyr::all_of(cols))
  y <- dplyr::filter(
    y,
    dplyr::if_all(dplyr::all_of(cols), \(x) !is.na(x))
  )

  x <- dplyr::left_join(
    x, y,
    by = cols
  )
  x <- dplyr::mutate(
    x,
    QA_dup_episode = !is.na(.data$dupe_count > 0)
  )
  dplyr::select(x, -dplyr::any_of("dupe_count"))
}

check_timestamp_order <- function(x) {

  group_cols <- c("study_area_name",
                  "sample_station_label",
                  "deployment_label")

  x <- dplyr::arrange(x, dplyr::across(c(group_cols, "date_time")))

  y <- dplyr::filter(
    x,
    .data$trigger_mode == "Time Lapse"
  )

  y <- dplyr::select(
    y,
    dplyr::all_of(c(group_cols, "date_time", "file"))
  )

  y <- dplyr::mutate(
    y,
    tdiff = c(1, diff(as.Date(.data$date_time))),
    .by = group_cols
  )

  x <- dplyr::left_join(
    x, y,
    by = c(group_cols, "date_time", "file")
  )

  x <- dplyr::mutate(
    x,
    QA_TL_lag = !is.na(.data$tdiff) & .data$tdiff != 1,
  )

  dplyr::select(x, -dplyr::any_of("tdiff"))
}

check_snow_data <- function(x) {
  x <- dplyr::arrange(x, .data$date_time)

  group_cols <- c("study_area_name",
                  "sample_station_label",
                  "deployment_label")

  y <- dplyr::filter(x, .data$trigger_mode == "Time Lapse")
  y <- dplyr::select(y, dplyr::all_of(
    c(group_cols, "date_time", "file", "lens_obscured", "snow_depth",
      "snow_depth_lower")
  ))

  y <- dplyr::mutate(
    y,
    QA_snow_blank = !.data$lens_obscured & is_blank(.data$snow_depth),
    snow_5_avg = c(
      RcppRoll::roll_mean(
        .data$snow_depth_lower,
        n = min(5, dplyr::n()),
        fill = NA_real_,
        na.rm = TRUE
      )
    ),
    QA_snow_outlier = !.data$QA_snow_blank &
      !is.na(.data$snow_5_avg) &
      abs(.data$snow_depth_lower) > 0 &
      (sign(.data$snow_depth_lower) != sign(.data$snow_5_avg) |
         abs(.data$snow_depth_lower) > 5 * abs(.data$snow_5_avg)),
    .by = "deployment_label"
  )

  y <- dplyr::select(y, -dplyr::any_of("lens_obscured"), -dplyr::starts_with("snow"))

  ret <- dplyr::left_join(
    x, y,
    by = setdiff(names(y), c("QA_snow_blank", "QA_snow_outlier"))
  )

  dplyr::mutate(
    ret,
    dplyr::across(dplyr::starts_with("QA_snow"), \(x) ifelse(is.na(x), FALSE, x))
  )
}

