with_mock_dir(test_path("logged-in"), {
  test_that("runs()", {
    expect_GET(
      runs(),
      "http://localhost/api/runs"
    )

    expect_GET(
      runs(sha = "C0C0A"),
      "http://localhost/api/runs?sha=C0C0A"
    )
  })
})

with_mock_dir(test_path("resp-class"), {
  sha_1 <- "babb1ed"
  sha_2 <- "5eaf00d"
  test_that("runs() returns a data.frame", {
    the_run <- runs(sha = sha_1)
    expect_s3_class(
      the_run,
      "data.frame"
    )
    expect_identical(sha_1, the_run$commit.sha)
  })

  test_that("runs() accepts and returns multiple values", {
    shas <- c(sha_1, sha_2)
    runs <- runs(sha = shas)
    expect_s3_class(
      runs,
      "data.frame"
    )
    expect_identical(shas, unique(runs$commit.sha))
  })

  test_that("runs() returns a list", {
    the_list_run <- runs(sha = sha_1, simplifyVector = FALSE, flatten = FALSE)
    expect_type(
      the_list_run,
      "list"
    )
    expect_identical(sha_1, the_list_run[[1]]$commit$sha)
  })
})
