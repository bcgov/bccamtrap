# Visualize stations on an interactive map

If the input data.frame has been run through
[`qa_stations_spatial()`](https://bcgov.github.io/bccamtrap/reference/qa_stations_spatial.md),
potential spatial outliers will be visually flagged.

## Usage

``` r
map_stations(stations)
```

## Arguments

- stations:

  an `sf` data.frame as read in by
  [`read_sample_station_info()`](https://bcgov.github.io/bccamtrap/reference/read_sample_station_info.md)

## Value

a mapview object

## See also

[`qa_stations_spatial()`](https://bcgov.github.io/bccamtrap/reference/qa_stations_spatial.md)
