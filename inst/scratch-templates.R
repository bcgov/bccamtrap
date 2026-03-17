# devtools::install_github("bcgov/bccamtrap")
library(bccamtrap)

migration_data <- read_image_data(
  "inst/extdata/example-data/Example-input-CSV_migration-cams_Migration_v1.csv"
)
# Choose from the menu of templates (#3 - Migration Template) since the template name is not in the file name

head(migration_data)

summary(migration_data)

migration_data_qa <- qa_image_data(
  migration_data,
  check_snow = FALSE,
  exclude_human_use = FALSE
)

migration_data_qa

wallow_elk_data <- read_image_data(
  "inst/extdata/example-data/Example-input-CSV_wallow-cams_Elk_Template_Wallows_v1.csv"
)

# The name of the template is in the file name, so it should be automatically
# detected and used to read the data

summary(wallow_elk_data)

wallow_elk_data_qa <- qa_image_data(
  wallow_elk_data,
  check_snow = FALSE,
  exclude_human_use = FALSE
)

wallow_elk_data_qa

new_wallow_elk_data <- read_image_data(
  "inst/extdata/example-data/Example-input-CSV_wallow-cams_updated_approach.csv"
)

# Choose from the menu of temlates (#4 - Wallows)

summary(new_wallow_elk_data)

new_wallow_elk_data_qa <- qa_image_data(
  new_wallow_elk_data,
  check_snow = FALSE,
  exclude_human_use = FALSE
)

new_wallow_elk_data_qa
