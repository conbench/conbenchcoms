#' Get a list of benchmarks
#'
#' @param run_id the run_id to get benchmarks for (default: `NULL`, list all)
#' @param batch_id the batch_id to get benchmarks for (default: `NULL`, list all)
#' @inheritParams runs
#'
#' @return the response
#' @export
benchmarks <- function(run_id = NULL, batch_id = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "benchmarks")

  if (!is.null(batch_id)) {
    req <- req_url_query(req, batch_id = paste0(batch_id, collapse = ","))
    if (!utils::packageVersion("httr2") > "0.2.1") {
      req$url <- curl::curl_unescape(req$url)
    }
  }

  if (!is.null(run_id)) {
    req <- req_url_query(req, run_id = paste0(run_id, collapse = ","))
    if (!utils::packageVersion("httr2") > "0.2.1") {
      req$url <- curl::curl_unescape(req$url)
    }
  }
  resp <- conbench_perform(req)

  resp_body_json(resp, simplifyVector = simplifyVector, flatten = flatten, ...)
}
