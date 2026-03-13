# Identify distinct sample sessions from timelapse image data

For each deployment label, this function:

- Sets sampling_start as first image date

- Counts photos (total, and motion-detection)

- Determines gaps in sampling period due to obscured lens

- Determines total length of sample period (number of days with Time
  Lapse photos - number of days with lens obscured)

## Usage

``` r
make_sample_sessions(
  image_data,
  sample_start_date = NULL,
  sample_end_date = NULL
)
```

## Arguments

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- sample_start_date:

  a custom start date. Note that this will apply the same start date to
  all deployments/sessions in the data.

- sample_end_date:

  a custom end date. Note that this will apply the same start date to
  all deployments/sessions in the data.

## Value

a data.frame of class `sample_sessions` with one row (sample session)
per deployment
