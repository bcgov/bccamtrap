# Read image data from a collection of csvs from TimeLapse

This function reads in image data from a directory of csv files, or a
character vector of csv file paths. It attempts to identify the
appropriate TimeLapse template to use based on the file names, but a
specific template can also be provided. The function does some basic
standardization and cleaning of the data, and returns a data.frame with
an "image_data" class and an attribute "template" with the name of the
template used to read the data.

## Usage

``` r
read_image_data(path, pattern, recursive = FALSE, template = NULL, ...)
```

## Arguments

- path:

  path to directory of image files, a single .csv file, or a character
  vector of .csv files.

- pattern:

  an optional regular expression. Only file names which match the
  regular expression will read. Default `FALSE`.

- recursive:

  should files found within subfolders of `path` also be read?

- template:

  path to a "`.tdb`" TimeLapse Template file. Optional; if not provided,
  the function will attempt to identify the appropriate internal
  template based on the file names in `path`.

- ...:

  arguments passed on to
  [`readr::read_csv()`](https://readr.tidyverse.org/reference/read_delim.html)

## Value

a `data.frame` of Timelapse image data from the files found in `path`.
The data.frame will have an "image_data" class, and an attribute
"template" with the name of the template used to read the data.

## Details

In addition to reading in the data, this function also:

- does basic standardization of trigger mode values,

- creates numeric snow depth columns,

- checks for the presence of a `total_count_episode` column, adding one
  if missing,

- standardizes column names to snake_case.

- If the data has separate `Date` and `Time` columns instead of a
  combined `DateTime` column, these will be reconciled into a single
  `DateTime` column.

For wallow data, this also removes motion-activated static images, and
only keeps the motion-activated video records and the time-lapse static
image records.
