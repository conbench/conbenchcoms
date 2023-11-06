with_mock_dir(test_path("logged-in"), {
  test_that("runs()", {
    expect_GET(
      runs(commit_hashes = c("C0C0A", "BEEF")),
      "http://localhost/api/runs?page_size=1000&commit_hash=C0C0A%2CBEEF"
    )
  })
})

with_mock_dir(test_path("resp"), {
  sha_1 <- "babb1ed"
  sha_2 <- "5eaf00d"
  test_that("runs() returns a tibble", {
    the_run <- runs(commit_hashes = sha_1)
    expect_s3_class(
      the_run,
      "tbl_df"
    )
    expect_identical(sha_1, the_run$commit.sha)
  })

  test_that("runs() accepts and returns multiple values", {
    shas <- c(sha_1, sha_2)
    runs <- runs(commit_hashes = shas)
    expect_s3_class(
      runs,
      "tbl_df"
    )
    expect_identical(shas, unique(runs$commit.sha))
  })

})
