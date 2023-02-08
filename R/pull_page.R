#' Extract work-level information from html text document
#'
#' @param tag_ls A list containing an html document parsed with html_text() as `all_text1`,
#' and the same document parsed with html_text2() as `all_text2`.
#'
#'
#' @importFrom stringr str_extract
#'
#' @returns Cleaned data.table representing an AO3 page.
#' @export
#'
pull_page <- function(tag_ls){
  text1 <- tag_ls[["text1"]]
  text2 <- tag_ls[["text2"]]

  tags <- data.table(
    kudos = stringr::str_extract(text2, "(?<=\nKudos:\n).\\d+"),
    word_count = stringr::str_extract(text2, "(?<=\nWords:\n).*"),
    collections = stringr::str_extract(text2, "(?<=\nCollections:\n).\\d+"),
    bookmarks = stringr::str_extract(text2, "(?<=\nBookmarks:\n).\\d+"),
    hits = stringr::str_extract(text2, "(?<=\nHits:\n).\\d+"),
    comments = stringr::str_extract(text2, "(?<=\nComments:\n).\\d+"),
    language = stringr::str_extract(text2, "(?<=\nLanguage:\n).*"),
    ratings = stringr::str_extract(text2, "Teen And Up Audiences|Explicit|General Audiences|Mature|Not Rated"),
    categories = stringr::str_extract_all(text2, "M/M|F/M|Gen|Multi|F/F|Other"),
    last_visited = stringr::str_extract(text2, "(?<=\nLast visited: ).{11}"),
    chapters = stringr::str_extract(text2, "(?<=\nChapters:\n).*"),
    last_updated = stringr::str_extract(text2, ".{11}(?=\n\nTags)"),

    #custom functions
    times_visited = pull_visits(text2),
    warnings = pull_warnings(text2),
    tags = pull_tags(text2),
    summary = pull_summary(text2),
    complete_flag = pull_complete_flag(text2),

    # using text1
    titles = stringr::str_extract(text1, "(?<=\n\n\n    \n\n  \n  \n\n    \n      ).*"),
    authors = stringr::str_extract(text1, "(?<=by\n        \n      \n      ).*"),
    snapshot_utc = lubridate::now()

  )
  tags
}
