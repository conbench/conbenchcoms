with_mock_dir(test_path("logged-in"), {
  test_that("compare()", {
    expect_GET(
      compare_results("C0C0A", "BA11E7"),
      "http://localhost/api/compare/benchmark-results/C0C0A...BA11E7"
    )

    expect_GET(
      compare_runs("C0C0A", "BA11E7"),
      "http://localhost/api/compare/runs/C0C0A...BA11E7?page_size=500"
    )
  })
})


with_mock_dir(test_path("resp-class"), {
  test_that("compare_results returns the correct json", {
    z_thres <- 11.1
    percent_threshold <- 20.2

    resp <- compare_results(
      "10aded",
      "0af",
      zscore_threshold = z_thres,
      pairwise_percent_threshold = z_thres
    )
    expect_type(resp, "list")

    returned_z_thres <- resp[["analysis"]][["lookback_z_score"]][["z_threshold"]]
    expect_equal(returned_z_thres, z_thres)
    returned_percent_thres <- resp[["analysis"]][["pairwise"]][["percent_threshold"]]
    expect_equal(returned_percent_thres, percent_threshold)
  })

  test_that("compare_runs returns the correct tibble", {
    z_thres <- 11.1
    percent_threshold <- 20.2

    resp <- compare_runs(
      "10aded",
      "0af",
      zscore_threshold = z_thres,
      pairwise_percent_threshold = z_thres
    )
    expect_s3_class(resp, "tbl_df")

    returned_z_thres <- unique(resp[["analysis.lookback_z_score.z_threshold"]])
    expect_equal(returned_z_thres, z_thres)
    returned_percent_thres <- unique(resp[["analysis.pairwise.percent_threshold"]])
    expect_equal(returned_percent_thres, percent_threshold)
  })

  test_that("zscore and pairwise thresholds fail with non-numeric values", {
    expect_error(compare_results(
      "10aded",
      "0af",
      zscore_threshold = "foo"
    ), "zscore_threshold must be numeric")

    expect_error(compare_results(
      "10aded",
      "0af",
      pairwise_percent_threshold = "bar"
    ), "pairwise_percent_threshold must be numeric")

    expect_error(compare_runs(
      "10aded",
      "0af",
      zscore_threshold = "foo"
    ), "zscore_threshold must be numeric")

    expect_error(compare_runs(
      "10aded",
      "0af",
      pairwise_percent_threshold = "bar"
    ), "pairwise_percent_threshold must be numeric")
  })
})
