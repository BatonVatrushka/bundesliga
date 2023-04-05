
# define the seasons from 2017 to 2022 ====
seasons <- c()

start_year <- 2017
end_year <- lubridate::year(Sys.Date()) - 1

for (year in start_year:end_year){
  seasons <- c(seasons, str_c(year, '-', year + 1))
}

# create the URLs ====
urls <- c()

for (season in seasons){
  # create the url string(s)
  urls <- c(urls,
            str_c("https://fbref.com/en/comps/20/"
                  , season 
                  ,"/schedule/"
                  , season 
                  ,"-Bundesliga-Scores-and-Fixtures"))
}

# run the function ====
dataframe <- map(urls, scrape_bundesliga_data) %>%
  list_rbind()
