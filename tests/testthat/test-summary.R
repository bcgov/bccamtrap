test_that("summary.sample_stations works", {
  ss1 <- hide_names(read_sample_station_info(test_meta_file1))
  ss2 <- hide_names(read_sample_station_info(test_meta_file2))

  expect_snapshot(summary(ss1))
  expect_snapshot(summary(ss2))

  ss1 <- qa_stations_spatial(ss1)
  ss2 <- qa_stations_spatial(ss2)

  expect_snapshot(summary(ss1))
  expect_snapshot(summary(ss2))
})

test_that("summary.deployments works", {
  sessions1 <- hide_names(make_deployments(test_meta_file1))
  sessions2 <- hide_names(make_deployments(test_meta_file2))

  expect_snapshot(summary(sessions1))
  expect_snapshot(summary(sessions2))
})

test_that("summary.image_data works", {
  id1 <- hide_names(read_image_data(test_dir_1))
  id2 <- hide_names(read_image_data(test_dir_2))

  expect_snapshot(summary(id1))
  expect_snapshot(summary(id2))
})

test_that("summary.sample_stations works - field forms", {
  ss_csv <- read_sample_station_csv(test_path("sample-station-field-form.csv"))

  expect_snapshot(summary(ss_csv))

  ss_csv <- qa_stations_spatial(ss_csv)

  expect_snapshot(summary(ss_csv))
})

test_that("summary.deployments works - field forms", {
  dep_csv <- read_deployments_csv(test_path("deployments-field-form.csv"))

  expect_snapshot(summary(dep_csv))
})
