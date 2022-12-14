% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runs.R
\name{runs}
\alias{runs}
\title{Get a list of runs}
\usage{
runs(sha = NULL, simplifyVector = TRUE, flatten = TRUE, ...)
}
\arguments{
\item{sha}{the hash of a commit to search for (default: \code{NULL}, list all)}

\item{simplifyVector}{coerce JSON arrays containing only primitives into an atomic vector}

\item{flatten}{automatically \code{\link[jsonlite:flatten]{flatten()}} nested data frames into a single non-nested data frame}

\item{...}{
  Arguments passed on to \code{\link[httr2:resp_body_raw]{httr2::resp_body_json}}
  \describe{
    \item{\code{resp}}{A response object.}
    \item{\code{check_type}}{Check that response has expected content type? Set to
\code{FALSE} to suppress the automated check}
  }}
}
\value{
the response
}
\description{
Get a list of runs
}
