#' Get a list of benchmarks
#'
#' @param run_id the run_id to get benchmarks for (default: `NULL`, list all)
#' @param batch_id the batch_id to get benchmarks for (default: `NULL`, list all)
#' @param run_reason a string to specify the run reason (default: `NULL`, list all)
#' @inheritParams runs
#'
#' @return the response
#' @export
benchmarks <- function(run_id = NULL, batch_id = NULL, run_reason = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "benchmarks")

  if (!is.null(run_reason)) {
    req <- req_url_query(req, run_reason = run_reason)
  }

  if (!is.null(batch_id)) {
    req <- req_url_query(req, batch_id = paste0(batch_id, collapse = ","))
  }

  if (!is.null(run_id)) {
    req <- req_url_query(req, run_id = paste0(run_id, collapse = ","))
  }
  resp <- conbench_perform(req)

  resp_body_json(resp, simplifyVector = simplifyVector, flatten = flatten, ...)
}
