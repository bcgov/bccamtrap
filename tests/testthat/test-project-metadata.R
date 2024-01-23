test_that("read_project_info works", {
  expect_s3_class(read_project_info(test_meta_file1), "data.frame")
  expect_s3_class(read_project_info(test_meta_file2), "data.frame")
})
