#
# New idea for ao3 scraper, analyze the word frequency / do some textual analysis on canon male character/reader
#
#
#
# questions:
# - is there a relationship between how many RPF fics there are of the actors versus the tv shows they're in?
#   - namely, is it able to predict how popular a particular show/movie is to a certain degree of confidence?
#   - can you follow an actor through fic? for example, chris evans was very popular at a certain point, but he hasn't been in fandom recently.
#     - contrast with pedro pascal, who has rocketed to fandom darling recently.
#
#
#
# - can you measure the hype of a new tv show/movie based on how many fics are included within it (requires time series data)
#
# - need to scrape tag search pages and grab all the ones that have over 1k
# - need to also develop something to download html file of fics to reduce webcrawling
#   - needs to simulate clicking the download link
#



# When you're incorporating multiple different data sources, how do you decide how to rank the data's quality?
# How can you best take a set of attributes within a hierarchical structure

# ranking determined for tomorrow from tweets at t-1, fanart at t
# assume no lag



pull_tag_search <- function(s, url){

}

# Simulates pressing the download button on a particular fic
download_fic <- function(url){
  url <-
}
