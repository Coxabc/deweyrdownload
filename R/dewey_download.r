#' Download Files Using Deweypy
#'
#' Downloads files from a specified folder using the deweypy Python package
#'
#' @param api_key Character string with the API key for deweypy
#' @param folder_id Character string with the folder ID to download from
#' @param download_path Character string specifying where to download files.
#'   If NULL (default), uses the default directory from \code{get_download_dir()}
#' @param python_path Character string specifying the path to Python executable. 
#'   If NULL (default), will automatically search for Python on the system.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Auto-detect Python path, default download location
#' dewey_download(api_key = "your-api-key", folder_id = "folder123")
#' 
#' # Specify custom download path
#' dewey_download(
#'   api_key = "your-api-key", 
#'   folder_id = "folder123",
#'   download_path = "C:/Downloads/my-files"
#' )
#' 
#' # Specify Python path manually
#' dewey_download(
#'   api_key = "your-api-key", 
#'   folder_id = "folder123",
#'   python_path = "C:/Python313/python.exe"
#' )
#' }
dewey_download <- function(api_key, folder_id, download_path = NULL, python_path = NULL) {
  
  # If python_path is NULL, auto-detect it
  if (is.null(python_path)) {
    python_path <- find_python()
  }
  
  # Validate that python_path exists
  if (!file.exists(python_path)) {
    stop("Python executable not found at: ", python_path)
  }
  
  # Set default download path if not provided
  if (is.null(download_path)) {
    download_path <- get_download_dir(create = TRUE)
  } else {
    # If custom path provided, ensure it exists
    if (!dir.exists(download_path)) {
      dir.create(download_path, recursive = TRUE)
    }
  }
  
  # Run deweypy command
  system2(
    python_path,
    args = c(
      "-m", "deweypy",
      "--api-key", api_key,
      "--download-directory", download_path,
      "speedy-download", folder_id
    )
  )
}