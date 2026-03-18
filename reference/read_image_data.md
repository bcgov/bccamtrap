# Read image data from a collection of csvs from TimeLapse

In addition to reading in the data, this function copies snow depth data
from the timelapse photo for each day into the motion photos for that
day, to facilitate analysis. It also does basic standardization of
trigger mode values, creates numeric snow depth columns, and checks for
the presence of a total_count_episode column, adding one if missing. If
the data has separate Date and Time columns instead of a combined
DateTime column, these will be reconciled into a single DateTime column.
All column names are standardized to snake_case.

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

For wallow data, this also removes static images (both timelapse and
motion activated), and only keeps the video records.
