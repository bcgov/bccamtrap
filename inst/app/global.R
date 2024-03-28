library(shiny)
library(bslib)
library(dplyr)
library(leaflet)
library(gt)
library(plotly)
library(ggiraph)

x_or_null <- function(x) {
  if (!isTruthy(x)) NULL else x
}

yesno_as_logical <- function(x, default) {
  if (is.null(x) || length(x) == 0) return(default)
  x == "Yes"
}
