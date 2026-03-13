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
  ss <- hide_names(read_sample_station_info(test_meta_file1))
  ci <- hide_names(read_camera_info(test_meta_file1))
  csc <- hide_names(read_cam_setup_checks(test_meta_file1))
  imgs_1 <- hide_names(read_image_data(test_dir_1, n_max = 2))
  imgs_1$species[1:18] <- c(
    "Roosevelt Elk",
    "Mule Deer",
    "Black Bear",
    "American Black Bear",
    "Racoon",
    "Cougar",
    "grey wolf",
    "Ermine anguinae",
    "Pacific Marten",
    "Red Squirrel",
    "Mink",
    "Beaver",
    "RIVER OTTER",
    "Muskrat",
    "Vancouver Island Marmot",
    "Jaberwocky",
    "Avian (Comments)",
    "Unknown"
  )
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
  ss <- hide_names(read_sample_station_info(test_meta_file2))
  ci <- hide_names(read_camera_info(test_meta_file2))
  csc <- hide_names(read_cam_setup_checks(test_meta_file2))
  imgs <- hide_names(read_image_data(test_dir_2, n_max = 1))
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

  expect_snapshot(
    write_to_spi_sheet(
      imgs,
      out_xls,
      Surveyor = surveyor
    ),
    error = TRUE
  )

  deployments <- hide_names(make_deployments(test_meta_file2))
  imgs <- merge_deployments_images(deployments, imgs)

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

test_that("fill_spi_template_ff() works", {
  ss <- read_sample_station_csv(test_path("sample-station-field-form.csv"))
  dep <- read_deployments_csv(test_path("deployments-field-form.csv"))

  imgs_1 <- read_image_data(test_dir_1, n_max = 5)
  temp_dir <- withr::local_tempdir()
  out_xls <- file.path(temp_dir, "out1.xlsm")

  fill_spi_template_ff(ss, dep, imgs_1, file = out_xls)

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Information")
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks")
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
  )
})

test_that("fill_spi_template_ff() works with project subsetting and no image data", {
  ss <- read_sample_station_csv(test_path("sample-station-field-form.csv"))
  dep <- read_deployments_csv(test_path("deployments-field-form.csv"))

  temp_dir <- withr::local_tempdir()
  out_xls <- file.path(temp_dir, "out1.xlsm")

  fill_spi_template_ff(ss, dep, wlrs_project_name = "Test1", file = out_xls)

  expect_true(file.exists(out_xls))

  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Information")
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks")
  )
  expect_snapshot(
    openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
  )
})

test_that("spp_lookup() works", {
  species <- c("Black Bear", "aMeriCan Black beaR", "Jaberwocky", "Roosevelt Elk")
  codes <- spp_lookup(species)
  expect_equal(codes, c("M-URAM", "M-URAM", "Jaberwocky", "M-CEEL"))
})
