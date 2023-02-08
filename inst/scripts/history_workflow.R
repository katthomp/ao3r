library(beepr)


devtools::load_all("~/coding/projects/ao3r")

user <- Sys.getenv("USER")
pw <- Sys.getenv("PW")

s <- login("scifluff", "Dwstshpfan1")

url <- glue::glue("https://archiveofourown.org/users/{Sys.getenv('USER')}/readings")

start <- 1
end <- 5

## located in get_all_pgs along with dependency
# max_page <- get_max_page(s, url)

pg1_5 <- span_collate_pages(s, start, end, url)


pg_clean <- pg1_5 |>
  mutate(
    kudos = as.numeric(kudos),
    word_count = readr::parse_number(word_count),

  )

