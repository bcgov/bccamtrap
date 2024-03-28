#' Launch Shiny app
#'
#' Interactive interface for Data import, QA, and esport.
#'
#' @examples
#' \dontrun{bccamtrap_app()}
#'
#' @concept shiny_app
#'
#' @export
bccamtrapp <- function(browser = TRUE) {
  appDir <- system.file("app", package = "bccamtrap")
  if (appDir == "") {
    stop("Could not find shiny app directory. ",
         "Try re-installing `bccamtrap`.", call. = FALSE)
  }

  shiny::runApp(appDir, launch.browser = browser)
}
