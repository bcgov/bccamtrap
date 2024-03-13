# Default NULL operator from rlang
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

# Reexport from base on newer versions of R to avoid conflict messages
if (exists("%||%", envir = baseenv())) {
  `%||%` <- get("%||%", envir = baseenv())
}

compact <- function(l) {
  Filter(Negate(is.null), l)
}

invert <- function(v) {
  stats::setNames(names(v), v)
}
