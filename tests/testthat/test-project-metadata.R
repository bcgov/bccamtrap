test_that("read_project_info works", {
  pi1 <- read_project_info(test_meta_file1)
  pi2 <- read_project_info(test_meta_file2)
  expect_s3_class(pi1, c("project_info", "data.frame"))
  expect_s3_class(pi2, c("project_info", "data.frame"))
  expect_named(pi1, c(
    "spi_project_id",
    "project_name",
    "survey_name",
    "survey_intensity_code"
  ))
  expect_equal(names(pi1), names(pi2))
})

test_that("read_sample_station_info works", {
  ssi1 <- read_sample_station_info(test_meta_file1, as_sf = FALSE)
  ssi2 <- read_sample_station_info(test_meta_file2, as_sf = FALSE)
  expect_s3_class(ssi1, c("sample_station_info", "data.frame"))
  expect_s3_class(ssi2, c("sample_station_info", "data.frame"))
  expect_snapshot(names(ssi1))
  expect_snapshot(names(ssi2))
})

test_that("read_sample_station_info works as sf", {
  ssi_sf1 <- read_sample_station_info(test_meta_file1)
  ssi_sf2 <- read_sample_station_info(test_meta_file2)
  expect_s3_class(ssi_sf1, c("sample_station_info", "sf"))
  expect_s3_class(ssi_sf2, c("sample_station_info", "sf"))
  expect_snapshot(names(ssi_sf1))
  expect_snapshot(names(ssi_sf2))
})

test_that("read_camera_info works", {
  ci1 <- read_camera_info(test_meta_file1, as_sf = FALSE)
  ci2 <- read_camera_info(test_meta_file2, as_sf = FALSE)
  expect_s3_class(ci1, c("camera_info", "data.frame"))
  expect_s3_class(ci2, c("camera_info", "data.frame"))
  expect_snapshot(names(ci1))
  expect_snapshot(names(ci2))
})

test_that("read_camera_info works as sf", {
  ci_sf1 <- read_camera_info(test_meta_file1)
  ci_sf2 <- read_camera_info(test_meta_file2)
  expect_s3_class(ci_sf1, c("camera_info", "sf"))
  expect_s3_class(ci_sf2, c("camera_info", "sf"))
  expect_snapshot(names(ci_sf1))
  expect_snapshot(names(ci_sf2))
})

test_that("read_cam_setup_checks works", {
  csc1 <- read_cam_setup_checks(test_meta_file1)
  csc2 <- read_cam_setup_checks(test_meta_file2)
  expect_s3_class(csc1, c("cam_setup_checks", "data.frame"))
  expect_s3_class(csc2, c("cam_setup_checks", "data.frame"))
  expect_snapshot(names(csc1))
  expect_snapshot(names(csc2))
})
