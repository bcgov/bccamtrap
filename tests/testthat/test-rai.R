test_that("sample_rai works", {
  imgs1 <- read_image_data(test_dir_1)
  imgs2 <- read_image_data(test_dir_2)

  expect_snapshot(sample_rai(imgs1))
  expect_snapshot(sample_rai(imgs1, deployment_label = "A4_20230517"))
  expect_snapshot(sample_rai(imgs1, species = "Roosevelt Elk"))
  expect_snapshot(sample_rai(imgs1, by_deployment = FALSE, by_species = FALSE))
  expect_snapshot(sample_rai(imgs1, by_deployment = FALSE))
  expect_snapshot(sample_rai(imgs1, by_species = FALSE))
  expect_snapshot(sample_rai(
    imgs1,
    sample_start_date = "2022-12-16",
    sample_end_date = "2023-02-05"
  ))
  expect_snapshot(sample_rai(
    imgs2,
    deployment_label = "19_1_20230605",
    species = "Roosevelt Elk",
    sample_start_date = "2022-12-16",
    sample_end_date = "2023-02-05"
  ))

  out1 <- sample_rai(imgs1) %>%
    dplyr::filter(species != "Unknown")
  expect_true(all(out1$n_detections <= out1$total_count))

  out2 <- sample_rai(imgs2) %>%
    dplyr::filter(species != "Unknown")
  expect_true(all(out2$n_detections <= out2$total_count))
})

test_that("rai_by_time works", {
  imgs1 <- read_image_data(test_dir_1)
  imgs2 <- read_image_data(test_dir_2)
  imgs_bd <- read_image_data(test_bd_img_csv)

  expect_snapshot(rm_id_cols(rai_by_time(imgs1)))
  expect_snapshot(rm_id_cols(rai_by_time(imgs2)))
  expect_snapshot(rm_id_cols(rai_by_time(imgs_bd)))

  expect_snapshot(rm_id_cols(rai_by_time(
    imgs1,
    sample_start_date = "2022-12-16",
    sample_end_date = "2023-02-05"
  )))
  expect_snapshot(rm_id_cols(rai_by_time(
    imgs2,
    deployment_label = "19_1_20230605",
    species = "Roosevelt Elk",
    sample_start_date = "2022-12-16",
    sample_end_date = "2023-02-05"
  )))
  expect_snapshot(rm_id_cols(rai_by_time(
    imgs1,
    by_species = FALSE
  )))
  expect_snapshot(rm_id_cols(rai_by_time(
    imgs_bd,
    by_deployment = TRUE,
    sample_start_date = "2021-12-16",
    sample_end_date = "2022-05-05"
  )))
  expect_snapshot(rm_id_cols(rai_by_time(
    imgs2,
    "week",
    species = "Roosevelt Elk",
    by_deployment = FALSE,
    roll = TRUE
  )))
  expect_snapshot(rm_id_cols(rai_by_time(
    imgs_bd,
    "year",
    by_species = TRUE,
    by_deployment = TRUE,
    roll = TRUE
  )))
  expect_snapshot(dplyr::select(
    rai_by_time(
      imgs_bd,
      "month",
      by_species = TRUE,
      by_deployment = TRUE,
      roll = TRUE
    ),
    dplyr::contains("roll")
  ))
})

test_that("rai_by_time with different agg functions", {
  imgs2 <- read_image_data(test_dir_2)

  rai_rolltest1 <- rai_by_time(
    imgs2,
    by = "date",
    species = "Roosevelt Elk",
    by_deployment = FALSE,
    roll = TRUE
  )

  expect_equal(
    round(mean(rai_rolltest1$roll_rai, na.rm = TRUE), 3),
    0.067
  )

  rai_rolltest2 <- rai_by_time(
    imgs2,
    by = "date",
    species = "Roosevelt Elk",
    by_deployment = FALSE,
    roll = TRUE
  )

  expect_equal(
    round(mean(rai_rolltest2$roll_mean_max_snow, na.rm = TRUE), 3),
    4.485
  )

  rai_rolltest3 <- rai_by_time(
    imgs2,
    by = "date",
    species = "Roosevelt Elk",
    by_deployment = FALSE,
    roll = TRUE,
    snow_agg = mean
  )

  expect_equal(
    round(mean(rai_rolltest3$roll_mean_mean_snow, na.rm = TRUE), 3),
    1.697
  )
})

test_that("n_detections is less or equal to total_count", {
  imgs1 <- read_image_data(test_dir_1)
  imgs2 <- read_image_data(test_dir_2)
  imgs_bd <- read_image_data(test_bd_img_csv)

  out1 <- rai_by_time(imgs1, by_species = TRUE) %>%
    dplyr::filter(!is.na(species), species != "Unknown")

  expect_true(all(out1$n_detections <= out1$total_count))

  out2 <- rai_by_time(imgs2, by_species = FALSE, by_deployment = TRUE) %>%
    dplyr::filter(total_count != 0) # #19 - should not need if filter to only species not NA

  expect_true(all(out2$n_detections <= out2$total_count))

  out3 <- rai_by_time(imgs_bd, by = "month") %>%
    dplyr::filter(!is.na(species), species != "Unknown")

  expect_true(all(out3$n_detections <= out3$total_count))
})
