test_that("get_config works when dot_conbench file is present", {
  expect_identical(Sys.getenv("DOT_CONBENCH"), "dot_conbench")
  config <- get_config()

  expect_identical(config$url, "http://localhost")
  expect_identical(config$email, "chaka@example.com")
  expect_identical(config$password, "moon")
})

test_that("get_config works to three env vars even when dot_conbench is present", {
  set3envs <- test_get_config_env_vars(
    list(
      "DOT_CONBENCH" = "dot_conbench",
      "CONBENCH_EMAIL" = "ringo@example.com",
      "CONBENCH_URL" = "http://otherlocalhost",
      "CONBENCH_PASSWORD" = "starr"
    )
  )
  expect_identical(set3envs$url, "http://otherlocalhost")
  expect_identical(set3envs$email, "ringo@example.com")
  expect_identical(set3envs$password, "starr")
})

test_that("get_config errors when it has no environment variables",{
  expect_error(
    test_get_config_env_vars(
      list(
        "DOT_CONBENCH" = ""
      )
    ), "url not set, email not set and password not set"
  )
})

with_mock_dir(test_path("not-logged-in"), {
  test_that("Can log in", {
    testthat::skip_if_not(Sys.getenv("GITHUB_ACTIONS") == "true")
    expect_null(.conbench_session$cookie)
    expect_error(resp <- request("http://localhost/api") |>
      req_url_path_append("users") |>
      conbench_perform())
  })
})

with_mock_dir(test_path("logged-in"), {
  test_that("Can log in", {
    resp <- request("http://localhost/api") |>
      req_url_path_append("contexts") |>
      conbench_perform()
    expect_identical(resp_status(resp), 200L)
  })
})