#' Get a list of conbench info
#'
#' @return the response
#' @export

conbench_info <- function() {
  req <- req_url_path_append(conbench_request(), "ping")

  resp <- conbench_perform(req)

  dat <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)

  dat[["date"]]  <- NULL

  dat
}
