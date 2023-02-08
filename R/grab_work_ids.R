#' Get work ids
#'
#' @param s Rvest session
#' @param url AO3 URL
#'
#' @return A numeric vector of AO3 work ids
#' @export
grab_work_ids <- function(s, url){
  v <- rvest::session_jump_to(s, url) |>
    rvest::html_elements(xpath = '//*[starts-with(@id, "work_")]') |>
    rvest::html_attr("id")
  raw_nums <- stringr::str_remove(stringr::str_subset(string = v, pattern = "[:digit:]"), "work_")
  return(as.numeric(raw_nums))
}
