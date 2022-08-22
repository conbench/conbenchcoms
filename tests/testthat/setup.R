library(httptest2)

# So that we can avoid a .file, but still include it, set the env var:
Sys.setenv(DOT_CONBENCH = "dot_conbench")
Sys.unsetenv("CONBENCH_EMAIL")
Sys.unsetenv("CONBENCH_URL")
Sys.unsetenv("CONBENCH_PASSWORD")

## this function allows us to test get_config with
## different combinations of environment variables
## to make sure that the two combinations are
## configured correctly. See: test-session.R
test_get_config_env_vars <- function(...) {
  withr::local_envvar(...)
  get_config()
}