test_that("read_image_data() works", {
  imgs_1 <- read_image_data(test_dir_1)
  imgs_2 <- read_image_data(test_dir_2)
  expect_s3_class(imgs_1, c("image_data", "tbl"))
  expect_s3_class(imgs_2, c("image_data", "tbl"))
  expect_equal(ncol(imgs_1), 42)
  expect_equal(ncol(imgs_2), 42)
  expect_equal(names(imgs_1), names(imgs_2))

  expect_snapshot_value(lapply(imgs_1, class), style = "json2")
  expect_snapshot_value(lapply(imgs_2, class), style = "json2")
})

test_that("read_image_data() fails appropriately", {
  expect_snapshot(read_image_data("foofydir"), error = TRUE)

  # Empty directory
  dir <- withr::local_tempdir()
  expect_error(read_image_data(dir))
})

test_that("check_template() works", {
  files <- "dirname/123_Template_v12345678.csv"
  expect_equal(check_template(files), "v12345678")
  files <- c(
    files,
    "dirname/f123_Template_v87654321.csv"
  )
  expect_snapshot(check_template(files))
  expect_snapshot(check_template("temp_foobar.csv"), error = TRUE)
})

