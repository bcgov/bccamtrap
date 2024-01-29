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

check_stations_spatial <- function(stations, ...) {
  stations$spatial_outlier <- find_dist_outliers(stations)
  if (any(stations$spatial_outlier)) {
    outlier_station <- stations$sample_station_label[stations$spatial_outlier]
    cli::cli_alert_warning(
      cli::pluralize(
        "Station{?s} {outlier_station} appea{?rs/r} to be very far away from other stations.
        Please check {?its/their} coordinates."
        ),
      wrap = TRUE
    )
  }
  stations
}

map_stations <- function(stations) {
  mapview::mapview(
    stations,
    layer.name = paste0(stations$study_area_name[1], ": Outliers"),
    label = stations$sample_station_label,
    map.types = c("Esri.WorldImagery", setdiff(mapview::mapviewGetOption("basemaps"), "Esri.WorldImagery")),
    zcol = "spatial_outlier")
}

find_dist_outliers <- function(stations, quantthresh = 0.85, dist_thresh = NULL) {
  dist <- unclass(sf::st_distance(stations))

  # Algorithm to find outliers from distance matrix is from clstutils::findOutliers
  dist_thresh <- dist_thresh %||% quantile(dist[lower.tri(dist)], quantthresh, na.rm = TRUE)

  # Id the station which is closest to all the rest
  mid_station <- which.min(apply(dist, 1, median))

  # Is each stations median distance greater than the calculated threshold?
  dist[mid_station, ] > dist_thresh
}
