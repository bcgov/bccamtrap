hide_numbers <- function(x) {
  gsub("[0-9]", "X", x)
}

hide_names <- function(x) {
  for (n in c("study_area_name", "surveyor", "data_qc_complete")) {
    if (n %in% names(x)) {
      x[[n]] <- "Hidden"
    }
  }
  x
}

rm_id_cols <- function(x) {
  dplyr::select(
    x,
  -dplyr::any_of(c("study_area_name", "sample_station_label"))
  )
}
