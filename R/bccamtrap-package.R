#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @import rlang
#' @importFrom methods setOldClass
#' @importFrom dplyr %>%
## usethis namespace: end
NULL

utils::globalVariables("closest")

ignore_unused_imports <- function() {
  # Only used in shiny app
  bslib::bs_theme
  gt::gt
}

