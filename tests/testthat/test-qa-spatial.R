test_that("Spatial QA works", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  ssi_sf2 <- read_sample_station_info(test_meta_file2)
  expect_message(checked <- qa_stations_spatial(ssi_sf1))
  expect_silent(checked2 <- qa_stations_spatial(ssi_sf2))
  expect_s3_class(checked, "sf")
  expect_s3_class(checked2, "sf")
  expect_named(checked, c(names(ssi_sf1), "spatial_outlier"))
  expect_named(checked2, c(names(ssi_sf2), "spatial_outlier"))
  expect_type(checked$spatial_outlier, "logical")
  expect_type(checked2$spatial_outlier, "logical")
})

test_that("find_dist_outliers works", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  ssi_sf2 <- read_sample_station_info(test_meta_file2)
  expect_type(find_dist_outliers(ssi_sf1), "logical")
  expect_type(find_dist_outliers(ssi_sf2), "logical")
  expect_equal(find_dist_outliers(ssi_sf1), c(TRUE, rep(FALSE, 12)))
  expect_false(all(find_dist_outliers(ssi_sf2)))
  expect_equal(
    find_dist_outliers(ssi_sf1, dist_thresh = 3000),
    c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE,
      FALSE, FALSE)
  )
})

test_that("map_stations works", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  ssi_sf2 <- read_sample_station_info(test_meta_file2)
  withr::with_options(
    list(mapviewViewerSuppress = FALSE), {
      expect_s4_class(map_stations(ssi_sf1), "mapview")
      expect_s4_class(map_stations(ssi_sf2), "mapview")
    }
  )
})

test_that("Spatial QA works - field forms", {
  ss_csv <- read_sample_station_csv(test_path("sample-station-field-form.csv"))
  expect_silent(checked <- qa_stations_spatial(ss_csv))
  expect_s3_class(checked, "sf")
  expect_named(checked, c(names(ss_csv), "spatial_outlier"))
  expect_type(checked$spatial_outlier, "logical")
})
