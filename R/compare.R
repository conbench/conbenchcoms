#' Compare runs, benchmarks, batches, or commits
#'
#' @param type the type of comparison to make (one of: runs, benchmarks, batches, commits)
#' @param baseline the baseline sha of the entity to compare
#' @param contender the contender sha of the entity to compare
#' @param zscore_threshold the zscore threshold to mark regressions and improvements. 
#'   Default is defined at the Conbench api level.
#' @param pairwise_percent_threshold the pairwise_percent_threshold to mark regressions and improvements.
#'   Default is defined at the Conbench api level.
#' @inheritDotParams httr2::resp_body_json
#'
#' @return the JSON response
#' @export
compare <- function(type = c("runs", "benchmarks", "batches", "commits"),
                    baseline,
                    contender,
                    zscore_threshold = NULL,
                    pairwise_percent_threshold = NULL,
                    ...) {
  type <- match.arg(type)
  stopifnot("zscore_threshold must be numeric" = is.numeric(zscore_threshold) || is.null(zscore_threshold))
  stopifnot("pairwise_percent_threshold must be numeric" = is.numeric(pairwise_percent_threshold) || is.null(pairwise_percent_threshold))

  req <- req_url_path_append(
    conbench_request(),
    "compare",
    type,
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
