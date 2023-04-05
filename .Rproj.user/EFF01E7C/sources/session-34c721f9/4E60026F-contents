# data preparation 

# scrape the data ====
source('data_scrape_88_16.R')
source('data_scrape.R')

# clean up the early data ====
# filter rows where there aren't home/away goals
dataframe_early_clean <- dataframe_early %>%
  drop_na(c(home_goals, away_goals)) %>%
  # make attendance a numeric value
  mutate(attendance = as.numeric(str_replace_all(attendance, ',', ''))
         # total goals
         , total_goals = home_goals + away_goals) %>%
  # remove the data column
  dplyr::select(-date)

# clean up the current data ====
dataeframe_clean <- dataframe %>% 
  filter(home_goals != is.na(home_goals) 
         & away_goals != is.na(away_goals))

# create the test data ====
test <- dataframe %>%
  filter(is.na(home_goals) & is.na(away_goals)) %>%
  dplyr::select(time, home_team, away_team)

# create the training data ====
train <- dataframe_early_clean %>%
  bind_rows(dataeframe_clean) %>%
  dplyr::select(-date, -score, -total_goals, -venue, -attendance) %>%
  mutate(time = if_else(is.na(time), median(train$time, na.rm = T), time))












