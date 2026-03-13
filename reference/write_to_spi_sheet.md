# Write a single data frame to SPI submission template

If you want to write to an existing file, specify the same file name in
both the `file` and the `template` parameters.

## Usage

``` r
write_to_spi_sheet(x, file, ..., template = default_spi_template())
```

## Arguments

- x:

  object of class `sample_station_info`, `camera_info`,
  `cam_setup_checks`, or `image_data`

- file:

  path to the output file (`.xls*`)

- ...:

  extra columns in `x` to write out. Must be paired column names in the
  form `` `Destination Column` = data_column ``. If the left-hand side
  is a syntactically valid name it can be provided as-is, but if it has
  spaces in it it must be wrapped in backticks or quotes. See examples.

- template:

  SPI submission template to use. Default is included in the package,
  accessed by
  `system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")`

## Value

input `x`, invisibly

## Examples

``` r
if (FALSE) { # \dontrun{
write_to_spi_sheet(camera_setup_checks_data, "my_spi_submission.xlsx")
write_to_spi_sheet(image_data, "my_spi_submission.xlsx", Surveyor = surveyor,
   `Survey Observation Photos` = file)
} # }
```
