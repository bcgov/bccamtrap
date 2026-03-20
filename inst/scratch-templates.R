# devtools::install_github("bcgov/bccamtrap")
library(bccamtrap)
library(dplyr)

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

migration_map <- tribble(
  ~sample_station_label , ~upstream ,
  "Kay-A"               , "R to L"  ,
  "Kay-B"               , "R to L"  ,
  "UpperAdam-A"         , "L to R"  ,
  "UpperAdam-B"         , "R to L"  ,
  "SwampLake-A"         , "L to R"  ,
  "SwampLaKe-B"         , "R to L"  ,
  "SwampLake-B"         , "T to B"  ,
  "MerrillLk-A"         , "L to R"  ,
  "Salmon4-A"           , "R to L"  ,
  "Salmon-A"            , "R to L"  ,
  "Salmon-B"            , "L to R"  ,
  "Memekay-A"           , "L to R"
)

collapse_migration_episodes(migration_data_qa, migration_map = migration_map)

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


collapse_wallow_episodes(wallow_elk_data)

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


collapse_wallow_episodes(new_wallow_elk_data)
