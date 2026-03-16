tdb_to_colspec <- function(tdb, col_names) {
  template <- parse_tdb(tdb)
  map_tdb_types_to_colspec(template, col_names)
}

parse_tdb <- function(tdb) {
  con <- DBI::dbConnect(
    RSQLite::SQLite(),
    tdb
  )

  on.exit(DBI::dbDisconnect(con))

  template_tbl <- DBI::dbReadTable(con, "TemplateTable")

  template_tbl <- template_tbl[order(template_tbl$SpreadsheetOrder), ]

  tl_template <- lapply(seq_len(nrow(template_tbl)), \(i) {
    row <- template_tbl[i, ]
    list(
      col = row$DataLabel,
      desc = row$Tooltip,
      type = row$Type,
      default = row$DefaultValue,
      list = if (!nzchar(row$List)) NULL else jsonlite::fromJSON(row$List)
    )
  })

  names(tl_template) <- vapply(
    tl_template,
    `[[`,
    "col",
    FUN.VALUE = ""
  )

  tl_template
}

map_tdb_types_to_colspec <- function(tdb_template, col_names) {
  # Map tdb types to readr col_spec types
  type_map <- list(
    "Note" = readr::col_character(),
    "IntegerPositive" = readr::col_integer(),
    "DateTime" = readr::col_datetime(),
    "Date" = readr::col_character(),
    "Time" = readr::col_character(),
    # Could be readr::col_factor with levels from the list column
    "FixedChoice" = readr::col_character(),
    "MultiChoice" = readr::col_character(),
    "RelativePath" = readr::col_character(),
    "File" = readr::col_character(),
    "DeleteFlag" = readr::col_logical(),
    "Flag" = readr::col_logical()
  )

  col_spec_list <- lapply(tdb_template, function(field) {
    type_map[[field$type]] %||% readr::col_guess()
  })

  names(col_spec_list) <- names(tdb_template)

  missing_cols <- setdiff(col_names, names(col_spec_list))

  if (length(missing_cols) > 0) {
    cli::cli_warn(
      "The following columns are in the data but not in the template: {.str {missing_cols}}. They will be read with guessed types.",
      class = "tdb_colspec_warning"
    )
    for (col in missing_cols) {
      col_spec_list[[col]] <- readr::col_guess()
    }
  }

  do.call(readr::cols, col_spec_list[col_names])
}
