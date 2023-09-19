#' A wrapper around `req_perform()` with Conbench auth
#'
#' Takes all the same arguments as `req_perform()` as well as a `dot_conbench`.
#' It will add the cookie if it exists already, or it will attempt to get a new
#' cookie and run the request. Should be used at the end of an `httr2` pipeline.
#'
#'
#' @param data the request to perform
#' @param ... arguments passed to `req_perform()`
#'
#' @return the response
#' @export
conbench_perform <- function(data, ...) {
  # Make an initial call to see if we need to authenticate
  resp <- data |>
    req_error(is_error = function(resp) FALSE) |>
    req_headers(cookie = .conbench_session$cookie) |>
    req_perform(...)

  # Authenticate if we need to
  if (resp_status(resp) == 401L) auth_conbench()

  # Run the request again with better error handling
  resp <- data |>
    req_error(is_error = function(resp) resp_is_error(resp), body = error_body) |>
    req_headers(cookie = .conbench_session$cookie) |>
    req_perform(...)

  resp
}

auth_conbench <- function() {
  req <- request(get_config()$url) |>
    req_url_path_append("api/") |>
    req_url_path_append("login/") |>
    req_body_json(data = list(
      email = get_config()$email,
      password = get_config()$password
    ))

  resp <- req_perform(req)
  .conbench_session$cookie <- resp_header(resp, "set-cookie")
}

error_body <- function(resp) {
  method <- indent(glue::glue("{resp['method']} {resp['url']}"))
  status_code <- indent(glue::glue("Status code: {resp[['status_code']]}"))
  indented_message <- indent(resp_body_string(resp))
  glue::glue("Request details:\n{method}\n\nResponse details:\n{status_code}\n---\n\n{indented_message}")
}

get_config <- function() {
  path <- Sys.getenv("DOT_CONBENCH", ".conbench")
  creds_list <- list(
    url = Sys.getenv("CONBENCH_URL"),
    email = Sys.getenv("CONBENCH_EMAIL"),
    password = Sys.getenv("CONBENCH_PASSWORD")
  )
  creds_status <- vapply(creds_list, nzchar, logical(1))

  if (all(creds_status)) {
    creds <- creds_list
  } else if (file.exists(path)) {
    creds <- yaml::read_yaml(path)
  } else {
    stop(
      glue::glue_collapse(glue::glue("{names(creds_status[!creds_status])} not set"), sep = ", ", last = " and "),
      call. = FALSE
    )
  }
  creds
}

indent <- function(message) {
  lines <- unlist(strsplit(message, "\n")) # Split the message into lines
  indent <- paste(rep(" ", 2), collapse = "") # Create the indentation string
  indented_lines <- paste(indent, lines, sep = "") # Add indentation
  paste(indented_lines, collapse = "\n") # Combine the lines with newline characters
}

.conbench_session <- new.env(parent = emptyenv())


