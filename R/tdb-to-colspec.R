tdb_to_colspec <- function(tdb, col_names = NULL) {
  template <- parse_tdb(tdb)
  template_list <- map_tdb_types_to_colspec(template, col_names)

  # Master template has more specific field type mapping, so
  # use it to fill in any character fields in the template that might
  # have better-defined types in the master template
  master_template <- system.file(
    "extdata",
    "timelapse-templates",
    "!RISC_WCR_MasterTemplateFieldPicklist_DONOTEDIT_20250109.tdb",
    package = "bccamtrap"
  ) |>
    parse_tdb() |>
    map_tdb_types_to_colspec(names(template_list), warn_missing = FALSE)

  template_list <- modifyList(
    master_template[intersect(names(master_template), names(template_list))],
    template_list
  )

  do.call(readr::cols_only, template_list)
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

map_tdb_types_to_colspec <- function(
  tdb_template,
  col_names = NULL,
  warn_missing = TRUE
) {
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
    type_map[[field$type]] %||% readr::col_character()
  })

  names(col_spec_list) <- names(tdb_template)

  if (!is.null(col_names)) {
    missing_cols <- setdiff(names(col_spec_list), col_names)

    if (length(missing_cols) > 0) {
      if (warn_missing) {
        cli::cli_warn(
          "The following columns are in the data but not in the template: {.str {missing_cols}}. They will be read with guessed types.",
          class = "tdb_colspec_warning"
        )
      }

      for (col in missing_cols) {
        col_spec_list[[col]] <- readr::col_character()
      }
    }
  } else {
    col_names <- names(col_spec_list)
  }

  col_spec_list[intersect(names(col_spec_list), col_names)]
}
