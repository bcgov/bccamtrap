test_that("write_image_data() works with csv", {
  imgs_1 <- read_image_data(test_dir_1, n_max = 1)
  imgs_2 <- read_image_data(test_dir_2, n_max = 1)

  temp_dir <- withr::local_tempdir()

  out_csv <- file.path(temp_dir, "out1.csv")
  write_image_data(imgs_1, out_csv)
  expect_true(file.exists(out_csv))
  expect_equal(
    names(imgs_1),
    names(readr::read_csv(out_csv, n_max = 1, col_types = readr::cols()))
  )

  out_csv2 <- file.path(temp_dir, "out2.csv")
  write_image_data(imgs_2, out_csv2)
  expect_true(file.exists(out_csv2))
  expect_equal(
    names(imgs_2),
    names(readr::read_csv(out_csv2, n_max = 1, col_types = readr::cols()))
  )
})

test_that("fill_spi_template() works", {
  ss <- read_sample_station_info(test_meta_file1)
  ci <- read_camera_info(test_meta_file1)
  csc <- read_cam_setup_checks(test_meta_file1)
  imgs_1 <- read_image_data(test_dir_1, n_max = 1)
  temp_dir <- withr::local_tempdir()
  out_xls <- file.path(temp_dir, "out1.xlsm")

  fill_spi_template(ss, ci, csc, imgs_1, out_xls)

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information"),
    transform = hide_numbers
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Information"),
    transform = hide_numbers
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks"),
    transform = hide_numbers
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data"),
    transform = hide_numbers
  )
})

test_that("write_to_spi_sheet() works", {
  ss <- read_sample_station_info(test_meta_file2)
  ci <- read_camera_info(test_meta_file2)
  csc <- read_cam_setup_checks(test_meta_file2)
  imgs <- read_image_data(test_dir_2, n_max = 1)
  temp_dir <- withr::local_tempdir()

  out_xls <- file.path(temp_dir, "out2.xlsm")

  write_to_spi_sheet(ss, out_xls, `Number of Cameras` = number_of_cameras)

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information"),
    transform = hide_numbers
  )

  write_to_spi_sheet(ci, out_xls, `Make of Camera Code` = make_of_camera_code)

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Information"),
    transform = hide_numbers
  )

  write_to_spi_sheet(
    csc,
    out_xls,
    `Video Length per Trigger (s)` = video_length_per_trigger_s
  )

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks"),
    transform = hide_numbers
  )

    write_to_spi_sheet(
    imgs,
    out_xls,
    Surveyor = surveyor
  )

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data"),
    transform = hide_numbers
  )
})
