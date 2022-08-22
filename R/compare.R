#' Compare runs, benchmarks, batches, or commits
#'
#' @param type the type of comparison to make (one of: runs, benchmarks, batches, commits)
#' @param baseline the baseline sha of the entity to compare
#' @param contender the contender sha of the entity to compare
#' @inheritDotParams httr2::resp_body_json
#'
#' @return the JSON response
#' @export
compare <- function(type = c("runs", "benchmarks", "batches", "commits"),
                    baseline,
                    contender,
                    ...) {
  type <- match.arg(type)

  req <- req_url_path_append(
    conbench_request(),
    "compare",
    type,
    paste0(baseline, "...", contender))

  resp <- conbench_perform(req)

  resp_body_json(resp, ...)
}
