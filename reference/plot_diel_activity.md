# Plot daily activity of species detected by motion detection

Plot daily activity of species detected by motion detection

## Usage

``` r
plot_diel_activity(image_data, interactive = FALSE, ...)
```

## Arguments

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- interactive:

  should the plot be interactive? Default `FALSE`

- ...:

  passed on to
  [`ggiraph::girafe()`](https://davidgohel.github.io/ggiraph/reference/girafe.html)
  for setting options for interactive graphs

## Value

a `ggplot2` object if `interactive = FALSE`, a `ggiraph` object if
`TRUE`
