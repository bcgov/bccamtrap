# Read csv output from sample station field form

Read csv output from sample station field form

## Usage

``` r
read_sample_station_csv(path, wlrs_project_name = NULL, as_sf = TRUE)
```

## Arguments

- path:

  path to the csv file exported from the field form

- wlrs_project_name:

  If you want to subset to a particular project or projects, supply the
  WLRS Project Names(s) as a character vector. If `NULL` (the default),
  reads all rows in the csv.

- as_sf:

  should the data be returned as an `sf` object of the station
  locations? Default `TRUE`

## Value

a data.frame (sf object if `as_sf = TRUE`) containing sample station csv
contents
