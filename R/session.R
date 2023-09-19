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
  # if session is already here, then we can use that
  resp <- data |>
    req_error(is_error = function(resp) FALSE) |>
    req_headers(cookie = .conbench_session$cookie) |>
    req_perform(...)

  # TODO: is this status too narrow?
  if (resp_status(resp) == 401L) {
    auth_conbench()

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

.conbench_session <- new.env(parent = emptyenv())


