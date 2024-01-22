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

library(fs)
library(readxl)

gd_dir <- "/Users/andy/Library/CloudStorage/GoogleDrive-andy@andyteucher.ca"
proj_dir <- "My Drive/2023/Contracts/BC-WLRS-Camera-Trap/data"

dest_dir <- "~/data/wc-wlrs-cam-data"
proj_file_path <- path(dest_dir, "project-files")
cam_data_path <- path(dest_dir, "camera-data")
dir_create(c(proj_file_path, cam_data_path))

zipfiles <- dir_ls(path(gd_dir, proj_dir), glob = "*.zip")

n_files <- length(zipfiles)

for (i in seq_len(n_files)) {
  f <- zipfiles[i]
  files <- unzip(f, list = TRUE)
  proj_file <- grep("[Dd]atabase.+xls", files$Name, value = TRUE)
  if (length(proj_file) > 1) {
    stop("More than one project file found in ", f)
  }
  unzip(f, files = proj_file, exdir = proj_file_path, junkpaths = TRUE, overwrite = TRUE)

  data_files <- # grep(
    # "merged", # Don't include the merged one, only the originals
    grep("\\.csv$", files$Name, value = TRUE) #,
  #   value = TRUE,
  #   invert = TRUE
  # )
  dirname <- unique(sub("^([a-zA-Z]{1,30})(_.+)", "\\1", data_files))
  data_dir <- dir_create(path(cam_data_path, dirname))
  unzip(f, files = data_files, exdir = data_dir, junkpaths = TRUE, overwrite = TRUE)
}

proj_files <- dir_ls(proj_file_path, recurse = TRUE)

read_excel(proj_files[1])
