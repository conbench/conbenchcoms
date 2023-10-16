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

with_mock_dir(test_path("resp-class"), {
  run_id_1 <- "5a1ad"
  run_id_2 <- "5eaf00d"
  batch_id_1 <- "abba0123"
  test_that("benchmark_results() with run_id returns a data.frame", {
    the_benchmark <- benchmark_results(run_id = run_id_1)
    expect_s3_class(
      the_benchmark,
      "data.frame"
    )
    expect_identical(run_id_1, unique(the_benchmark$run_id))
  })

  test_that("benchmark_results() with pagination returns a data.frame", {
    # The mocked responses for this run ID go through 2 API pages.
    # There are different tags in the responses, to test out how bind_rows() works.
    the_benchmark <- benchmark_results(run_id = run_id_2)
    expect_s3_class(
      the_benchmark,
      "data.frame"
    )
    expect_identical(run_id_2, unique(the_benchmark$run_id))
  })

  test_that("benchmark_results(...,simplifyVector = FALSE, flatten = FALSE) returns a list", {
    the_list_benchmark <- benchmark_results(run_id = run_id_1, simplifyVector = FALSE, flatten = FALSE)
    expect_type(
      the_list_benchmark,
      "list"
    )
    expect_identical(run_id_1, the_list_benchmark[[1]]$run_id)
  })

  test_that("benchmark_results() with batch_id returns a data.frame", {
    batch_id_test <- benchmark_results(batch_id = batch_id_1)
    expect_s3_class(
      batch_id_test,
      "data.frame"
    )
    expect_identical(batch_id_1, unique(batch_id_test$batch_id))
  })

  test_that("benchmark_results() with run_reason returns a data.frame", {
    run_reason_test <- benchmark_results(run_reason = "test")
    expect_s3_class(
      run_reason_test,
      "data.frame"
    )
  })

})


test_that("benchmark_results throws an error when trying to use more than 1 run_id", {
  expect_error(benchmark_results(LETTERS[1:2]))
})
