# Create a spatial data frame of deployments

Merge data from "Sample Station Info", "Camera Information", and "Camera
Setup and Checks" tabs to create deployments - the time that a camera
was deployed and running at a site. "Invalid" deployments are flagged
when there is no sampling end date in "Camera Setup and Checks" or the
sampling period is 0 days

## Usage

``` r
make_deployments(path, as_sf = TRUE)
```

## Arguments

- path:

  path to the RISC workbook

- as_sf:

  should the data be returned as an `sf` object of the station
  locations? Default `TRUE`

## Value

a spatial data.frame (`sf`) of deployments
