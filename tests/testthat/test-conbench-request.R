test_that("conbench_request()", {
  req <- conbench_request()

  expect_s3_class(req, "httr2_request")
  expect_identical(req$url, "http://localhost/api")

  # can override
  req <- conbench_request("http://not.a.host/api")

  expect_s3_class(req, "httr2_request")
  expect_identical(req$url, "http://not.a.host/api")

  # and we have a default if there's no .conbench
  withr::with_envvar(
    list(DOT_CONBENCH = "/not/a/file"),
    {
      req <- conbench_request()

      expect_s3_class(req, "httr2_request")
      expect_identical(req$url, "https://conbench.ursa.dev/api")
    }
  )
})
