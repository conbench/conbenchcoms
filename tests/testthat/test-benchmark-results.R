with_mock_dir(test_path("logged-in"), {
  test_that("benchmark_results()", {
    expect_GET(
      benchmark_results(),
      "http://localhost/api/benchmark-results"
    )

    expect_GET(
      benchmark_results(run_id = "C0C0A"),
      "http://localhost/api/benchmark-results?run_id=C0C0A"
    )
  })
})

with_mock_dir(test_path("resp-class"), {
  run_id_1 <- "5a1ad"
  run_id_2 <- "5eaf00d"
  batch_id_1 <- "abba0123"
  batch_id_2 <- "whirlpool"
  test_that("benchmark_results() with run_id returns a data.frame", {
    the_benchmark <- benchmark_results(run_id = run_id_1)
    expect_s3_class(
      the_benchmark,
      "data.frame"
    )
    expect_identical(run_id_1, unique(the_benchmark$run_id))
  })

  test_that("benchmark_results() accepts and returns multiple run_ids", {
    run_ids <- c(run_id_1, run_id_2)
    the_benchmark <- benchmark_results(run_id = run_ids)
    expect_s3_class(
      the_benchmark,
      "data.frame"
    )
    expect_identical(run_ids, unique(the_benchmark$run_id))
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

  test_that("benchmark_results() accepts and returns multiple batch_ids", {
    batch_ids <- c(batch_id_1, batch_id_2)
    batch_id_test2 <- benchmark_results(batch_id = batch_ids)
    expect_s3_class(
      batch_id_test2,
      "data.frame"
    )
    expect_identical(batch_ids, unique(batch_id_test2$batch_id))
  })

  test_that("benchmark_results() with run_reason returns a data.frame", {
    run_reason_test <- benchmark_results(run_reason = "test")
    expect_s3_class(
      run_reason_test,
      "data.frame"
    )
  })
})


test_that("benchmark_results throws an error when trying to use more than 5 run_ids", {
  expect_error(benchmark_results(LETTERS[1:6]))
})