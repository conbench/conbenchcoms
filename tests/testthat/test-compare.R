with_mock_dir(test_path("logged-in"), {
  test_that("compare()", {
    expect_GET(
      compare("runs", "C0C0A", "BA11E7"),
      "http://localhost/api/compare/runs/C0C0A...BA11E7"
    )

    expect_GET(
      compare("benchmarks", "C0C0A", "BA11E7"),
      "http://localhost/api/compare/benchmarks/C0C0A...BA11E7"
    )
  })
})


with_mock_dir(test_path("resp-class"), {
  test_that("zscore and pairwise thresholds return correct values", {
    z_thres <- 10
    percent_threshold <- 20

    resp <- compare(
      type = "runs",
      "ee1",
      "f00d",
      zscore_threshold = z_thres,
      pairwise_percent_threshold = z_thres,
      simplifyVector = TRUE
    )
    returned_z_thres <- unique(resp[["analysis"]][["lookback_z_score"]][["z_threshold"]])
    expect_equal(returned_z_thres[!is.na(returned_z_thres)], z_thres)
    returned_percent_thres <- unique(resp[["analysis"]][["pairwise"]][["percent_threshold"]])
    expect_equal(returned_percent_thres[!is.na(returned_percent_thres)], percent_threshold)
  })

  test_that("zscore and pairwise thresholds can accept decimals", {
    z_thres <- 11.1
    percent_threshold <- 20.2

    resp <- compare(
      type = "runs",
      "10aded",
      "0af",
      zscore_threshold = z_thres,
      pairwise_percent_threshold = z_thres,
      simplifyVector = TRUE
    )
    returned_z_thres <- unique(resp[["analysis"]][["lookback_z_score"]][["z_threshold"]])
    expect_equal(returned_z_thres[!is.na(returned_z_thres)], z_thres)
    returned_percent_thres <- unique(resp[["analysis"]][["pairwise"]][["percent_threshold"]])
    expect_equal(returned_percent_thres[!is.na(returned_percent_thres)], percent_threshold)
  })

  test_that("zscore and pairwise thresholds fail with non-numeric values", {
    expect_error(compare(
      type = "runs",
      "10aded",
      "0af",
      zscore_threshold = "foo",
      simplifyVector = TRUE
    ), "zscore_threshold must be numeric")

    expect_error(compare(
      type = "runs",
      "10aded",
      "0af",
      pairwise_percent_threshold = "bar",
      simplifyVector = TRUE
    ), "pairwise_percent_threshold must be numeric")
  })
})
