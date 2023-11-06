#' Compare benchmark results
#'
#' @param baseline the ID of the baseline result to compare
#' @param contender the ID of the contender result to compare
#' @param zscore_threshold the zscore threshold to mark regressions and improvements.
#'   Default is defined at the Conbench api level.
#' @param pairwise_percent_threshold the pairwise_percent_threshold to mark regressions and improvements.
#'   Default is defined at the Conbench api level.
#' @inheritDotParams httr2::resp_body_json
#'
#' @return the JSON response
#' @export
compare_results <- function(baseline,
                            contender,
                            zscore_threshold = NULL,
                            pairwise_percent_threshold = NULL,
                            ...) {
  stopifnot("zscore_threshold must be numeric" = is.numeric(zscore_threshold) || is.null(zscore_threshold))
  stopifnot("pairwise_percent_threshold must be numeric" = is.numeric(pairwise_percent_threshold) || is.null(pairwise_percent_threshold))

  req <- req_url_path_append(
    conbench_request(),
    "compare",
    "benchmark-results",
    paste0(baseline, "...", contender)
  )

  if (!is.null(zscore_threshold)) {
    req <- req_url_query(req, threshold_z = zscore_threshold)
  }

  if (!is.null(pairwise_percent_threshold)) {
    req <- req_url_query(req, threshold = pairwise_percent_threshold)
  }

  resp <- conbench_perform(req)

  resp_body_json(resp, ...)
}

#' Compare runs
#'
#' @param baseline the ID of the baseline run to compare
#' @param contender the ID of the contender run to compare
#' @param zscore_threshold the zscore threshold to mark regressions and improvements.
#'   Default is defined at the Conbench api level.
#' @param pairwise_percent_threshold the pairwise_percent_threshold to mark regressions and improvements.
#'   Default is defined at the Conbench api level.
#'
#' @return a tibble of run comparisons
#' @export
compare_runs <- function(baseline,
                         contender,
                         zscore_threshold = NULL,
                         pairwise_percent_threshold = NULL) {
  stopifnot("zscore_threshold must be numeric" = is.numeric(zscore_threshold) || is.null(zscore_threshold))
  stopifnot("pairwise_percent_threshold must be numeric" = is.numeric(pairwise_percent_threshold) || is.null(pairwise_percent_threshold))

  req <- req_url_path_append(
    conbench_request(),
    "compare",
    "runs",
    paste0(baseline, "...", contender)
  )
  req <- req_url_query(req, page_size = 500)
  if (!is.null(zscore_threshold)) {
    req <- req_url_query(req, threshold_z = zscore_threshold)
  }
  if (!is.null(pairwise_percent_threshold)) {
    req <- req_url_query(req, threshold = pairwise_percent_threshold)
  }

  resp <- conbench_perform(req)
  json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)
  data <- dplyr::as_tibble(json[["data"]])

  while (!is.null(json[["metadata"]][["next_page_cursor"]])) {
    req <- req_url_path_append(
      conbench_request(),
      "compare",
      "runs",
      paste0(baseline, "...", contender)
    )
    req <- req_url_query(
      req,
      page_size = 500,
      cursor = json[["metadata"]][["next_page_cursor"]]
    )
    if (!is.null(zscore_threshold)) {
      req <- req_url_query(req, threshold_z = zscore_threshold)
    }
    if (!is.null(pairwise_percent_threshold)) {
      req <- req_url_query(req, threshold = pairwise_percent_threshold)
    }

    resp <- conbench_perform(req)
    json <- resp_body_json(resp, simplifyVector = TRUE, flatten = TRUE)
    data <- dplyr::bind_rows(data, dplyr::as_tibble(json[["data"]]))
  }

  data
}
