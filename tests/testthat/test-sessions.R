test_that("creating a sessions table works", {
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
