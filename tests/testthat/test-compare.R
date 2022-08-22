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
