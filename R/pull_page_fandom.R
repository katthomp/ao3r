pull_page_fandom <- function(s, url){
  text1 <- rvest::session_jump_to(s, url) |>
    rvest::html_elements(xpath = '//*[contains(@class, "expandable")]') |>
    rvest::html_text2() |>
    unique()

}
