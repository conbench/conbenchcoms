.construct_request <- function(
  run_id, run_reason, earliest_timestamp, latest_timestamp, cursor
) {
  req <- req_url_path_append(conbench_request(), "benchmark-results")
  req <- req_url_query(req, page_size = 1000)

  if (!is.null(run_id)) {
    req <- req_url_query(req, run_id = run_id)
  }

  if (!is.null(run_reason)) {
    req <- req_url_query(req, run_reason = run_reason)
  }

  if (!is.null(earliest_timestamp)) {
    req <- req_url_query(req, earliest_timestamp = earliest_timestamp)
  }

  if (!is.null(latest_timestamp)) {
    req <- req_url_query(req, latest_timestamp = latest_timestamp)
  }

  if (!is.null(cursor)) {
    req <- req_url_query(req, cursor = cursor)
  }

  req
}

#' Get a list of benchmark results
#'
#' @param run_id the run_id to get benchmarks for (default: `NULL`, list all)
#' @param run_reason a string to specify the run reason (default: `NULL`, list all)
#' @param earliest_timestamp the earliest benchmark result timestamp (default: `NULL`, go back as far as possible)
#' @param latest_timestamp the latest benchmark result timestamp (default: `NULL`, go up to the current time)
#'
#' @return a tibble of benchmark results
#' @export
benchmark_results <- function(
    run_id = NULL,
    run_reason = NULL,
    earliest_timestamp = NULL,
    latest_timestamp = NULL,
    ...) {
  ## Assert that run_id is a string
  if (length(run_id) > 1) {
    stop("Too many run_ids, please limit to 1.", call. = FALSE)
  }

  req <- .construct_request(
    run_id = run_id,
    run_reason = run_reason,
    earliest_timestamp = earliest_timestamp,
    latest_timestamp = latest_timestamp,
    cursor = NULL
  )
  resp <- conbench_perform(req)
  json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE, ...)
  data <- dplyr::as_tibble(json[["data"]])

  while (!is.null(json[["metadata"]][["next_page_cursor"]])) {
    req <- .construct_request(
      run_id = run_id,
      run_reason = run_reason,
      earliest_timestamp = earliest_timestamp,
      latest_timestamp = latest_timestamp,
      cursor = json[["metadata"]][["next_page_cursor"]]
    )
    resp <- conbench_perform(req)
    json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE, ...)
    data <- dplyr::bind_rows(data, dplyr::as_tibble(json[["data"]]))
  }

  data
}

#' `benchmarks` is deprecated method of getting benchmark results and will be
#' retired in a future release. Please use `benchmark_results` instead.
#' @rdname benchmark_results
#' @param batch_id deprecated
#' @inheritParams jsonlite::fromJSON
#' @export
benchmarks <- function(run_id = NULL, batch_id = NULL, run_reason = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  .Deprecated("benchmark_results")

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
