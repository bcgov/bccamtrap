test_that("qa_image_data works", {
  imgs_1 <- read_image_data(test_dir_1)
  imgs_2 <- read_image_data(test_dir_2)

  expect_snapshot(
    head(dplyr::select(
      as.data.frame(qa_image_data(imgs_1)),
      starts_with("QA")
    ))
  )
  expect_snapshot(
    head(dplyr::select(
      as.data.frame(qa_image_data(imgs_2)),
      starts_with("QA")
    ))
  )
})
