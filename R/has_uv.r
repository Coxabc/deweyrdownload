#' Check if UV is installed (Internal)
#'
#' Checks whether the UV Python package manager is available on the system PATH.
#'
#' @return A logical value: `TRUE` if UV is found on the system PATH, `FALSE` otherwise.
#'
#' @details
#' This function uses `Sys.which()` to search for the UV executable in the system's
#' PATH environment variable. UV is a fast Python package installer and resolver
#' written in Rust.
#'
#' @seealso \code{\link{install_uv}} for installing UV if it's not present
#'
#' @keywords internal
#' @noRd
has_uv <- function() {
  Sys.which("uv") != ""
}

