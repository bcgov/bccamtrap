# Collapse Wallow Episodes

Collapse Wallow Episodes

## Usage

``` r
collapse_wallow_episodes(df)
```

## Arguments

- df:

  a data frame of wallow image data, read in with
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

## Value

a data frame with wallow image data collapsed into 1 row per episode,
and summary information about each episode (e.g. duration, number of
triggers, total count, social and wallow behaviour, ...).
