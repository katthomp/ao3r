#' Pull population-level data
#'
#' @param s An active rvest session.
#' @param url URL to webscrape
#' @param media AO3 media category for fandoms.
#'
#'
#' @importFrom stringr str_split str_trim str_remove_all
#' @importFrom data.table rbindlist `:=`
#' @importFrom lubridate now
#' @importFrom purrr compact
#' @importFrom rvest session html_elements
#' @importFrom cli cli
#' @name population
#' @export
get_fandoms <- function(s, url, media) {
  raw <- rvest::session_jump_to(s, url) |>
    rvest::html_elements(xpath = '//*[contains(@class, "tags index group")]/li') |>
    html_text() # parse every new line as n relating to the last
  parsed <- purrr::compact(sapply(X = raw, FUN = function(i) {
    stringr::str_split(stringr::str_trim(i, side = "both"), pattern = "\\n")[1:2]
  }))

  titles <- sapply(parsed, `[[`, 1)
  fan_df <- data.table(
    title = titles,
    total = sapply(parsed, `[[`, 2),
    media = rep_len(media, length(parsed))
  )

  explore <- fan_df |> filter(total > 10000)

  urls <- map(explore$title, ~ paste0("https://archiveofourown.org/tags/", URLencode(.x), "/works"))

  tags <- sapply(urls, function(url) {
    try({
      Sys.sleep(10)
      pull_page_fandom(s, url)
    })
  })

  tags <- bind_cols(titles, sapply(urls, pull_page_fandom, s = s))
}



#' #' @name population
#' #' @export
#' get_fandoms <- function(s, url, media){
#'   raw <- rvest::session_jump_to(s, url) |>
#'     rvest::html_elements(xpath = '//*[contains(@class, "tags index group")]/li') |>
#'     html_text() #parse every new line as n relating to the last
#'   parsed <- purrr::compact(sapply(X = raw, FUN = function(i){
#'     stringr::str_split(stringr::str_trim(i, side = "both"), pattern = "\\n")[1:2]
#'   }))
#'
#'   fan_df <- data.table::data.table(title = sapply(parsed, `[[`, 1), total = sapply(parsed, `[[`, 2), media = rep_len(media, length(parsed)))
#'   fan_df
#' }

#' @describeIn population start_fandom_pull
#' @export
start_fandom_pull <- function(s) {

  bk <- "https://archiveofourown.org/media/Books%20*a*%20Literature/fandoms"
  vid <- "https://archiveofourown.org/media/Video%20Games/fandoms"
  cartoon <- "https://archiveofourown.org/media/Cartoons%20*a*%20Comics%20*a*%20Graphic%20Novels/fandoms"
  rpf <- "https://archiveofourown.org/media/Celebrities%20*a*%20Real%20People/fandoms"
  anime <- "https://archiveofourown.org/media/Anime%20*a*%20Manga/fandoms"
  tv <- "https://archiveofourown.org/media/TV%20Shows/fandoms"
  movie <- "https://archiveofourown.org/media/Movies/fandoms"
  other <- "https://archiveofourown.org/media/Other%20Media/fandoms"
  music <- "https://archiveofourown.org/media/Music%20*a*%20Bands/fandoms"
  theater <- "https://archiveofourown.org/media/Theater/fandoms"

  tv_df <- get_fandoms(s, tv, media = "tv show")
  rpf_df <- get_fandoms(s, rpf, media = "rpf")
  vid_df <- get_fandoms(s, vid, media = "video games")
  anime_df <- get_fandoms(s, anime, media = "anime")
  movie_df <- get_fandoms(s, movie, media = "movie")
  bk_df <- get_fandoms(s, bk, media = "book")
  toon_df <- get_fandoms(s, cartoon, media = "cartoon")
  other_df <- get_fandoms(s, other, media = "other")
  music_df <- get_fandoms(s, music, media = "music")
  stage_df <- get_fandoms(s, theater, media = "theater")
  pop_raw <- data.table::rbindlist(list(tv_df, rpf_df, vid_df, anime_df, movie_df, bk_df, toon_df, other_df, music_df, stage_df))


  pop_raw[, total := as.numeric(stringr::str_remove_all(total, "[:punct:]|[:space:]"))]
  pop_raw[, snapshot_utc := lubridate::now(tzone = "UTC")]
  pop_raw
}

#' @describeIn population Check whether url returns more than 5000 pages (100k works)
test_for_fandom_size <- function(s, url){
  mx_pg <- get_max_page(s, url)
  ifelse(mx_pg > 5000, warning("Cannot accurately show results for entire search query"), TRUE)
}
