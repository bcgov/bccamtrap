# Perform a series of QA checks on the Timelapse Image data

- Check for blanks in key fields (study area, station label, deployment
  date, surveyor, trigger mode, temperature, episode)

- Species detected with no count data

- Count data with no species

- Sum of subcount fields equals Total Count

- Multiple entries under same Episode number (indicating possible double
  entry)

- Ensure dates for timelapse images are continuous and in order.

- Ensure daily timelapse photos are at the expected time

- Snow data

  - No blanks unless lens obscured is TRUE

  - Look for snow depth outliers (e.g., 10, 10, 110, 10, 15, 20)

## Usage

``` r
qa_image_data(
  image_data,
  exclude_human_use = TRUE,
  check_snow = TRUE,
  tl_time = "12:00:00"
)
```

## Arguments

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- exclude_human_use:

  should images where `human_use_type` indicates a motion detection
  event from humans be excluded from the count/species checks? Default
  `TRUE`.

- check_snow:

  show `QA` be performed on snow measurements? Default `TRUE`

- tl_time:

  the time of day timelapse images should be set at. Default "12:00:00"

## Value

input data frame with additional `QA_*` columns appended, and subset
only to rows where a QA issue was flagged.
