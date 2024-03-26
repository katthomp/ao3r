## grabbing population level data
##
##
##
##
# library(rvest)
# library(purrr)
# library(stringr)
# library(data.table)
# library(dplyr)
# library(lubridate)
#
# fandom_url <- "https://archiveofourown.org/tags/Harry%20Potter%20-%20J*d*%20K*d*%20Rowling/works"


#' Title
#'
#' @param user
#' @param pw
#'
#' @return
#' @export
#'
#' @examples
login <- function(user, pw){
  base <- "https://archiveofourown.org"
  login <- "/users/login"
  s <- rvest::session(url = paste0(base, login))
  f <- rvest::html_form(s)[[1]]
  fill_f <- rvest::html_form_set(f, `user[login]` = user, `user[password]`= pw)
  rvest::session_submit(s, fill_f)
  return(s)
}

get_fandoms <- function(s, url, media){
  raw <- rvest::session_jump_to(s, url) |>
    rvest::html_elements(xpath = '//*[contains(@class, "tags index group")]/li') |>
    html_text() #parse every new line as n relating to the last
  parsed <- purrr::compact(sapply(X = raw, FUN = function(i){
    stringr::str_split(stringr::str_trim(i, side = "both"), pattern = "\\n")[1:2]
  }))

  fan_df <- data.table::data.table(title = sapply(parsed, `[[`, 1), total = sapply(parsed, `[[`, 2), media = rep_len(media, length(parsed)))
  fan_df
}

get_fandom_tags <- function(s, url, media){
  raw <- rvest::session_jump_to(s, url) |>
    rvest::html_elements(xpath = '//*[contains(@class, "work index group")]/li') |>
    html_text() #parse every new line as n relating to the last
  parsed <- purrr::compact(sapply(X = raw, FUN = function(i){
    stringr::str_split(stringr::str_trim(i, side = "both"), pattern = "\\n")[1:2]
  }))

  fan_df <- data.table::data.table(title = sapply(parsed, `[[`, 1), total = sapply(parsed, `[[`, 2), media = rep_len(media, length(parsed)))
  fan_df
}



# Build search URL

library(rvest)
library(httr)

star_wars <- "https://archiveofourown.org/tags/Star%20Wars%20-%20All%20Media%20Types/works"
s <- login("scifluff", "Dwstshpfan1")

rvest::session_jump_to(s, star_wars) |> html_text()

## in order to parse raw html text, eliminate the possibility of camelcase (no fic author does that shit)
### this is possible only without tags -- these are impossible to parse without the html structure behind them
### so then the actual population fandom pull is pretty easy
###
### separate out getting the tags from pulling all the works
###
### https://www.r-bloggers.com/2014/04/deploying-desktop-apps-with-r/

paginate <- function(s, URL, start, end){

}

## Necessary because it's impossible to query past the 5000 pg (so any URL cannot return more than 100k results)


## works on any general /works page
get_tag_filters <- function(s, url){
  popular_tags <- session_jump_to(s, url) |>
    html_elements(xpath = '///*[contains(@class, "include tags group")]/dl/dd/ul/li/label/span') |>
    html_text() |> unique()

  df <- data.table(tag = popular_tags)
  df[, n := str_remove_all(str_extract(tag, "\\([:digit:]+\\)"), "[:punct:]")]
  df[, tag := str_remove(tag, " \\([:digit:]+\\)$")]

}

ratings <- c("Mature", "Explicit")



pull_tag_info <- function(works_df){
# "This tag belongs to the", , "Category" need some sort of regex pattern in order capture what's missing here
# gradually save these responses / everything on a page into a table and then we can just look up what it is
# Should probably make this table now as a start and then do this more concretely later
}

### search query layout:
# work_search[sort_column]:
# revised_at
# include_work_search[rating_ids][]:
#   13
# include_work_search[freeform_ids][]:
#   110
# work_search[other_tag_names]:
#   work_search[excluded_tag_names]:
#   work_search[crossover]:
#   work_search[complete]:
#   T
# work_search[words_from]:
#   work_search[words_to]:
#   work_search[date_from]:
#   work_search[date_to]:
#   work_search[query]:
#   work_search[language_id]:

# 9 is not rated
# 10 is GEN,
# 11 is Teen
# 12 is mature
# 13 is explicit

## need to embed a data frame into the package itself keeping track of the tag ids



## should take a list of inputs collected by some other means
## creates list structure above
# create_search_query <- function(sort_column = NULL,
#                                 category = NULL,
#                                 freeform_ids = NULL,
#                                 ){
#   query <- list(
#     commit = "Sort+and+Filter",
#     `work_search[sort_column]` = sort_column,
#     `include_work_search[rating_ids]` = ratings,
#     `include_work_search[category_ids]` = category,
#     `include_work_search[fandom_ids]` = fandoms,
#     `work_search[other_tag_names]` =
#     `work_search`
#     `work_search`
#     `work_search`
#     `work_search`
#     `work_search[]`
#     `work_search[query]`
#     `work_search[language_id]`,
#     `tag_id`
#
#   )
# }
#
#

# use `work_search[other_tag_names]`

query <- list(
      commit = "Sort+and+Filter",
      `work_search[sort_column]` = sort_column,
      `include_work_search[freeform_ids]` = ratings,
    )




url_by_tag <- function(tag){
  base_url <- "https://archiveofourown.org/tags/"
  url <-paste0(base_url, URLencode(tag), "/works")
}


# ### Login to AO3
# s <- login("scifluff", "Dwstshpfan1")
#
# ## Pull all fandoms currently on the site
# full_population <- start_fandom_pull(s)
#
# ## Save response to ~/coding/data
# save_api_response(full_population, "full_population")
#
# ## Narrow list of fandoms from a threshold of fics
# top <- full_population[total > 1000,]


tags <- tribble(
  ""
)


# - Hypothesis: Most of these fics are going to have sub!reader, like a statistically significant margin.
#  - will have more tags relating to rough sex / choking / spanking than other male/female pairings.
#  - will have more daddy kink
#
#
#  # - can you measure the relative thirstiness of a fandom based on how many explicit fics there are?
# - what is the proportion for each relationship category the number of explicit fics? is one category overall more pornographic?

# time series
#
#

# starshipalto
#
#
# devtools::load_all()
# library(ggplot2)
# check <- 10000
# s <- login("scifluff", "Dwstshpfan1")
# pop <- start_fandom_pull(s)
# uniq <- pop |>
#   group_by(media) |>
#   arrange(desc(total)) |>
#   distinct(title, .keep_all = TRUE)
#
# filtered <- uniq |>
#   filter(total >= check) |>
#
#
#   # Number of fandoms w/ > "check" fics by media
#   ggplot(filtered, aes(x = media)) +
#   geom_histogram(stat = "count") +
#   scale_y_continuous(breaks = seq(0, 80, 5))
#
# # Now what I want to see is the general distribution of statistics for each of these fandoms
#
#
#
#
#
#
#
# ggplot(filtered, aes(x = media)) +
#   geom_freqpoly(stat = "count")
#
#
#
# ggplot(filtered, aes(x = title))
