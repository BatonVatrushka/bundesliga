# load the caret package
library(pacman)
p_load(caret)

# source the data
source('data_prep.R')

# home goal training set
trainHome <- train %>% dplyr::select(-away_goals)

# away goal training set 
trainAway <- train %>% dplyr:: select(-home_goals)

# define a trainControl
fit_control <- trainControl(method = "cv", number = 10) # cross-validation

# fit the home goals model
home_goals_model <- train(home_goals ~ .
                          , data = trainHome
                          , method = "glm"
                          , family = poisson(link = 'log')
                          , trControl = fit_control)

summary(home_goals_model)

# fit the away goals model
away_goals_model <- train(away_goals ~ .
                          , data = trainAway
                          , method = "glm"
                          , family = poisson(link = 'log')
                          , trControl = fit_control)

summary(away_goals_model)

# create a new df w/ predicted home and away goals
df_predict <- test %>% 
  mutate(home_goals = predict(home_goals_model, .) %>% round(2)
         , away_goals = predict(away_goals_model, .) %>% round(2)
         , total_goals = round(home_goals + away_goals, 2))




 