# Read the "Camera Setup and Checks" tab from the RISC worksheet.

This will read in the camera setup information from a RISC worksheet
following the 'v20230518' template

## Usage

``` r
read_cam_setup_checks(path, ...)
```

## Arguments

- path:

  path to the RISC workbook

- ...:

  arguments passed on to
  [`readxl::read_excel()`](https://readxl.tidyverse.org/reference/read_excel.html)

## Value

a `data.frame` of camera setup information
