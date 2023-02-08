#' Login to AO3 programmatically
#'
#' @param user Your AO3 username.
#' @param pw Your AO3 password
#'
#' @return A virtual "logged in" AO3 web session.
#' @export
#'
login <- function(user, pw){
  base <- "https://archiveofourown.org"
  login <- "/users/login"
  s <- rvest::session(url = paste0(base, login))
  f <- rvest::html_form(s)[[1]]
  fill_f <- rvest::html_form_set(f, `user[login]` = user, `user[password]`= pw)
  rvest::session_submit(s, fill_f)
  return(s)
}
