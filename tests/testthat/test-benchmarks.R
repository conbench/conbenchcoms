with_mock_dir(test_path("logged-in"), {
  test_that("benchmarks()", {
    expect_GET(
      benchmarks(),
      "http://localhost/api/benchmarks"
    )

    expect_GET(
      benchmarks(run_id = "C0C0A"),
      "http://localhost/api/benchmarks?run_id=C0C0A"
    )
  })
})

with_mock_dir(test_path("resp-class"), {
  run_id_1 <- "5a1ad"
  run_id_2 <- "5eaf00d"
  batch_id_1 <- "abba0123"
  batch_id_2 <- "whirlpool"
  test_that("benchmarks() with run_id returns a data.frame", {
    the_benchmark <- benchmarks(run_id = run_id_1)
    expect_s3_class(
      the_benchmark,
      "data.frame"
    )
    expect_identical(run_id_1, unique(the_benchmark$run_id))
  })

  test_that("benchmarks() accepts and returns multiple run_ids", {
    run_ids <- c(run_id_1, run_id_2)
    the_benchmark <- benchmarks(run_id = run_ids)
    expect_s3_class(
      the_benchmark,
      "data.frame"
    )
    expect_identical(run_ids, unique(the_benchmark$run_id))
  })

  test_that("benchmarks(...,simplifyVector = FALSE, flatten = FALSE) returns a list", {
    the_list_benchmark <- benchmarks(run_id = run_id_1, simplifyVector = FALSE, flatten = FALSE)
    expect_type(
      the_list_benchmark,
      "list"
    )
    expect_identical(run_id_1, the_list_benchmark[[1]]$run_id)
  })

  test_that("benchmarks() with batch_id returns a data.frame", {
    batch_id_test <- benchmarks(batch_id = batch_id_1)
    expect_s3_class(
      batch_id_test,
      "data.frame"
    )
    expect_identical(batch_id_1, unique(batch_id_test$batch_id))
  })

  test_that("benchmarks() accepts and returns multiple batch_ids", {
    batch_ids <- c(batch_id_1, batch_id_2)
    batch_id_test2 <- benchmarks(batch_id = batch_ids)
    expect_s3_class(
      batch_id_test2,
      "data.frame"
    )
    expect_identical(batch_ids, unique(batch_id_test2$batch_id))
  })
})

