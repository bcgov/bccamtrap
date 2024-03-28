#' Launch Shiny app
#'
#' Interactive interface for Data import, QA, and export.
#'
#' @import shiny
#' @import bslib
#' @import gt
#'
#' @param browser Should the app be launched in the default browser? Default `TRUE`
#' @param ... passed on to `options` in [shiny::shinyApp()]
#'
#' @examples
#' \dontrun{bccamtrapp()}
#'
#' @concept shiny_app
#'
#' @export
bccamtrapp <- function(browser = TRUE, ...) {
  shiny::addResourcePath("www", system.file("www/", package = "bccamtrap"))
  shiny::shinyApp(ui = ui, server = server, options = list(launch.browser = browser, ...))
}

x_or_null <- function(x) {
  if (!shiny::isTruthy(x)) NULL else x
}

yesno_as_logical <- function(x, default) {
  if (is.null(x) || length(x) == 0) return(default)
  x == "Yes"
}
