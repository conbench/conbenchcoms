#' Get a list of benchmark info
#'
#' @param id the info id for benchmark info
#' @inheritParams jsonlite::fromJSON
#'
#' @return the response
#' @export

info <- function(id = NULL, simplifyVector = TRUE, flatten = TRUE, ...) {
  req <- req_url_path_append(conbench_request(), "info")

  if (!is.null(id)) {
    req <- req_url_path_append(req, id)
  }

  resp <- conbench_perform(req)

  resp_body_json(resp, simplifyVector = simplifyVector, flatten = flatten, ...)
}
