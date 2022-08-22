with_mock_dir(test_path("logged-in"), {
  test_that("info()", {
    expect_GET(
      info(),
      "http://localhost/api/info"
    )

    expect_GET(
      info("C0C0A"),
      "http://localhost/api/info/C0C0A"
    )
  })
})


with_mock_dir(test_path("resp-class"), {
  test_that("info() returns a data.frame", {
    the_info <- info()
    expect_s3_class(
      the_info,
      "data.frame"
    )
    expect_identical("Python 3.8.13", unique(the_info$benchmark_language_version))
  })
  test_that("info(...,simplifyVector = FALSE, flatten = FALSE) returns a list", {
    the_list_info <- info(simplifyVector = FALSE, flatten = FALSE)
    expect_type(
      the_list_info,
      "list"
    )
    expect_identical("Python 3.8.13", the_list_info[[1]]$benchmark_language_version)
  })
})