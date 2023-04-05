# functions

# define function to turn time into a fractional number of hours ====
time_to_frac_num <- function(time_str){
  # split string by the colon
  time_parts <- str_split(time_str, ":")[[1]]
  
  # convert the hours and minutes to numeric values
  hours <- as.numeric(time_parts[1])
  minutes <- as.numeric(time_parts[2])
  
  # calculate fractional hours
  time_numeric <- hours + (minutes/60)
  
  # return the value
  return(time_numeric)
}

# build the function to scrape the data for seasons before 2017/2018 ====
scrape_bundesliga_data_early <- function(url){
  # Read the webpage
  webpage <- read_html(url)
  
  # Extract match data
  matches <- webpage %>%
    html_nodes(xpath = "//table[contains(@class, 'stats_table')]//tbody//tr[not(contains(@class, 'thead'))]")
  
  # Extract individual columns
  day <- matches %>%
    html_nodes("td:nth-child(2)") %>%
    html_text(trim = TRUE)
  
  date <- matches %>%
    html_nodes("td:nth-child(3)") %>%
    html_text(trim = TRUE)
  
  time <- matches %>%
    html_nodes("td:nth-child(4)") %>%
    html_text(trim = TRUE)
  
  home_team <- matches %>%
    html_nodes("td:nth-child(5)") %>%
    html_text(trim = TRUE)
  
  score <- matches %>%
    html_nodes("td:nth-child(6)") %>%
    html_text(trim = TRUE)
  
  away_team <- matches %>%
    html_nodes("td:nth-child(7)") %>%
    html_text(trim = TRUE) 
  
  attendance <- matches %>%
    html_nodes("td:nth-child(8)") %>%
    html_text(trim = TRUE)
  
  venue <- matches %>%
    html_nodes("td:nth-child(9)") %>%
    html_text(trim = TRUE)
  
  # build the data frame
  match_data <- tibble(
    date = date
    , time = time
    , home_team = home_team
    , score = score
    , away_team = away_team
    , attendance = attendance
    , venue = venue
  ) %>%
    mutate(date = lubridate::as_date(date)
           , time = map_dbl(time, time_to_frac_num)
           , home_goals = as.numeric(str_extract(score, "^\\d+"))
           , away_goals = as.numeric(str_extract(score, "\\d+$")))
  
  return(match_data)
}

# build the function to scrape the data ====
scrape_bundesliga_data <- function(url){
  # Read the webpage
  webpage <- read_html(url)
  
  # Extract match data
  matches <- webpage %>%
    html_nodes(xpath = "//table[contains(@class, 'stats_table')]//tbody//tr[not(contains(@class, 'thead'))]")
  
  # Extract individual columns
  day <- matches %>%
    html_nodes("td:nth-child(2)") %>%
    html_text(trim = TRUE)
  
  date <- matches %>%
    html_nodes("td:nth-child(3)") %>%
    html_text(trim = TRUE)
  
  time <- matches %>%
    html_nodes("td:nth-child(4)") %>%
    html_text(trim = TRUE)
  
  home_team <- matches %>%
    html_nodes("td:nth-child(5)") %>%
    html_text(trim = TRUE)
  
  score <- matches %>%
    html_nodes("td:nth-child(7)") %>%
    html_text(trim = TRUE) 
  
  away_team <- matches %>%
    html_nodes("td:nth-child(9)") %>%
    html_text(trim = TRUE)
  
  attendance <- matches %>%
    html_nodes("td:nth-child(10)") %>%
    html_text(trim = TRUE) %>%
    str_replace_all(',', '') %>%
    as.numeric()
  
  venue <- matches %>%
    html_nodes("td:nth-child(11)") %>%
    html_text(trim = TRUE)
  
  # build the data frame
  match_data <- tibble(
    date = date
    , time = time
    , home_team = home_team
    , score = score
    , away_team = away_team
    , attendance = attendance
    , venue = venue
  ) %>%
    mutate(date = lubridate::as_date(date)
           , time = map_dbl(time, time_to_frac_num)
           , home_goals = as.numeric(str_extract(score, "^\\d+"))
           , away_goals = as.numeric(str_extract(score, "\\d+$")))
  
  return(match_data)
}