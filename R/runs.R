#' Get runs
#'
#' @param commit_hashes the commit hashes to search for (required)
#'
#' @return a tibble of runs
#' @export
runs <- function(commit_hashes) {
  req <- req_url_path_append(conbench_request(), "runs")
  req <- req_url_query(
    req,
    page_size = 1000,
    commit_hash = paste0(commit_hashes, collapse = ",")
  )
  resp <- conbench_perform(req)
  json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)
  data <- dplyr::as_tibble(json[["data"]])

  while (!is.null(json[["metadata"]][["next_page_cursor"]])) {
    req <- req_url_path_append(conbench_request(), "runs")
    req <- req_url_query(
      req,
      page_size = 1000,
      commit_hash = paste0(commit_hashes, collapse = ","),
      cursor = json[["metadata"]][["next_page_cursor"]]
    )
    resp <- conbench_perform(req)
    json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)
    data <- dplyr::bind_rows(data, dplyr::as_tibble(json[["data"]]))
  }

  data
}
