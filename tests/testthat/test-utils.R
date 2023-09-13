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


test_that("integer shows message when providing a non integer", {
  expect_message(integer_messager(1.1), "must be an integer, converting to 1L")
})

test_that("integer shows message with a label when providing a non integer", {
  expect_message(integer_messager(1.1, "cool message"), "cool message must be an integer, converting to 1L")
})

test_that("integer fails when providing a non numeric", {
  expect_error(integer_messager("foo"), "must be numeric")
})

test_that("integer works when providing an integer", {
  expect_identical(integer_messager(1L), 1L)
})