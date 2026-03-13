# Launch Shiny app

Interactive interface for Data import, QA, and export.

## Usage

``` r
bccamtrapp(browser = TRUE, max_upload_size_mb = 50, ...)
```

## Arguments

- browser:

  Should the app be launched in the default browser? Default `TRUE`

- max_upload_size_mb:

  The maximum file size able to load into the app, in MB. Default `50`.

- ...:

  passed on to `options` in
  [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html)

## Examples

``` r
if (FALSE) bccamtrapp() # \dontrun{}
```
