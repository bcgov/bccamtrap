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
  }
)

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
})
