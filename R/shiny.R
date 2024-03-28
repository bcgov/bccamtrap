#' Launch Shiny app
#'
#' Interactive interface for Data import, QA, and export.
#'
#' @import shiny
#' @import bslib
#' @import gt
#'
#' @param ... passed on to [shiny::shinyApp()]
#'
#' @examples
#' \dontrun{bccamtrapp()}
#'
#' @concept shiny_app
#'
#' @export
bccamtrapp <- function(...) {
  shiny::addResourcePath("www", system.file("www/", package = "bccamtrap"))
  shiny::shinyApp(ui = ui, server = server, ...)
}

x_or_null <- function(x) {
  if (!shiny::isTruthy(x)) NULL else x
}

yesno_as_logical <- function(x, default) {
  if (is.null(x) || length(x) == 0) return(default)
  x == "Yes"
}
