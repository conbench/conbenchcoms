#' Clean up an API URL into one that can be linked
#'
#' @param url the API URL (e.g. "http://conbench.dev/api/foo")
#'
#' @return c leaned, clickable URL (e.g. "https://conbench.dev/foo")
#' @export
url_cleaner <- function(url) {
  # Upgrade our connection
  url <- gsub("http://", "https://", url, fixed = TRUE)
  url <- gsub("/api/", "/", url, fixed = TRUE)

  url
}