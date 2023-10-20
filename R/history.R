#' Get history for a benchmark
#'
#' @param benchmark_id the hash of a benchmark to get the history for
#' @inheritParams jsonlite::fromJSON
#'
#' @return the response
#' @export
history <- function(benchmark_id, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "history", benchmark_id)

  resp <- conbench_perform(req)

  resp_body_json(resp, simplifyVector = simplifyVector, flatten = flatten, ...)
}
