test_that("creating a sessions table works", {
  out <- make_sample_sessions(test_meta_file1)
  expect_s3_class(out, "sf")
  out <- make_sample_sessions(test_meta_file1, as_sf = FALSE)
  expect_false(inherits(out, "sf"))
})
