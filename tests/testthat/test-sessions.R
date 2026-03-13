test_that("creating a deployments table works", {
  out <- make_deployments(test_meta_file1)
  expect_s3_class(out, c("deployments", "sf"))
  out <- make_deployments(test_meta_file1, as_sf = FALSE)
  expect_s3_class(out, c("deployments", "data.frame"))
  expect_false(inherits(out, "sf"))

  expect_snapshot_value(lapply(out, class), style = "json2")

  out2 <- make_deployments(test_meta_file1)
  expect_s3_class(out2, c("deployments", "sf"))
  out2 <- make_deployments(test_meta_file1, as_sf = FALSE)
  expect_s3_class(out, c("deployments", "data.frame"))
  expect_false(inherits(out2, "sf"))

  expect_snapshot_value(lapply(out2, class), style = "json2")
})

test_that("make_sample_sessions()", {
  imgs <- read_image_data(test_dir_1)

  sessions <- make_sample_sessions(imgs)

  expect_s3_class(sessions, "sample_sessions")

  expect_snapshot(sessions)

  sessions_diff_start_end <- make_sample_sessions(
    imgs,
    sample_start_date = "2022-12-16",
    sample_end_date = "2023-02-05"
  )

  expect_true(all(sessions_diff_start_end$sample_start_date >= lubridate::as_datetime("2022-12-16")))
  expect_true(all(sessions_diff_start_end$sample_end_date <= lubridate::as_datetime("2023-02-05")))
  expect_snapshot(sessions_diff_start_end)

  imgs2 <- read_image_data(test_dir_2)

  sessions2 <- make_sample_sessions(imgs2)

  expect_s3_class(sessions2, "sample_sessions")

  expect_snapshot(sessions2)
})
