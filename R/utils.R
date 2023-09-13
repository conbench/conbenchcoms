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

## handle integer messages and coercion
integer_messager <- function(x, label = NULL) {
  ## fail if not numeric
  stopifnot("must be numeric" = is.numeric(x))

  if (is.null(label)) {
    label <- ""
  }

  ## coerce to integer
  if (is.double(x)) {
    message(glue::glue("{label} must be an integer, converting to {as.integer(x)}L"))
    x <- as.integer(x)
  }
  x
}