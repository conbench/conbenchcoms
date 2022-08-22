with_mock_dir(test_path("logged-in"), {
  test_that("hardware()", {
    expect_GET(
      hardware(),
      "http://localhost/api/hardware"
    )

    expect_GET(
      hardware("C0C0A"),
      "http://localhost/api/hardware/C0C0A"
    )
  })
})


with_mock_dir(test_path("resp-class"), {
  test_that("hardware() returns a data.frame", {
    the_hardware <- hardware()
    expect_s3_class(
      the_hardware,
      "data.frame"
    )
    expect_identical("machine", the_hardware$type)
  })
  test_that("hardware(...,simplifyVector = FALSE, flatten = FALSE) returns a list", {
    the_list_hardware <- hardware(simplifyVector = FALSE, flatten = FALSE)
    expect_type(
      the_list_hardware,
      "list"
    )
    expect_identical("machine", the_list_hardware[[1]]$type)
  })
})