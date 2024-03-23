#' Calculate Relative Activity Index (RAI)
#'
#' Calculate the RAI for sample sessions and species. Optionally set start date
#' and end date, deployment label(s), and species. You can choose to calculate
#' RAI by species and deployment label, or as a whole.
#'
#' @inheritParams qa_image_data
#' @inheritParams make_sample_sessions
#' @param deployment_label One or more deployment labels to select
#' @param species One or more species as a character vector. Default `NULL` to
#'   calculate RAI for each species detected.
#' @param by_deployment_label Should an RAI be calculated for each deployment
#'   label (`TRUE`, default), or one RAI for all deployment labels (`FALSE`)
#' @param by_species Should an RAI be calculated for each species (`TRUE`,
#'   default), or one RAI for all species (`FALSE`)
#'
#' @return a data.frame of RAI, by deployment label and species (if `by_species = TRUE`)
#' @export
sample_rai <- function(image_data,
                       deployment_label = NULL,
                       species = NULL,
                       by_deployment_label = TRUE,
                       by_species = TRUE,
                       sample_start_date = NULL,
                       sample_end_date = NULL) {

  dat <- prep_rai(
    image_data,
    deployment_label,
    species,
    by_deployment_label,
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
    total_count = sum(.data$total_count_episode, na.rm = TRUE),
    rai = sum(.data$total_count, na.rm = TRUE) / max(as.numeric(.data$trap_days, units = "days")),
    .groups = "drop"
  )

  dplyr::relocate(out, dplyr::any_of("species"), .before = "total_count")

}

rai_by_time <- function(image_data,
                        by = c("date", "week", "month", "year"),
                        roll = FALSE,
                        k = 7,
                        deployment_label = NULL,
                        species = NULL,
                        by_deployment = TRUE,
                        by_species = TRUE,
                        sample_start_date = NULL,
                        sample_end_date = NULL) {

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

  effort <- dplyr::mutate(
    effort,
    !!by := format(.data$date, by_fmt)
  ) %>%
    dplyr::group_by(
      .data$deployment_label,
      .data[[by]],
      .add = TRUE
    ) %>%
    dplyr::summarize(
      first_day = min(as.Date(.data$date)),
      last_day = max(as.Date(.data$date)),
      mean_snow_index = mean(.data$snow_index, na.rm = TRUE),
      mean_temperature = mean(.data$temperature, na.rm = TRUE),
      trap_days = n(),
      .groups = "drop"
    )

  dat <- filter_if_not_null(image_data, species)

  dat$date <- as.Date(dat$date_time)
  dat[[by]] <- format(dat$date_time, by_fmt)

  if (isTRUE(by_species)) {
    dat <- dplyr::group_by(dat, .data$species, .add = TRUE)
  }

  dat <- dplyr::group_by(
    dat,
    .data$deployment_label,
    .data[[by]],
    .add = TRUE
  )

  dat <- dplyr::summarise(
    dat,
    total_count = sum(.data$total_count_episode, na.rm = TRUE),
  )

  out <- dplyr::left_join(
    effort,
    dat,
    by = c("deployment_label", by)
  )

  out <- tidyr::complete(
    out,
    tidyr::nesting(
      !!rlang::sym("deployment_label"),
      !!rlang::sym(by),
      !!rlang::sym("first_day"),
      !!rlang::sym("last_day"),
      !!rlang::sym("mean_snow_index"),
      !!rlang::sym("mean_temperature"),
      !!rlang::sym("trap_days")
    ),
    .data$species,
    fill = list(total_count = 0)
  ) %>%
    dplyr::filter(!is.na(.data$species))

  dplyr::mutate(
    out,
    rai = .data$total_count / .data$trap_days
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

prep_rai <- function(image_data,
                     deployment_label,
                     species,
                     by_deployment_label,
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

  if (isTRUE(by_deployment_label)) {
    dat <- dplyr::group_by(dat, .data$deployment_label)
  }

  if (isTRUE(by_species)) {
    dat <- dplyr::group_by(dat, .data$species, .add = TRUE)
  }

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
      date = as.Date(.data$date_time)
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


