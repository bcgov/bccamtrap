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

test_that("to_sf works", {
  x <- data.frame(
    "sample_station_label" = c(1,2,3,4,5),
    "utm_zone_sample_station" = rep(10,5),
    "easting_sample_station" = c(324249, 324885, 327421, 321769, 311450),
    "northing_sample_station" = c(5547908, 5551272, 5553009, 5561515, 5544809),
    "latitude_sample_station_dd" = c(50.0575, 50.0879, 50.1042, 50.179, 50.0257),
    "longitude_sample_station_dd" = c(-125.4553, -125.4480, -125.4134, -125.4963,
                                      -125.6324)
  )

  expect_silent(ret <- to_sf.sample_station_info(x, subclass = "spi-sheet"))
  expect_equal(nrow(ret), nrow(x))
  expect_false(all(sf::st_is_empty(ret)))

  x2 <- x
  x2$latitude_sample_station_dd <- NA
  expect_silent(ret2 <- to_sf.sample_station_info(x2, subclass = "spi-sheet"))
  expect_equal(nrow(ret), nrow(x))
  expect_false(all(sf::st_is_empty(ret2)))

  x3 <- x
  x3$latitude_sample_station_dd[3:5] <- NA
  x3$longitude_sample_station_dd[3:5] <- NA
  expect_silent(ret3 <- to_sf.sample_station_info(x3, subclass = "spi-sheet"))
  expect_equal(nrow(ret3), nrow(x))
  expect_false(all(sf::st_is_empty(ret3)))

  x4 <- x
  x4$easting_sample_station[3:5] <- NA
  x4$northing_sample_station[3:5] <- NA
  expect_silent(ret4 <- to_sf.sample_station_info(x4, subclass = "spi-sheet"))
  expect_equal(nrow(ret4), nrow(x))
  expect_false(all(sf::st_is_empty(ret4)))

  x5 <- x
  x5$easting_sample_station[4:5] <- NA
  x5$northing_sample_station[4:5] <- NA
  x5$latitude_sample_station_dd[1:2] <- NA
  x5$longitude_sample_station_dd[1:2] <- NA
  expect_silent(ret5 <- to_sf.sample_station_info(x5, subclass = "spi-sheet"))
  expect_equal(nrow(ret5), nrow(x))
  expect_false(all(sf::st_is_empty(ret5)))

  x6 <- x
  x6$easting_sample_station[3:5] <- NA
  x6$northing_sample_station[3:5] <- NA
  x6$latitude_sample_station_dd[3:5] <- NA
  x6$longitude_sample_station_dd[3:5] <- NA
  expect_warning(ret6 <- to_sf.sample_station_info(x6, subclass = "spi-sheet"))
  expect_equal(nrow(ret6), nrow(x))
  expect_false(all(sf::st_is_empty(ret6)))
})

