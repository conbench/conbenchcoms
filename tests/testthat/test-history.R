with_mock_dir(test_path("logged-in"), {
  test_that("history()", {
    expect_GET(
      history("C0C0A"),
      "http://localhost/api/history/C0C0A?page_size=1000"
    )
  })
})


with_mock_dir(test_path("resp"), {
  the_id <- "hist-id"
  test_that("history() returns a tibble", {
    the_history <- history(benchmark_id = the_id)
    expect_s3_class(
      the_history,
      "tbl_df"
    )
    expect_identical(the_id, the_history$benchmark_id)
  })
})
