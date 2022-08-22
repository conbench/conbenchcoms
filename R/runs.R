#' Get a list of runs
#'
#' @param sha the hash of a commit to search for (default: `NULL`, list all)
#' @inheritParams jsonlite::fromJSON
#' @inheritDotParams httr2::resp_body_json
#'
#' @return the response
#' @export
runs <- function(sha = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "runs")

  if (!is.null(sha)) {
    req <- req_url_query(req, sha = paste0(sha, collapse = ","))
    ## TODO: remove when https://github.com/r-lib/httr2/pull/153 is merged
    if (!utils::packageVersion("httr2") > "0.2.1") {
      req$url <- curl::curl_unescape(req$url)
    }
  }
  resp <- conbench_perform(req)

  resp_body_json(resp, simplifyVector = simplifyVector, flatten = flatten, ...)
}