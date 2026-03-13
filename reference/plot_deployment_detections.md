# Plot image timestamps over deployment periods

Plot detections over sample deployments to check for misaligned time
stamps

## Usage

``` r
plot_deployment_detections(
  deployments,
  image_data,
  date_breaks = "1 month",
  interactive = FALSE,
  ...
)
```

## Arguments

- deployments:

  deployments data, as created by
  [`make_deployments()`](https://bcgov.github.io/bccamtrap/reference/make_deployments.md)

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- date_breaks:

  How to break up the dates on the x axis. See
  [`scales::date_breaks()`](https://scales.r-lib.org/reference/date_breaks.html).
  Default `"1 month"`

- interactive:

  should the plot be interactive? Default `FALSE`

- ...:

  passed on to
  [`ggiraph::girafe()`](https://davidgohel.github.io/ggiraph/reference/girafe.html)
  for setting options for interactive graphs

## Value

a `ggplot2` object if `interactive = FALSE`, a `ggiraph` object if
`TRUE`
