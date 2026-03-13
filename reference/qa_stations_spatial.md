# Check spatial attributes of Sample Station information

This checks for inconsistent placement of stations to flag potentially
incorrect location information

## Usage

``` r
qa_stations_spatial(stations, quant_thresh = 0.9, dist_thresh = NULL)
```

## Arguments

- stations:

  an `sf` data.frame as read in by
  [`read_sample_station_info()`](https://bcgov.github.io/bccamtrap/reference/read_sample_station_info.md)

- quant_thresh:

  The quantile above which the distance of a station from the other
  stations (compared to the average distance between stations) will be
  flagged as an outlier. Default `0.85`.

- dist_thresh:

  The distance (in m) above which the distance of a station from the
  other stations will be flagged as an outlier. By default the quantile
  is used, but can be overriden by setting this to a numeric value in
  metres.

## Value

the input data.frame, with a new `logical` column `spatial_outlier`
appended.

## See also

[`map_stations()`](https://bcgov.github.io/bccamtrap/reference/map_stations.md)
