# Calculate Relative Activity Index (RAI)

Calculate the RAI for sample sessions and species. Optionally set start
date and end date, deployment label(s), and species. You can choose to
calculate RAI by species and deployment label, or as a whole.

## Usage

``` r
sample_rai(
  image_data,
  deployment_label = NULL,
  species = NULL,
  by_deployment = TRUE,
  by_species = TRUE,
  sample_start_date = NULL,
  sample_end_date = NULL
)
```

## Arguments

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- deployment_label:

  Optionally, one or more deployment labels to select. Default `NULL` to
  use all deployments.

- species:

  Optionally, or more species as a character vector. Default `NULL` to
  calculate RAI for each species detected.

- by_deployment:

  Should an RAI be calculated for each deployment label (`TRUE`,
  default), or one RAI for all deployment labels (`FALSE`)

- by_species:

  Should an RAI be calculated for each species (`TRUE`, default), or one
  RAI for all species (`FALSE`)

- sample_start_date:

  a custom start date. Note that this will apply the same start date to
  all deployments/sessions in the data.

- sample_end_date:

  a custom end date. Note that this will apply the same start date to
  all deployments/sessions in the data.

## Value

a data.frame of RAI, by deployment label and species (if
`by_species = TRUE`)
