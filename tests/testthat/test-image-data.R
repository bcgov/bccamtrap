test_that("read_image_data() works", {
  imgs_1 <- read_image_data(test_dir_1)
  imgs_2 <- read_image_data(test_dir_2)

  expect_s3_class(imgs_1, c("image_data", "tbl"))
  expect_s3_class(imgs_2, c("image_data", "tbl"))
  expect_equal(ncol(imgs_1), 43)
  expect_equal(ncol(imgs_2), 43)
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

test_that("read_one_image_csv() warns when file has extra named columns", {
  f <- withr::local_tempfile(fileext = ".csv")
  writeLines(
    c(
      "RootFolder,DateTime,Extra_Col",
      "/root,2023-01-01 12:00:00,foo"
    ),
    f
  )
  expect_snapshot(
    read_one_image_csv(f, master_template_path()),
    transform = \(x) gsub(f, "<tempfile>", x, fixed = TRUE)
  )
})

test_that("read_one_image_csv() retains extra named columns in output", {
  f <- withr::local_tempfile(fileext = ".csv")
  writeLines(
    c(
      "RootFolder,DateTime,Extra_Col",
      "/root,2023-01-01 12:00:00,foo"
    ),
    f
  )
  result <- suppressWarnings(read_one_image_csv(f, master_template_path()))
  expect_contains(names(result), "Extra_Col")
})

test_that("read_one_image_csv() silently drops empty unnamed columns (trailing commas)", {
  f <- withr::local_tempfile(fileext = ".csv")
  writeLines(
    c(
      "RootFolder,DateTime,",
      "/root,2023-01-01 12:00:00,"
    ),
    f
  )
  result <- read_one_image_csv(f, master_template_path())
  expect_equal(names(result), c("RootFolder", "DateTime"))
})

test_that("manually supplied template works", {
  f <- withr::local_tempfile(fileext = ".csv")
  writeLines(
    c(
      "Study_Area_Name,Deployment_Label,DateTime,Temperature,Adult_Female",
      "A,Dep123,2023-01-01 12:00:00,16,5"
    ),
    f
  )
  template_path <- system.file(
    "extdata",
    "timelapse-templates",
    "TimelapseTemplate_Elk_Wallows_v1.tdb",
    package = "bccamtrap"
  )
  result <- read_image_data(f, template = template_path)
})

test_that("bin_snow_depths() works", {
  expect_equal(
    bin_snow_depths(c(
      0,
      0.1,
      4.9,
      5,
      14.99,
      15,
      29.9,
      30,
      59.9,
      60,
      119.999,
      120,
      130,
      NA
    )),
    c(0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, NA)
  )
})
