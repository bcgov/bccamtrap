# Write data to a new SPI submission file from field form data

This will write only the default columns for each of the tabs in the SPI
template.

## Usage

``` r
fill_spi_template_ff(
  sample_station_info,
  deployments,
  image_data = NULL,
  wlrs_project_name = NULL,
  file,
  template = default_spi_template()
)
```

## Arguments

- sample_station_info:

  object of class `c("sample_station_info", "field-form")`

- deployments:

  object of class `c("deployments", "field-form")`

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

- wlrs_project_name:

  the name of the project to write, if there is more than one project in
  `sample_station_info` and/or `deployments`.

- file:

  path to the output file (`.xls*`)

- template:

  SPI submission template to use. Default is included in the package,
  accessed by
  `system.file("GENERIC_wildlife_camera_template_v2021.xlsm", package = "bccamtrap")`

## Value

path to the output `file`

## Details

`sample_station_info` and `deployments` are required. If you want to
only write to the metadata tabs and not the Sequence Image Data, you can
leave the `image_data` argument as `NULL`, and write to the file another
time with
[`write_to_spi_sheet()`](https://bcgov.github.io/bccamtrap/reference/write_to_spi_sheet.md).
