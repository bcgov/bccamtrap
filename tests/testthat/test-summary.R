test_that("summary.sample_stations works", {
  ss1 <- read_sample_station_info(test_meta_file1)
  ss2 <- read_sample_station_info(test_meta_file2)

  expect_snapshot(summary(ss1))
  expect_snapshot(summary(ss2))

  ss1 <- check_stations_spatial(ss1)
  ss2 <- check_stations_spatial(ss2)

  expect_snapshot(summary(ss1))
  expect_snapshot(summary(ss2))
})

test_that("summary.sample_sessions works", {
  sessions1 <- make_sample_sessions(test_meta_file1)
  sessions2 <- make_sample_sessions(test_meta_file2)

  expect_snapshot(summary(sessions1))
  expect_snapshot(summary(sessions2))
})

test_that("summary.image_data works", {
  id1 <- read_image_data(test_dir_1)
  id2 <- read_image_data(test_dir_2)

  expect_snapshot(summary(id1))
  expect_snapshot(summary(id2))
})
