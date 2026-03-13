# Read the "Camera Information" tab from the RISC worksheet.

This will read in the camera information from a RISC worksheet following
the 'v20230518' template

## Usage

``` r
read_camera_info(path, as_sf = TRUE, ...)
```

## Arguments

- path:

  path to the RISC workbook

- as_sf:

  should the data be returned as an `sf` object of the station
  locations? Default `TRUE`

- ...:

  arguments passed on to
  [`readxl::read_excel()`](https://readxl.tidyverse.org/reference/read_excel.html)

## Value

a `data.frame` of station information, as an `sf` object if specified.
