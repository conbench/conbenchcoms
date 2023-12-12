.onAttach <- function(libname, pkgname) {
  if (interactive()) {
    load_msg <- tryCatch(
      {
        msg <- conbench_info()
        packageStartupMessage(
            paste0(
              "Conbench server information\n",
              paste0(" - ", names(msg), ": ", msg, collapse = "\n")
            ),
            "\n"
          )
      },
      error = function(e) {
        packageStartupMessage("No available conbench info")
      }
    )
  }
}
