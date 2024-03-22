test_that(
  "sample_rai works",
  {
    imgs1 <- read_image_data(test_dir_1)
    imgs2 <- read_image_data(test_dir_2)

    expect_snapshot(sample_rai(imgs1))
    expect_snapshot(sample_rai(imgs1, deployment_label = "A4_20230517"))
    expect_snapshot(sample_rai(imgs1, species = "Roosevelt Elk"))
    expect_snapshot(sample_rai(imgs1, by_deployment_label = FALSE, by_species = FALSE))
    expect_snapshot(sample_rai(imgs1, by_deployment_label = FALSE))
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
