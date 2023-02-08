#' Scrape a raw AO3 page
#'
#' @param s Rvest session containing the AO3 URL to pull data from, and must
#' be one of the following:
#' @param page_number The numeric page number queried in `s`.
#' @param url URL of html document to be scraped
#' @param wd Directory to which raw JSON should be stored
#'
#' @importFrom rvest html_attrs html_elements html_text html_text2
#' @importFrom purrr map
#' @importFrom stringr str_glue str_remove_all str_detect
#' @importFrom stats setNames
#' @importFrom utils globalVariables
#' @importFrom data.table fcase
#' @return List containing the same XML document parsed with html_text and html_text2
#' @export
scrape_page_raw <- function(s, page_number, wd, url){
  if(is.null(webpage_type)){
    webpage_type <- "history"
  }

  xpath_switch <- fcase(str_detect(url, "history"), "reading work",
                         str_detect(url, "bookmarks"), "bookmark",
                         str_detect(url,"work"), "work")

  xpath <- str_glue('//*[contains(@class, "{xpath_switch} index group")]/li')
  all_text1 <- html_elements(s, xpath = xpath) |>
    html_text()

  all_text2 <- html_elements(s, xpath = xpath) |>
    html_text2()

  ids <- html_elements(s, xpath = xpath) |>
    html_attrs() |>
    map(`[[`, 1) |>
    map(str_remove_all, "work_")

  all_text1 <- setNames(all_text1, ids)
  all_text2 <- setNames(all_text2, ids)
  final_text <- list(text1 = all_text1,
                     text2 = all_text2)

  filename <- str_glue("{webpage_type}_pg_{page_number}.Rda")
  save_api_response(final_text, filename, wd = wd)
  final_text
}
