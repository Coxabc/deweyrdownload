#' Find Python Executable
#'
#' Searches for a Python executable on the system by checking common locations.
#' First tries using Sys.which(), then falls back to checking standard 
#' installation directories.
#'
#' @return Character string containing the path to a Python executable.
#' @export
#' @examples
#' \dontrun{
#' # Find Python on your system
#' python_path <- find_python()
#' print(python_path)
#' }
find_python <- function() {
  # Try Sys.which first (best practice)
  py <- Sys.which(c("python", "python3"))
  py <- py[py != ""]
  
  if (length(py) > 0) {
    return(unname(py[1]))
  }
  
  # Fallback: common install locations
  candidates <- c(
    "/usr/bin/python",
    "/usr/bin/python3",
    "/usr/local/bin/python",
    "/usr/local/bin/python3",
    "C:/Python39/python.exe",
    "C:/Python310/python.exe",
    "C:/Python311/python.exe",
    "C:/Python312/python.exe"
  )
  
  candidates <- candidates[file.exists(candidates)]
  
  if (length(candidates) > 0) {
    return(normalizePath(candidates[1]))
  }
  
  stop("Python executable not found. Please install Python or set PATH.")
}