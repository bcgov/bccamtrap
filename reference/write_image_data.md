# Write image data to a csv file

This is a very thin wrapper around
[`readr::write_csv()`](https://readr.tidyverse.org/reference/write_delim.html).
You can use that function directly for more control

## Usage

``` r
write_image_data(image_data, file, na = "", ...)
```

## Arguments

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- file:

  path to the output csv file

- na:

  How should missing values be written. Default empty (`""`)

- ...:

  other parameters passed on to
  [`readr::write_csv()`](https://readr.tidyverse.org/reference/write_delim.html)

## Value

input `image_data`, invisibly

## Examples

``` r
if (FALSE) { # \dontrun{
write_image_data(image_data, "my_spi_submission.xlsx")
write_image_data(image_data, "my_spi_submission.xlsx", Surveyor = surveyor,
   `Survey Observation Photos` = file)
} # }
```
