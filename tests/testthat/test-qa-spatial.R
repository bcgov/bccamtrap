test_that("Spatial QA works", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  expect_message(checked <- check_stations_spatial(ssi_sf1))
  expect_s3_class(checked, "sf")
  expect_named(checked, c(names(ssi_sf1), "spatial_outlier"))
  expect_type(checked$spatial_outlier, "logical")
})

test_that("find_dist_outliers works", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  expect_type(find_dist_outliers(ssi_sf1), "logical")
  expect_equal(find_dist_outliers(ssi_sf1), c(TRUE, rep(FALSE, 12)))
  expect_equal(
    find_dist_outliers(ssi_sf1, dist_thresh = 3000),
    c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE,
      FALSE, FALSE)
  )
})
