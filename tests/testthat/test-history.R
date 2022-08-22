with_mock_dir(test_path("logged-in"), {
  test_that("history()", {
    expect_GET(
      history("C0C0A"),
      "http://localhost/api/history/C0C0A"
    )
  })
})


with_mock_dir(test_path("resp-class"), {
  the_id <- "hist-id"
  test_that("history() returns a data.frame", {
    the_history <- history(benchmark_id = the_id)
    expect_s3_class(
      the_history,
      "data.frame"
    )
    expect_identical(the_id, the_history$benchmark_id)
  })
  test_that("history(...,simplifyVector = FALSE, flatten = FALSE) returns a list", {
    the_list_history <- history(benchmark_id = the_id, simplifyVector = FALSE, flatten = FALSE)
    expect_type(
      the_list_history,
      "list"
    )
    expect_identical(the_id, the_list_history[[1]]$benchmark_id)
  })
})