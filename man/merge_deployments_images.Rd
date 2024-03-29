% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qa-deployment-images.R
\name{merge_deployments_images}
\alias{merge_deployments_images}
\title{Merge image data with deployment data}
\usage{
merge_deployments_images(
  deployments,
  image_data,
  drop_unjoined = FALSE,
  as_sf = TRUE
)
}
\arguments{
\item{deployments}{deployments data, as created by \code{\link[=make_deployments]{make_deployments()}}}

\item{image_data}{data.frame of class \code{image_data}, as read in by \code{\link[=read_image_data]{read_image_data()}}.}

\item{drop_unjoined}{if there are unmatched \code{deployment_labels} between
deployments and image data, should they be dropped from the output
(this is equivalent to a \code{\link[dplyr:mutate-joins]{dplyr::inner_join()}})? Default is \code{FALSE}.}

\item{as_sf}{should the data be returned as an \code{sf} object of the station locations? Default \code{TRUE}}
}
\value{
\code{data.frame} of class \code{image_data}, with \code{deployment} columns attached
}
\description{
Attach deployment metadata with image data.
}
