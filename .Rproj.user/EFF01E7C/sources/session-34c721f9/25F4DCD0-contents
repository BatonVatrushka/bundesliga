# Load the required packages ====
library(rvest)
library(tidyverse)
library(lubridate)

# source the functions ====
source('functions.R')

# define the seasons from 1988 to 2016 ====
seasons <- c()

start_year <- 1988
end_year <- 2016

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



# map the function to the urls and create the df ====
dataframe_early <- map(urls, scrape_bundesliga_data_early) %>%
  list_rbind()

