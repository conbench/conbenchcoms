#' A wrapper around `request()` with Conbench URL
#'
#' Takes all the same arguments as `request()`. Should be used at the beginning
#' of an `httr2` pipeline. By default, the conbench URL will be read from the
#' .conbench file in the current working directory.
#'
#' @param base_url the base URL to use
#'
#' @return the request
#' @export
conbench_request <- function(base_url = NULL) {
  if (is.null(base_url)) {
    base_url <- tryCatch(
      get_config()$url,
      error = function(e) "https://conbench.ursa.dev"
    )

    base_url <- paste0(base_url, "/api")
  }

  request(base_url)
}