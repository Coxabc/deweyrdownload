#' Read and Combine Compressed CSV Files
#'
#' Reads all .csv.gz files from a specified folder and combines them into a single data frame.
#'
#' @param folder_path Character string specifying the path to the folder containing .csv.gz files
#'
#' @return A data frame containing all combined data from the CSV files
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' data <- read_compressed_csvs("path/to/folder")
#' }
read_compressed_csvs <- function(folder_path) {
  # Validate folder exists
  if (!dir.exists(folder_path)) {
    stop("Folder does not exist: ", folder_path)
  }
  # Get all csv.gz files
  file_list <- list.files(
    path = folder_path, 
    pattern = "\\.csv\\.gz$", 
    full.names = TRUE
  )
  # Check if any files were found
  if (length(file_list) == 0) {
    stop("No .csv.gz files found in: ", folder_path)
  }
  # Read and combine all files
  result <- file_list %>%
    lapply(readr::read_csv, show_col_types = FALSE) %>%
    dplyr::bind_rows()
  return(result)
} 