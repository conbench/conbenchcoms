#' Get hardware
#'
#' @param id the id of one specific hardware to get data for.
#' @inheritParams runs
#'
#' @return the response
#' @export
hardware <- function(id = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "hardware")

  if (!is.null(id)) {
    req <- req_url_path_append(req, id)
  }

  resp <- conbench_perform(req)

  resp_body_json(resp, simplifyVector = simplifyVector, flatten = flatten, ...)
}
