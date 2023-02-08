# TODO fix this

#' @inheritParams collate_pages s url
#' @importFrom readr parse_number
#' @importFrom rvest session_jump_to
#' @importFrom stringr str_trim
get_max_page <- function(s, url){
  pages <- session_jump_to(s, url) |>
    html_elements(xpath = '///*[starts-with(@role, "navigation")]') |> html_text()
  html_elements(xpath = 'li/a') |>
    html_attrs()

  nums <- parse_number(sapply(pages, str_trim, "both"))
  max(nums, na.rm = TRUE)
}
