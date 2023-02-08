#' Collate extracted AO3 pages into a dataset
#' @rdname collate_pages
#' @param s An rvest session
#' @param start_page,end_page Which number page to start/end pulling from
#' @param url The general URL to paginate through.
#' @param seconds_to_wait How many seconds to wait in between web scrapes.
#' @param wd The directory in which to save the result.
#'
#' @return A clean dataset of the URL from `start_page` to `end_page`
#' @export
#'
collate_pages <- function(s, start_page = NULL, end_page = NULL,
                          url, seconds_to_wait = 5, wd){
  if(is.null(start_page)){
    start_page <- 1
  }
  if(is.null(end_page)){
    end_page <- 10
  }

  all_pages <- rbindlist(
    lapply(seq_len(end_page), function(page){
      Sys.sleep(seconds_to_wait)
      process_page(s, page, url, wd)
    }))

  all_pages
}
