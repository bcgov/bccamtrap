#' Calculate Relative Abundance Index (RAI)
#'
#' Calculate the RAI for sample sessions and species. Optionally set start date
#' and end date, deployment label(s), and species. You can choose to calculate
#' RAI by species and deployment label, or as a whole.
#'
#' @inheritParams qa_image_data
#' @inheritParams make_sample_sessions
#' @param deployment_label Optionally, one or more deployment labels to select.
#'   Default `NULL` to use all deployments.
#' @param species Optionally, or more species as a character vector. Default
#'   `NULL` to calculate RAI for each species detected.
#' @param by_deployment Should an RAI be calculated for each deployment label
#'   (`TRUE`, default), or one RAI for all deployment labels (`FALSE`)
#' @param by_species Should an RAI be calculated for each species (`TRUE`,
#'   default), or one RAI for all species (`FALSE`)
#'
#' @return a data.frame of RAI, by deployment label and species (if `by_species
#'   = TRUE`)
#' @export
sample_rai <- function(image_data,
                       deployment_label = NULL,
                       species = NULL,
                       by_deployment = TRUE,
                       by_species = TRUE,
                       sample_start_date = NULL,
                       sample_end_date = NULL) {

  dat <- prep_rai(
    image_data,
    deployment_label,
    species,
    by_deployment,
    by_species,
    sample_start_date,
    sample_end_date
  )

  dat <- dplyr::filter(dat, !is.na(species))

  out <- dplyr::summarize(
    dat,
    sample_start_date = min(.data$sample_start_date, na.rm = TRUE),
    sample_end_date = max(.data$sample_end_date, na.rm = TRUE),
    trap_days = max(.data$trap_days, na.rm = TRUE),
    n_detections = sum(!is.na(.data$species), na.rm = TRUE),
    total_count = sum(.data$total_count_episode, na.rm = TRUE),
    rai = sum(.data$total_count, na.rm = TRUE) / max(.data$trap_days, na.rm = TRUE),
    .groups = "drop"
  )

  dplyr::relocate(out, dplyr::any_of("species"), .before = "n_detections")

}

#' Calculate RAI over a window of time, optionally rolling
#'
#' This function takes a data frame of image data and calculates
#' snow, temperature, effort, count, and RAI metrics aggregated
#' over a specified time window. These can optionally be calculated
#' using a moving window ("rolling") calculation.
#'
#' @inheritParams sample_rai
#' @param by time to aggregate by: One of `"date"` (default), `"week"`, `"month"`, or `"year"`.
#' @param roll should it use a rolling window? Default `FALSE`
#' @param k the size of the rolling window. Default `7`.
#' @param by_deployment Should it be calculated by `deployment`. Default `FALSE`
#' @param snow_agg if `by_deployment = FALSE`, how to aggregate snow measurements
#'   across sites. Takes the name of an aggregation function (e.g., `"mean"`). Default `"max"`
#'
#' @return a data.frame of above calculated metrics
#' @export
rai_by_time <- function(image_data,
                        by = c("date", "week", "month", "year"),
                        roll = FALSE,
                        k = 7,
                        by_species = TRUE,
                        species = NULL,
                        by_deployment = FALSE,
                        deployment_label = NULL,
                        sample_start_date = NULL,
                        sample_end_date = NULL,
                        snow_agg = "max") {

  by <- match.arg(by)
  by_fmt <- switch(
    by,
    "date" = "%Y-%m-%d",
    "week" = "%Y-W-%V",
    "month" = "%Y-%m",
    "year" = "%Y"
  )

  image_data <- filter_if_not_null(image_data, deployment_label)
  image_data <- filter_start_end(image_data, sample_start_date, sample_end_date)

  effort <- make_effort(image_data)

  dat <- filter_if_not_null(image_data, species)
  # TODO: Should we filter so there are no NA species? #19

  # Always do stats by deployment first because need to join with
  # effort, then collapse later if by_deployment = FALSE
  dat <- dat %>%
    dplyr::mutate(date = as.Date(.data$date_time)) %>%
    dplyr::group_by(
    .data$deployment_label,
    .data$species,
    .data$date,
    .add = TRUE
  )

  dat <- dplyr::summarise(
    dat,
    n_detections = sum(!is.na(.data$species), na.rm = TRUE),
    total_count = sum(.data$total_count_episode, na.rm = TRUE)
  )

  dat <- dplyr::left_join(
    effort,
    dat,
    by = c("deployment_label", "date")
  )

  dat <- complete_daily_counts(dat)

  if (by == "date" && !isTRUE(roll) && isTRUE(by_deployment) && isTRUE(by_species)) {
    # This is what we've made so far - a data frame, by deployment, date,
    # and species, of snow, temperature, and species counts
    return(dat)
  }

  if (by != "date") {
    dat[[by]] <- format(dat$date, by_fmt)
  }

  if (!is.null(species)) {
    dat <- dplyr::filter(dat, !is.na(.data$species))
  }

  dat <- add_groups(dat, by_deployment, by_species) %>%
    dplyr::group_by(
      .data$study_area_name,
      .data[[by]],
      .add = TRUE
    ) %>%
    dplyr::summarise(
      start_date = min(.data$date),
      end_date = max(.data$date),
      "{snow_agg}_snow_index" := do.call(snow_agg, list(.data$snow_index, na.rm = TRUE)),
      mean_temperature = mean(.data$temperature, na.rm = TRUE),
      n_detections = sum(.data$n_detections, na.rm = TRUE),
      total_count = sum(.data$total_count, na.rm = TRUE),
      trap_days = dplyr::n_distinct(.data$deployment_label),
      rai = .data$total_count / .data$trap_days,
      .groups = "drop"
    )

  if (by == "date") {
    # don't need these since they are the same when grouped by date
    dat <- dplyr::select(dat, -"start_date", -"end_date")
  }

  if (isTRUE(roll)) {
    dat <- add_groups(dat, by_deployment, by_species) %>%
      dplyr::group_by(
        .data$study_area_name,
        .add = TRUE
      ) %>%
      dplyr::mutate(
        "roll_mean_{snow_agg}_snow" := zoo::rollmean(
          .data[[paste0(snow_agg, "_snow_index")]],
          k = k,
          fill = NA,
          na.rm = TRUE
        ),
        roll_mean_temp = zoo::rollmean(.data$mean_temperature, k = k, fill = NA, na.rm = TRUE),
        roll_trap_days = zoo::rollsum(.data$trap_days, k = k, fill = NA, na.rm = TRUE),
        roll_detections = zoo::rollsum(.data$n_detections, k = k, fill = NA, na.rm = TRUE),
        roll_count = zoo::rollsum(.data$total_count, k = k, fill = NA, na.rm = TRUE),
        roll_rai = .data$roll_count / .data$roll_trap_days
      )
  }
  dplyr::ungroup(dat)
}

filter_if_not_null <- function(data, var, env = rlang::current_env()) {
  if (is.null(var)) return(data)
  varname <- deparse(substitute(var, env = env))
  if (!all(var %in% data[[varname]])) {
    cli::cli_abort("{.val {var}} is not a valid value in {.var {varname}}")
  }
  dplyr::filter(data, .data[[varname]] %in% var)
}

prep_rai <- function(image_data,
                     deployment_label,
                     species,
                     by_deployment,
                     by_species,
                     sample_start_date,
                     sample_end_date) {
  sessions <- make_sample_sessions(image_data, sample_start_date, sample_end_date)

  dat <- dplyr::right_join(
    sessions,
    image_data,
    by = c("sample_station_label", "deployment_label")
  )

  dat <- filter_if_not_null(dat, deployment_label)
  dat <- filter_if_not_null(dat, species)

  dat <- filter_start_end(dat, sample_start_date, sample_end_date)

  dat <- add_groups(dat, by_deployment, by_species)

  dat
}

make_effort <- function(image_data) {
  check_image_data(image_data)
  dplyr::filter(
    image_data,
    .data$trigger_mode == "Time Lapse",
    !.data$lens_obscured
  ) %>%
    dplyr::mutate(
      date = as.Date(.data$date_time),
      snow_index = ifelse(is.na(.data$snow_index), 0, .data$snow_index)
    ) %>%
    dplyr::select(
      "study_area_name",
      "sample_station_label",
      "deployment_label",
      "date",
      "snow_index",
      "temperature"
    ) %>%
    dplyr::distinct()
}

add_groups <- function(x, by_deployment, by_species) {
  if (isTRUE(by_deployment)) {
    x <- dplyr::group_by(x, .data$deployment_label)
  }
  if (isTRUE(by_species)) {
    x <- dplyr::group_by(x, .data$species, .add = TRUE)
  }
  x
}

complete_daily_counts <- function(x) {
    tidyr::complete(
      x,
      tidyr::nesting(
        # .data pronoun doesn't work inside nesting, so need this
        # awkward data-masking syntax
        !!rlang::sym("study_area_name"),
        !!rlang::sym("sample_station_label"),
        !!rlang::sym("deployment_label"),
        !!rlang::sym("date"),
        !!rlang::sym("snow_index"),
        !!rlang::sym("temperature")
      ),
      !!rlang::sym("species"),
      fill = list(n_detections = 0, total_count = 0)
    ) %>%
    dplyr::ungroup()
}


