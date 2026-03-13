#' Launch Shiny app
#'
#' Interactive interface for Data import, QA, and export.
#'
#' @import shiny
#' @import bslib
#' @import gt
#'
#' @param browser Should the app be launched in the default browser? Default `TRUE`
#' @param max_upload_size_mb The maximum file size able to load into the app, in MB. Default `50`.
#' @param ... passed on to `options` in [shiny::shinyApp()]
#'
#' @examples
#' \dontrun{bccamtrapp()}
#'
#' @concept shiny_app
#'
#' @export
bccamtrapp <- function(browser = TRUE, max_upload_size_mb = 50, ...) {
  shiny::addResourcePath("www", system.file("www/", package = "bccamtrap"))

  withr::with_options(list(shiny.maxRequestSize = max_upload_size_mb*1024^2), {
    shiny::runApp(list(ui = ui, server = server), launch.browser = browser, ...)
  })
}

x_or_null <- function(x) {
  if (!shiny::isTruthy(x)) NULL else x
}

yesno_as_logical <- function(x, default) {
  if (is.null(x) || length(x) == 0) return(default)
  x == "Yes"
}
