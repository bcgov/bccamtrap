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

test_that("specifying pattern works", {
  imgs <- read_image_data(test_dir_2)
  imgs_less <- read_image_data(test_dir_2, pattern = "29_")
  expect_lt(nrow(imgs_less), nrow(imgs))
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

test_that("bin_snow_depths() works", {
  expect_equal(
    bin_snow_depths(c(0,0.1,4.9,5, 14.99, 15, 29.9, 30, 59.9, 60, 119.999, 120, 130, NA)),
    c(0,1,1,2, 2, 3, 3, 4, 4, 5, 5, 6, 6, NA)
  )
})

