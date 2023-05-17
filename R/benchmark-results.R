#' Get a list of benchmark results
#'
#' @param run_id the run_id to get benchmarks for (default: `NULL`, list all)
#' @param batch_id the batch_id to get benchmarks for (default: `NULL`, list all)
#' @param run_reason a string to specify the run reason (default: `NULL`, list all)
#' @inheritParams runs
#'
#' @return a data.frame of benchmark results
#' @export
benchmark_results <- function(run_id = NULL, batch_id = NULL, run_reason = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "benchmark-results")

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

#' `benchmarks` is deprecated method of getting benchmark results and will be 
#' retired in a future release. Please use `benchmark_results` instead.
#' @rdname benchmark_results
#' @export 
benchmarks <- function(...) {
  .Deprecated("benchmark_results")
  benchmark_results(...)
}