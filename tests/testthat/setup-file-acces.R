# Copyright 2024 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

# This downloads and stores as temporary files the metadata and image data from
# two sites, for testing. They are stored in a private google drive requiring
# authentication to download.

googledrive::drive_auth(path = Sys.getenv("GDRIVE_AUTH_TOKEN"))

drv1 <- googledrive::drive_get(id = "1JC_zaIuazGThq7fxnCPZ0wVhv7tIytFs") # MC
drv2 <- googledrive::drive_get(id = "1EY559-jrhrkazFsJ8AoKH0OBewRfdsPq") # TA

test_dir <- withr::local_tempdir(
  pattern = "bccamtrap_test",
  .local_envir = if (is_testing()) teardown_env() else parent.frame()
)

test_zip_1 <- googledrive::drive_download(
  drv1,
  file.path(test_dir, drv1$name),
  overwrite = TRUE
)

test_zip_2 <- googledrive::drive_download(
  drv2,
  file.path(test_dir, drv2$name),
  overwrite = TRUE
)

test_dir_1 <- tools::file_path_sans_ext(test_zip_1$local_path)
unzip(test_zip_1$local_path, exdir = dirname(test_dir_1))

test_dir_2 <- tools::file_path_sans_ext(test_zip_2$local_path)
unzip(test_zip_2$local_path, exdir = dirname(test_dir_2))

test_files_1 <- list.files(test_dir_1, full.names = TRUE)
merged_1 <- grep("merged", test_files_1, value = TRUE)
file.remove(merged_1)
test_files_1 <- setdiff(test_files_1, merged_1)
test_meta_file1 <- grep(".xls[xm]?$", test_files_1, value = TRUE)

test_files_2 <- list.files(test_dir_2, full.names = TRUE)
merged_2 <- grep("merged", test_files_2, value = TRUE)
file.remove(merged_2)
test_files_2 <- setdiff(test_files_2, merged_2)
test_meta_file2 <- grep(".xls[xm]?$", test_files_2, value = TRUE)


drv3 <- googledrive::drive_get(id = "1XArm3JspluuIRn48tgjWH56lUWQX8Mju") # BD image data
test_bd_img_csv_gd <- googledrive::drive_download(
  drv3,
  path = file.path(test_dir, drv3$name),
  overwrite = TRUE
)
test_bd_img_csv <- test_bd_img_csv_gd$local_path
