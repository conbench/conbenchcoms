#' Get history for a benchmark
#'
#' @param benchmark_id the ID of a benchmark result to get the history for
#'
#' @return a tibble of history
#' @export
history <- function(benchmark_id) {
  req <- req_url_path_append(conbench_request(), "history", benchmark_id)
  req <- req_url_query(req, page_size = 1000)
  resp <- conbench_perform(req)
  json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)
  data <- dplyr::as_tibble(json[["data"]])

  while (!is.null(json[["metadata"]][["next_page_cursor"]])) {
    req <- req_url_path_append(conbench_request(), "history", benchmark_id)
    req <- req_url_query(
      req,
      page_size = 1000,
      cursor = json[["metadata"]][["next_page_cursor"]]
    )
    resp <- conbench_perform(req)
    json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)
    data <- dplyr::bind_rows(data, dplyr::as_tibble(json[["data"]]))
  }

  data
}
