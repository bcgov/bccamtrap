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
                        by = c("day", "week", "month", "year"),
                        roll = FALSE,
                        k = 7,
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

  by <- match.arg(by)
  by_fmt <- switch(
    by,
    "day" = "%Y-%m-%d",
    "week" = "%Y-W-%V",
    "month" = "%Y-%m",
    "year" = "%Y"
  )

  dat <- dplyr::mutate(
    dat,
    !!by := format(.data$date_time, by_fmt)
  )

  dat <- dplyr::group_by(
    dat,
    .data[[by]],
    .add = TRUE
  )

  dat <- dplyr::mutate(
    dat,
    start_date = min(as.Date(.data$date_time)),
    end_date = max(as.Date(.data$date_time)),
    trap_days = dplyr::n_distinct(as.Date(.data$date_time)) - sum(.data$lens_obscured)
  )

  dat <- dplyr::group_by(
    dat,
    .data$start_date,
    .data$end_date,
    .data$trap_days,
    .data$species,
    .add = TRUE
  )

  dplyr::summarize(
    dat,
    total_count = sum(.data$total_count_episode, na.rm = TRUE),
    rai = sum(.data$total_count, na.rm = TRUE) / max(as.numeric(.data$trap_days, units = "days")),
    mean_snow = mean(.data$snow_depth_lower, na.rm = TRUE),
    mean_temp = mean(.data$temperature, na.rm = TRUE),
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

  dat <- dplyr::filter(dat, !is.na(.data$species))
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


