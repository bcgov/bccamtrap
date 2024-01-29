test_that("Spatial QA works", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  expect_message(checked <- check_stations_spatial(ssi_sf1))
  expect_s3_class(checked, "sf")
  expect_named(checked, c(names(ssi_sf1), "spatial_outlier"))
  expect_type(checked$spatial_outlier, "logical")
})
