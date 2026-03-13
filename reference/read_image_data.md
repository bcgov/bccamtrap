# Read image data from a collection of csvs from TimeLapse

In addition to reading in the data, this function copies snow depth data
from the timelapse photo for each day into the motion photos for that
day, to facilitate analysis.

## Usage

``` r
read_image_data(path, pattern, recursive = FALSE, ...)
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

- ...:

  arguments passed on to
  [`readr::read_csv()`](https://readr.tidyverse.org/reference/read_delim.html)

## Value

a `data.frame` of Timelapse image data from the files found in `path`
