# Calculate RAI over a window of time, optionally rolling

This function takes a data frame of image data and calculates snow,
temperature, effort, count, and RAI metrics aggregated over a specified
time window. These can optionally be calculated using a moving window
("rolling") calculation.

## Usage

``` r
rai_by_time(
  image_data,
  by = c("date", "week", "month", "year"),
  roll = FALSE,
  k = 7,
  by_species = TRUE,
  species = NULL,
  by_deployment = FALSE,
  deployment_label = NULL,
  sample_start_date = NULL,
  sample_end_date = NULL,
  snow_agg = "max"
)
```

## Arguments

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- by:

  time to aggregate by: One of `"date"` (default), `"week"`, `"month"`,
  or `"year"`.

- roll:

  should it use a rolling window? Default `FALSE`

- k:

  the size of the rolling window. Default `7`.

- by_species:

  Should an RAI be calculated for each species (`TRUE`, default), or one
  RAI for all species (`FALSE`)

- species:

  Optionally, or more species as a character vector. Default `NULL` to
  calculate RAI for each species detected.

- by_deployment:

  Should it be calculated by `deployment`. Default `FALSE`

- deployment_label:

  Optionally, one or more deployment labels to select. Default `NULL` to
  use all deployments.

- sample_start_date:

  a custom start date. Note that this will apply the same start date to
  all deployments/sessions in the data.

- sample_end_date:

  a custom end date. Note that this will apply the same start date to
  all deployments/sessions in the data.

- snow_agg:

  if `by_deployment = FALSE`, how to aggregate snow measurements across
  sites. Takes the name of an aggregation function (e.g., `"mean"`).
  Default `"max"`

## Value

a data.frame of above calculated metrics
