test_that("url_cleaner()", {
  expect_identical(
    url_cleaner("http://conbench.dev/api/foo"),
    "https://conbench.dev/foo"
  )

  # But if the URL already works, no change
  expect_identical(
    url_cleaner("https://conbench.dev/foo"),
    "https://conbench.dev/foo"
  )
})
