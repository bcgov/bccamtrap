% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/project-metadata.R
\name{read_sample_station_info}
\alias{read_sample_station_info}
\title{Read the "Sample Station Information" tab from the RISC worksheet.}
\usage{
read_sample_station_info(path, as_sf = TRUE, ...)
}
\arguments{
\item{path}{path to the RISC workbook}

\item{as_sf}{should the data be returned as an \code{sf} object of the station locations? Default \code{TRUE}}

\item{...}{arguments passed on to \code{\link[readxl:read_excel]{readxl::read_excel()}}}
}
\value{
a \code{data.frame} of station information, as an \code{sf} object if specified.
}
\description{
This will read in the sample station information from a RISC worksheet following the
'v20230518' template
}
