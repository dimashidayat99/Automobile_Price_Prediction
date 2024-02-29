library(tidyverse)
library(stringr)
library(purrr)
library(Amelia)
library(GGally)
library(caret)
library(relaimpo)
library(randomForest)
library(gbm)
library(broom)
library(dplyr)
library(e1071)
library(skimr)
library(janitor)
library(tidymodels)
library(vip)
library(xgboost)
library(openxlsx)

car <- read.csv('car_project.csv')

car[car == ''] <- NA
sapply(car, function(x) sum(is.na(x)))


# change model name to company name
car$name <- word(car$name,1)

# change car mileage to numeric & impute missing value using mean
car$mileage <- parse_number(car$mileage)
car$mileage[is.na(car$mileage)]<-mean(car$mileage,na.rm=TRUE)

#change car engine to numeric & impute missing value using mean
car$engine <- parse_number(car$engine)
car$engine[is.na(car$engine)]<-mean(car$engine,na.rm=TRUE)

#change max power to numeric & impute missing value using mean
car$max_power <- parse_number(car$max_power)
car$max_power[is.na(car$max_power)]<-mean(car$max_power,na.rm=TRUE)

# change car seat to numeric & imput missing value using median
car$seats[is.na(car$seats)]<-median(car$seats,na.rm=TRUE)

# change car torque to numeric and input missing value using mean
car$torque <- parse_number(car$torque)
car$torque[is.na(car$torque)]<-mean(car$torque,na.rm=TRUE)

sold_per_year<- car %>% group_by(name, year)%>%summarise(Count=length(name))
sold_per_year <- filter(sold_per_year, year==2000)

sold_per_year
ggplot(data = sold_per_year, aes(y=Count, x=name))+
  geom_bar(stat="identity", width = 0.5, fill="#E14D2A",color = 'black')+
  geom_text(aes(label=Count), vjust=1.7, color="black", size=3.0)+
  labs(x="Car brand",
       y="Count", 
       title="Cars sold in 2000")+ 
  theme_bw()+
  theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10),
        axis.text.y= element_text(size=10), axis.title=element_text(size=10))



set.seed(345)
split <- initial_split(car, prop = .80)
train_df <- training(split)
test_df <- testing(split)

# Create recipe and roles--preprocessing for the model
recipe <-
  recipe(selling_price ~ ., data = train_df) %>%
  step_dummy(all_predictors(), -all_numeric()) %>%
  step_zv(all_predictors()) %>%
  step_center(all_predictors(), -all_nominal()) %>%
  step_scale(all_predictors(), -all_nominal()) %>%
  step_impute_mean(all_predictors(), -all_nominal()) 

# Model, with hyperparameters chosen from best performing model after tuning models
mod <-
  boost_tree(trees = 6000,
             tree_depth = 3,
             learn_rate = 0.1) %>%
  set_engine('xgboost') %>%
  set_mode("regression")

# Workflow
set.seed(345)
wf <- workflow() %>%
  add_model(mod) %>%
  add_recipe(recipe)

final <-wf %>%
  fit(data  = train_df)


# Predictions with training set
predictions_train <- predict(final, train_df) %>%
  bind_cols(train_df %>% select_all)

# Test data predictions merged with test data
predictions_test <- predict(final, test_df) %>%
  bind_cols(test_df %>% select_all())

