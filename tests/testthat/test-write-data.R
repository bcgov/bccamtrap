test_that("write_image_data() works with csv", {
  imgs_1 <- read_image_data(test_dir_1)

  temp_dir <- withr::local_tempdir()
  out_csv <- file.path(temp_dir, "foo.csv")

  write_image_data(imgs_1, out_csv)
  expect_true(file.exists(out_csv))
  expect_equal(
    names(imgs_1),
    names(readr::read_csv(out_csv, n_max = 1, col_types = readr::cols()))
  )
})

test_that("write_image_data() works with excel template", {
  imgs_1 <- read_image_data(test_dir_1, n_max = 2)

  temp_dir <- withr::local_tempdir()
  out_xls <- file.path(temp_dir, "foo.xlsm")

  write_image_data(imgs_1, out_xls)
  expect_true(file.exists(out_xls))
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
  )
})
