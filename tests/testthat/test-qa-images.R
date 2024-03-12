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

test_that("find_blanks", {
  d <- data.frame(
    "study_area_name" = c("a", "b", " ", "", NA_character_),
    "sample_station_label" = c("a", "b", " ", "", NA_character_),
    "deployment_label" = c("a", "b", " ", "", NA_character_),
    "date_time" = as.POSIXct(c(NA, rep("2024-03-11 05:16:42", 4))),
    "surveyor" = c("", NA_character_, "a", "b", " "),
    "trigger_mode" = LETTERS[1:5],
    "temperature" = c(NaN, NA_real_, 1:3),
    "episode" = letters[1:5]
  )
  expect_snapshot(find_blanks(d))
})

test_that("find_unmatched", {
  d <- data.frame(
    a = c(1, NA, 2),
    b = c(NA, 3, 4),
    human_use_type = c("a", "b", NA)
  )

  expect_snapshot(find_unmatched(d, "a", "b", exclude_human_use = FALSE))
  expect_snapshot(find_unmatched(d, "b", "a", exclude_human_use = FALSE))
  expect_snapshot(find_unmatched(d, "a", "b", exclude_human_use = TRUE))
  expect_snapshot(find_unmatched(d, "b", "a", exclude_human_use = TRUE))
})

test_that("validate_counts", {
  d <- data.frame(
    "total_count_episode" = c(5, 3, NA, 0, 1),
    "adult_male" = c(2, NA, 0, 1, NA),
    "adult_female" = c(3, 3, 1, 0, NA),
    "human_use_type" = c(NA, NA, "a", "b", "c")
  )

  expect_snapshot(
    validate_counts(d, cols = c("adult_male", "adult_female"),
                    exclude_human_use = FALSE)
  )
  expect_snapshot(
    validate_counts(d, cols = c("adult_male", "adult_female"),
                    exclude_human_use = TRUE)
  )
})

test_that("find_dup_episodes", {
  d <- data.frame(
    episode = c("3:1|17", "4:1|17", "3:2|17", "4:1|17"),
    "deployment_label" = c("a", "b", "a", "c"),
    "date_time" = as.Date(c("2024-03-09", "2024-03-10", "2024-03-11", "2024-03-12")),
    "file" = c("x", 'y', "z", "zz"),
    "species" = c("p", "q", "p", "s")
  )
  expect_snapshot(find_dup_episodes(d))
})

test_that("validate_timestamp_order", {
 # TODO
})

test_that("validate_snow_data", {
 # TODO
})

