#' Extract work-level information from html text document
#'
#' @param text2 A character string made from converting a webpage into a html document.
#'
#' @returns Atomic vectors

#' @describeIn pull_atomics Pull number of chapters
pull_chapters <- function(text2){
  stringr::str_extract(text2, "(?<=\nChapters:\n).*") |>
    stringr::str_extract("\\d+") |>
    as.numeric()
}

#' @describeIn pull_atomics Pull boolean completeness flag
pull_complete_flag <- function(text2){
  complete_flags <- stringr::str_extract(text2, "(?<=\nChapters:\n).\\d+/\\d+") |>
    sapply(function(text){
      ifelse(is.na(text), FALSE, TRUE)
    })
  complete_flags
}

#' @describeIn pull_atomics Pull author's summary
pull_summary <- function(text2){
  pattern <- "\nSummary\n\n"
  stringr::str_split(text2, pattern) |>
    sapply(`[[`, 2) |>
    stringr::str_split(pattern = "\n\nSeries\n|\n\nLanguage") |>
    sapply(`[[`, 1)|>
    as.character()
}

#' @describeIn pull_atomics Pull all tags e.g.(character, warnings, pairings, etc)
pull_tags <- function(text2){
  pattern <- "(?<=\n\nTags\n).*"
  stringr::str_split(text2, pattern) |>
    sapply(`[[`, 2) |>
    stringr::str_split("\n") |>
    as.character()
}

# TODO need to make this function more specific to history pages / put in error checking
#' @describeIn pull_atomics Pull number of times visited from history page
pull_visits <- function(text2){
  times_visited <- stringr::str_extract(text2, "(?<=\\) Visited).\\d+") |>
    sapply(function(text){
      ifelse(is.na(text), 1, as.numeric(text))
    })
  times_visited
}

# TODO use the constants in the package instead of this weird pattern
#' @describeIn pull_atomics Pull all warning tags
pull_warnings <- function(text2){
  warnings <- "No Archive Warnings Apply|Creator Chose Not To Use Archive Warnings|Graphic Depictions Of Violence|Major Character Death|Rape/Non-Con|Underage"
  stringr::str_extract_all(text2, warnings) |>
    sapply(unique)
}
