# Merge image data with deployment data

Attach deployment metadata with image data.

## Usage

``` r
merge_deployments_images(
  deployments,
  image_data,
  drop_unjoined = FALSE,
  as_sf = TRUE
)
```

## Arguments

- deployments:

  deployments data, as created by
  [`make_deployments()`](https://bcgov.github.io/bccamtrap/reference/make_deployments.md)

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- drop_unjoined:

  if there are unmatched `deployment_labels` between deployments and
  image data, should they be dropped from the output (this is equivalent
  to a
  [`dplyr::inner_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html))?
  Default is `FALSE`.

- as_sf:

  should the data be returned as an `sf` object of the station
  locations? Default `TRUE`

## Value

`data.frame` of class `image_data`, with `deployment` columns attached
