#' Process raw AO3 link
#' @inheritParams scrape_page_raw
#' @export
process_page <- function(s, page_number, url, wd){
  url <- "https://archiveofourown.org/users/scifluff/readings?page="

  s <- session_jump_to(s, paste0(url, page_number))
  clean_page <- scrape_page_raw(s, page_number) |>
    pull_page()
  filename <- str_glue("pg_{page_number}_{lubridate::now()}.Rda")
  save_api_response(clean_page, filename, wd)
  clean_page
}
