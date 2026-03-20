# Collapse motion detection events into episodes

Collapse motion detection events into episodes

## Usage

``` r
collapse_migration_episodes(df, migration_map)
```

## Arguments

- df:

  a data frame of migration image data, read in with
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- migration_map:

  A small data.frame defining the upstream direction(s) of travel for
  each sample station. Valid upstream values are: `"L to R"`,
  `"R to L"`, `"T to B"`, `"B to T"`. Columns must include:

  - `sample_station_label`

  - `upstream`

## Value

a data frame with motion detection events collapsed into 1 row per
episode, and summary information about each episode (e.g. duration,
number of triggers, total count, direction of travel, ...).
