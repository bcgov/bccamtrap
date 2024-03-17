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

test_that("make_sessions()", {
  deps <- make_deployments(test_meta_file1)
  imgs <- read_image_data(test_dir_1)

  sessions <- make_sessions(deps, imgs)

  expect_s3_class(sessions, "sample_sessions")
  expect_s3_class(sessions, "sf")

  expect_snapshot(sf::st_drop_geometry(sessions))

  sessions_no_sf <- make_sessions(deps, imgs, as_sf = FALSE)

  expect_s3_class(sessions_no_sf, "sample_sessions")
  expect_false(inherits(sessions_no_sf, "sf"))

  expect_snapshot(sessions_no_sf)

  deps2 <- make_deployments(test_meta_file2)
  imgs2 <- read_image_data(test_dir_2)

  sessions2 <- make_sessions(deps2, imgs2)

  expect_s3_class(sessions2, "sample_sessions")
  expect_s3_class(sessions2, "sf")

  expect_snapshot(sf::st_drop_geometry(sessions))
})
