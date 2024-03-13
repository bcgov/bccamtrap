test_that("read_sample_station_csv", {
  f <- test_path("sample-station-field-form.csv")

  ret <- read_sample_station_csv(f)
  expect_s3_class(ret, c("sample_station_info", "sf"))

  ret2 <- read_sample_station_csv(f, as_sf = FALSE)
  expect_false("sf" %in% class(ret2))
})

test_that("read_sample_station_csv is like read_sample_station", {
  f <- test_path("sample-station-field-form.csv")

  ret <- read_sample_station_csv(f)
  ssi1 <- read_sample_station_info(test_meta_file1)

  common_names <- intersect(names(ret), names(ssi1))
  expect_snapshot(common_names)

  expect_equal(
    lapply(ret[common_names], class),
    lapply(ssi1[common_names], class)
  )

  expect_snapshot(setdiff(names(ret), names(ssi1)))
  expect_snapshot(setdiff(names(ssi1), names(ret)))
})
