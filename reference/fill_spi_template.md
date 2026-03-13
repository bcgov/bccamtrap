# Write all data to a new SPI submission file

This will write only the default columns for each of the tabs in the SPI
template. For more fine-grained control, use
[`write_to_spi_sheet()`](https://bcgov.github.io/bccamtrap/reference/write_to_spi_sheet.md)
on each of `sample_station_info`, `camera_info`, `cam_setup_checks`,
`image_data`.

## Usage

``` r
fill_spi_template(
  sample_station_info,
  camera_info,
  camera_setup_checks,
  image_data,
  file,
  template = default_spi_template()
)
```

## Arguments

- sample_station_info:

  object of class `sample_station_info`

- camera_info:

  object of class `camera_info`

- camera_setup_checks:

  object of class `camera_setup_checks`

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- file:

  path to the output file (`.xls*`)

- template:

  SPI submission template to use. Default is included in the package,
  accessed by
  `system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")`

## Value

path to the output `file`
