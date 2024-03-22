#' Calculate Relative Activity Index (RAI)
#'
#' Calculate the RAI
#'
#' @param sample_sessions A data.frame of `sample_sessions`, from
#'   [make_sample_sessions()]
#' @inheritParams qa_image_data
#' @param deployment_label One or more deployment labels to select
#' @param species One or more species as a character vector. Default `NULL` to
#'   calculate RAI for each species detected.
#' @param by_deployment_label Should an RAI be calculated for each deployment
#'   label (`TRUE`, default), or one RAI for all deployment labels (`FALSE`)
#' @param by_species Should an RAI be calculated for each species (`TRUE`,
#'   default), or one RAI for all species (`FALSE`)
#' @param sample_start_date a custom start date. Note that this will apply the
#'   same start date to all deployments/sessions in the data, so setting this is
#'   most useful when using a single deployment by setting `deployment_label` to
#'   a single value.
#' @param sample_end_date a custom end date. Note that this will apply the same
#'   start date to all deployments/sessions in the data, so setting this is most
#'   useful when using a single deployment by setting `deployment_label` to a
#'   single value.
#'
#' @return a data.frame of RAI, by deployment label and species (if `by_species = TRUE`)
#' @export
#'
#' @examples
rai <- function(sample_sessions,
                image_data,
                deployment_label = NULL,
                species = NULL,
                by_deployment_label = TRUE,
                by_species = TRUE,
                sample_start_date = NULL,
                sample_end_date = NULL) {

  check_sample_sessions(sample_sessions)
  check_image_data(image_data)

  dat <- dplyr::right_join(
    sample_sessions,
    image_data,
    by = c("sample_station_label", "deployment_label")
  )

  dat$sample_end_date <- dat$max_tl_date

  dat <- dplyr::filter(dat, !is.na(.data$species))
  dat <- filter_if_not_null(dat, deployment_label)
  dat <- filter_if_not_null(dat, species)

  if (!is.null(sample_start_date)) {
    dat <- dplyr::filter(.data$date_time >= lubridate::as_datetime(sample_start_date))
    dat$sample_start_date <- sample_start_date
  }

  if (!is.null(sample_end_date)) {
    dat <- dplyr::filter(.data$date_time <= lubridate::as_datetime(sample_end_date))
    dat$sample_end_date <- sample_end_date
  }

  if (isTRUE(by_deployment_label)) {
    dat <- dplyr::group_by(dat, .data$deployment_label)
  }

  dat <- dplyr::group_by(
    dat,
    .data$sample_start_date,
    .data$sample_end_date,
    .data$sample_period_length,
    .add = TRUE
  )

  if (isTRUE(by_species)) {
    dat <- dplyr::group_by(dat, .data$species, .add = TRUE)
  }

  # check for missing counts

  dplyr::summarize(
    dat,
    total_count = sum(.data$total_count_episode, na.rm = TRUE),
    rai = sum(.data$total_count, na.rm = TRUE) / max(as.numeric(.data$sample_period_length, units = "days")),
    .groups = "drop"
  )

}


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


