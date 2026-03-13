source("data-raw/field_info.R")
source("data-raw/spp-codes.R")

usethis::use_data(
  tl_template_v20230518_1,
  spp_codes,
  overwrite = TRUE,
  internal = TRUE
)
