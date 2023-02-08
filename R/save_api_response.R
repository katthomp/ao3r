#' Save API response
#'
#' @param df R object to save to a file
#' @param filename File name to save the data to
#' @param wd Directory to save the .Rda file to
#' @export
save_api_response <- function(df, filename, wd) {
  folder <- as.numeric(lubridate::today())
  time <- round(as.numeric(lubridate::now()))
  path <- paste0(wd, folder)
  if (!dir.exists(path)) {
    dir.create(path)
  }
  new_file <- paste0(path, "/", filename, "-", time, ".Rda")
  saveRDS(df, new_file)
  if (file.exists(new_file)) {
    message(paste("File", new_file, "created"))
    invisible(NULL)
  } else{
    stop("File not created")
  }
}
