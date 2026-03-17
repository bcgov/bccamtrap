migration_data <- read_image_data(
  "inst/extdata/example-data/Example-input-CSV_migration-cams_Migration_v1.csv"
)
# Choose from the menu of templates (#3 - Migration Template) since the template name is not in the file name

head(migration_data)

summary(migration_data)

qa_image_data(migration_data, check_snow = FALSE, exclude_human_use = FALSE)

# rai_by_time(migration_data)

wallow_elk_data <- read_image_data(
  "inst/extdata/example-data/Example-input-CSV_wallow-cams_Elk_Template_Wallows_v1.csv"
)

summary(wallow_elk_data)

qa_image_data(wallow_elk_data, check_snow = FALSE, exclude_human_use = FALSE)

new_wallow_elk_data <- read_image_data(
  "inst/extdata/example-data/Example input CSV_wallow cams_updated approach.csv"
)

# Choose from the menu of temlates (#4 - Wallows)

summary(new_wallow_elk_data)

qa_image_data(
  new_wallow_elk_data,
  check_snow = FALSE,
  exclude_human_use = FALSE
)
