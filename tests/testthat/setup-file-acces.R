googledrive::drive_auth(path = Sys.getenv("GDRIVE_AUTH_TOKEN"))

drv1 <- googledrive::drive_get(id = "1BW9nxymrLKaZYsa2nWfbm3UxYj9aBJGi")
drv2 <- googledrive::drive_get(id = "19LnLUjLsCH9xtc5Z-H9OlGCzesG8rKe4")

test_meta_file1 <- withr::local_tempfile(
  fileext = tools::file_ext(drv1$name),
  .local_envir = if (is_testing()) teardown_env() else parent.frame()
)
test_meta_file2 <- withr::local_tempfile(
  fileext = tools::file_ext(drv2$name),
  .local_envir = if (is_testing()) teardown_env() else parent.frame()
)

googledrive::drive_download(drv1, test_meta_file1, overwrite = TRUE)
googledrive::drive_download(drv2, test_meta_file2, overwrite = TRUE)
