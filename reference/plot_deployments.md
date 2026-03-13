# Plot timelines of image deployments

Make a plot of sampling deployments. The plot indicates start and end
times of each deployment, by station. It also shows "invalid" sample
deployments, for example if a camera was moved, stolen, ran out of
batteries etc. This is indicated by a light grey line and no end point.

## Usage

``` r
plot_deployments(
  deployments,
  date_breaks = "1 month",
  study_area_name = NULL,
  interactive = FALSE,
  ...
)
```

## Arguments

- deployments:

  deployments data, as created by
  [`make_deployments()`](https://bcgov.github.io/bccamtrap/reference/make_deployments.md)

- date_breaks:

  How to break up the dates on the x axis. See
  [`scales::date_breaks()`](https://scales.r-lib.org/reference/date_breaks.html).
  Default `"1 month"`

- study_area_name:

  Study area name for the plot. It will be used if it is already in the
  data in a `study_area_name` column, otherwise provide it here.

- interactive:

  should the plot be interactive? Default `FALSE`

- ...:

  passed on to
  [`ggiraph::girafe()`](https://davidgohel.github.io/ggiraph/reference/girafe.html)
  for setting options for interactive graphs

## Value

a `ggplot2` object if `interactive = FALSE`, a `ggiraph` object if
`TRUE`
