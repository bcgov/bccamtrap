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

#' Check spatial attributes of Sample Station information
#'
#' This checks for inconsistent placement of stations to flag potentially
#' incorrect location information
#'
#' @param stations an `sf` data.frame as read in by [read_sample_station_info()]
#' @param quant_thresh The quantile above which the distance of a station from
#'   the other stations (compared to the average distance between stations)
#'   will be flagged as an outlier. Default `0.85`.
#' @param dist_thresh The distance (in m) above which the distance of a station
#'   from the other stations will be flagged as an outlier. By default the
#'   quantile is used, but can be overriden by setting this to a numeric value
#'   in metres.
#'
#' @return the input data.frame, with a new `logical` column `spatial_outlier` appended.
#' @seealso [map_stations()]
#' @export
check_stations_spatial <- function(stations, quant_thresh = 0.9, dist_thresh = NULL) {

  check_sample_station_info(stations)
  check_is_sf(stations)

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

#' Visualize stations on an interactive map
#'
#' If the input data.frame has been run through [check_stations_spatial()],
#' potential spatial outliers will be visually flagged.
#'
#' @inheritParams check_stations_spatial
#'
#' @return a mapview object
#' @seealso [check_stations_spatial()]
#' @export
map_stations <- function(stations) {

  check_sample_station_info(stations)
  check_is_sf(stations)

  has_outlier_col <- "spatial_outlier" %in% names(stations)

  mapview::mapview(
    stations,
    zcol = if (has_outlier_col) "spatial_outlier",
    col.regions = c("#bc5090", "#ffa600"),
    alpha.regions = 0.9,
    map.types = c(
      "Esri.WorldImagery",
      setdiff(mapview::mapviewGetOption("basemaps"), "Esri.WorldImagery")
    ),
    layer.name = paste0(stations$study_area_name[1], if (has_outlier_col) ": Outliers"),
    label = stations$sample_station_label
  )
}

find_dist_outliers <- function(stations, quant_thresh = 0.9, dist_thresh = NULL) {
  dist <- unclass(sf::st_distance(stations))
  # TODO: This may be better if look at distances between one station and the
  # next (i.e., minimum distance) rather than distances of all stations to
  # midpoint - that could be sensitive if they are spread out in a line, like
  # along a river bed. Though that wouldn't work if two stations were outliers
  # together... Keep as-is for now.

  # Algorithm to find outliers from distance matrix is from clstutils::findOutliers
  dist_thresh <- dist_thresh %||%
    stats::quantile(dist[lower.tri(dist)], quant_thresh, na.rm = TRUE)

  # Id the station which is closest to all the rest
  mid_station <- which.min(apply(dist, 1, stats::median))

  # Is each stations median distance greater than the calculated threshold?
  dist[mid_station, ] > dist_thresh
}
