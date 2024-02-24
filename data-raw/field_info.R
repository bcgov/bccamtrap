# Copyright 2024 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

# Timelapse templates are simply a sqlite database with the extension .tdb
# This takes a timelapse template (Currently v20230518.1), reads it from the
# database, and transforms it into an R list with all of the field info.
# usethis::use_data() stores it as an interal dataset inside the package to use
# for field validation of input data.

library(DBI)
library(RSQLite)
library(jsonlite)

con <- DBI::dbConnect(RSQLite::SQLite(), "data-raw/RISC_WCR_ImageLabelling_Template_v20230518.1.tdb")

# dbListTables(con)

template_tbl <- dbReadTable(con, "TemplateTable")

template_tbl <- template_tbl[order(template_tbl$SpreadsheetOrder), ]

tl_template_v20230518_1 <- lapply(seq_len(nrow(template_tbl)), \(i) {
  row <- template_tbl[i, ]
  list(
    col = row$DataLabel,
    desc = row$Tooltip,
    type = row$type,
    default = row$DefaultValue,
    list = if (!nzchar(row$List)) NULL else jsonlite::fromJSON(row$List)
  )
})

names(tl_template_v20230518_1) <- vapply(
  tl_template_v20230518_1,
  `[[`,
  "col",
  FUN.VALUE = ""
)

usethis::use_data(tl_template_v20230518_1, overwrite = TRUE, internal = TRUE)
