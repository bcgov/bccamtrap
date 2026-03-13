# Read project-level data from the RISC worksheet 'Project Information' tab

This will read in the project information from a RISC worksheet
following the 'v20230518' template

## Usage

``` r
read_project_info(path, ...)
```

## Arguments

- path:

  path to the RISC workbook

- ...:

  arguments passed on to
  [`readxl::read_excel()`](https://readxl.tidyverse.org/reference/read_excel.html)

## Value

a `data.frame` of project-level information
