with_mock_dir(test_path("logged-in"), {
  test_that("benchmark_results()", {
    expect_GET(
      benchmark_results(),
      "http://localhost/api/benchmark-results?page_size=1000"
    )

    expect_GET(
      benchmark_results(run_id = "C0C0A"),
      "http://localhost/api/benchmark-results?page_size=1000&run_id=C0C0A"
    )
  })
})

with_mock_dir(test_path("resp"), {
  run_id_1 <- "5a1ad"
  run_id_2 <- "5eaf00d"
  batch_id_1 <- "abba0123"
  test_that("benchmark_results() with run_id returns a tibble", {
    the_benchmark <- benchmark_results(run_id = run_id_1)
    expect_s3_class(
      the_benchmark,
      "tbl_df"
    )
    expect_identical(run_id_1, unique(the_benchmark$run_id))
  })

  test_that("benchmark_results() with pagination returns a tibble", {
    # The mocked responses for this run ID go through 2 API pages.
    # There are different tags in the responses, to test out how bind_rows() works.
    the_benchmark <- benchmark_results(run_id = run_id_2)
    expect_s3_class(
      the_benchmark,
      "tbl_df"
    )
    expect_identical(run_id_2, unique(the_benchmark$run_id))
  })

  test_that("benchmark_results() with run_reason returns a tibble", {
    run_reason_test <- benchmark_results(run_reason = "test")
    expect_s3_class(
      run_reason_test,
      "tbl_df"
    )
  })

})


test_that("benchmark_results throws an error when trying to use more than 1 run_id", {
  expect_error(benchmark_results(LETTERS[1:2]))
})
