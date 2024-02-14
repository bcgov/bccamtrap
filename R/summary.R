#' @export
summary.sample_station_info <- function(object, ...) {
  cli::cat_boxx(object$study_area_name[1], "Study Area")
  cli::cli_alert_info(c(
    "{length(unique(object$sample_station_label))}",
    " sample stations in {nrow(object)} locations"
  ))
  if ("spatial_outlier" %in% names(object)) {
    n_outliers <- sum(as.numeric(object$spatial_outlier))
    cli::cli_alert_warning(
      "There {?is/are} {cli::no(n_outliers)} spatial outlier{?s}."
    )
  }
}
