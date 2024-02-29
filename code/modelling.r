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



car <- read.csv('../group_project/car_project.csv')

head(car)

names(car)
dim(car)
sapply(car, class)
car[car == ''] <- NA
sapply(car, function(x) sum(is.na(x)))
missmap(car, legend = TRUE, col = c("red", "blue"))


# change model name to company name
car$name <- word(car$name,1)

# change car mileage to numeric & impute missing value using mean
car$mileage <- parse_number(car$mileage)
car$mileage[is.na(car$mileage)]<-mean(car$mileage,na.rm=TRUE)
typeof(car$mileage)

#change car engine to numeric & impute missing value using mean
car$engine <- parse_number(car$engine)
car$engine[is.na(car$engine)]<-mean(car$engine,na.rm=TRUE)
typeof(car$engine)

#change max power to numeric & impute missing value using mean
car$max_power <- parse_number(car$max_power)
car$max_power[is.na(car$max_power)]<-mean(car$max_power,na.rm=TRUE)
typeof(car$max_power)
car[4934,]

# change car seat to numeric & imput missing value using median
car$seats[is.na(car$seats)]<-median(car$seats,na.rm=TRUE)

# change car torque to numeric and input missing value using mean
car$torque <- parse_number(car$torque)
car$torque[is.na(car$torque)]<-mean(car$torque,na.rm=TRUE)
typeof(car$torque)

sapply(car, function(x) sum(is.na(x)))

missmap(car, legend = TRUE, col = c("red", "blue"))

head(car)

lapply(car, class)

car$name <- str_replace(car$name, 'Maruti', '0')
car$name <- str_replace(car$name, 'Skoda', '1')
car$name <- str_replace(car$name, 'Honda', '2')
car$name <- str_replace(car$name, 'Hyundai', '3')
car$name <- str_replace(car$name, 'Toyota', '4')
car$name <- str_replace(car$name, 'Ford', '5')
car$name <- str_replace(car$name, 'Renault', '6')
car$name <- str_replace(car$name, 'Mahindra', '7')
car$name <- str_replace(car$name, 'Tata', '8')
car$name <- str_replace(car$name, 'Chevrolet', '9')
car$name <- str_replace(car$name, 'Fiat', '10')
car$name <- str_replace(car$name, 'Datsun', '11')
car$name <- str_replace(car$name, 'Jeep', '12')
car$name <- str_replace(car$name, 'Mercedes-Benz', '13')
car$name <- str_replace(car$name, 'Mitsubishi', '14')
car$name <- str_replace(car$name, 'Audi', '15')
car$name <- str_replace(car$name, 'Volkswagen', '16')
car$name <- str_replace(car$name, 'BMW', '17')
car$name <- str_replace(car$name, 'Nissan', '18')
car$name <- str_replace(car$name, 'Lexus', '19')
car$name <- str_replace(car$name, 'Jaguar', '20')
car$name <- str_replace(car$name, 'Land', '21')
car$name <- str_replace(car$name, 'MG', '22')
car$name <- str_replace(car$name, 'Volvo', '23')
car$name <- str_replace(car$name, 'Daewoo', '24')
car$name <- str_replace(car$name, 'Kia', '25')
car$name <- str_replace(car$name, 'Force', '26')
car$name <- str_replace(car$name, 'Ambassador', '27')
car$name <- str_replace(car$name, 'Ashok', '28')
car$name <- str_replace(car$name, 'Isuzu', '29')
car$name <- str_replace(car$name, 'Opel', '30')
car$name <- str_replace(car$name, 'Peugeot', '31')

car$name <- as.numeric(car$name)
table(car$name)

car$transmission <- str_replace(car$transmission, 'Manual', "0")
car$transmission <- str_replace(car$transmission, 'Automatic', "1")
car$transmission <- as.numeric(car$transmission)
table(car$transmission)

car$owner <- str_replace(car$owner, 'First Owner', "0")
car$owner <- str_replace(car$owner, 'Second Owner', "1")
car$owner <- str_replace(car$owner, 'Third Owner', "2")
car$owner <- str_replace(car$owner, 'Fourth & Above Owner', "3")
car$owner <- str_replace(car$owner, 'Test Drive Car', "4")
car$owner <- as.numeric(car$owner)
table(car$owner)

car$seller_type <- str_replace(car$seller_type, "Trustmark Dealer", "0")
car$seller_type <- str_replace(car$seller_type, "Dealer", "1")
car$seller_type <- str_replace(car$seller_type, "Individual", "2")
car$seller_type <- as.numeric(car$seller_type)
table(car$seller_type)

car$fuel <- str_replace(car$fuel, 'Diesel', "0")
car$fuel <- str_replace(car$fuel, 'Petrol', "1")
car$fuel <- str_replace(car$fuel, 'CNG', "2")
car$fuel <- str_replace(car$fuel, 'LPG', "3")
car$fuel <- as.numeric(car$fuel)
table(car$fuel)

head(car)

cat_cols <- c('name', 'year', 'fuel', 'seller_type', 'transmission', 'owner', 'seats')
num_cols <- c('km_driven', 'mileage', 'engine', 'max_power', 'torque')
target_cols <- c('selling_price')

preproc <- preProcess(car[, c(cat_cols,num_cols)], method=c("range"))
car_scaled <- predict(preproc, car)
head(car_scaled)

dim(car_scaled)
set.seed(100)

trainIndex <- createDataPartition(car_scaled$selling_price, p = 0.8,
                                  list = FALSE,
                                  times = 1)
train <- car_scaled[ trainIndex,]
test <- car_scaled[-trainIndex,]

dim(train)
dim(test)

#Linear Regression

lr <- lm(selling_price ~ ., data = train)
summary(lr)

pred_lr <- predict(lr, newdata = test)
error_lr <- test$selling_price - pred_lr

eval_lr <- cbind(test$selling_price, pred_lr)
colnames(eval_lr) <- c("True Price", "Predicted Price")
eval_lr <- as.data.frame(eval_lr)
head(eval_lr)

RMSE_lr <- round(sqrt(mean(error_lr^2)),2)
RMSE_lr

plot(test$selling_price,pred_lr, main="Scatterplot", col = c("blue","red"), xlab = "Actual Selling Price", ylab = "Predicted Selling Price")

#Random Forest
rf <- randomForest(selling_price~.,data = train)
rf

plot(rf)

pred_rf <- predict(rf, test)
error_rf <- test$selling_price - pred_rf
RMSE_rf <- round(sqrt(mean(error_rf^2)),2)
RMSE_rf

eval_rf <- cbind(test$selling_price, pred_rf)
colnames(eval_rf) <- c("True Price", "Predicted Price")
eval_rf <- as.data.frame(eval_rf)
head(eval_rf)

plot(test$selling_price,pred_rf, main="Scatterplot", col = c("blue","red"), xlab = "Actual Selling Price", ylab = "Predicted Selling Price")

set.seed(123)

# KNN
knn = knnreg(selling_price~.,data = train)
knn

pred_knn <- predict(knn, newdata = test)
error_knn <- test$selling_price - pred_knn

eval_knn <- cbind(test$selling_price, pred_knn)
colnames(eval_knn) <- c("True Price", "Predicted Price")
eval_knn <- as.data.frame(eval_knn)
head(eval_knn)

RMSE_knn <- round(sqrt(mean(error_knn^2)),2)
RMSE_knn

plot(test$selling_price,pred_knn, main="Scatterplot", col = c("blue","red"), xlab = "Actual Selling Price", ylab = "Predicted Selling Price")


#SVM

svm = svm(selling_price~.,data = train)
svm

pred_svm <- predict(svm, newdata = test)
error_svm <- test$selling_price - pred_svm

eval_svm <- cbind(test$selling_price, pred_svm)
colnames(eval_svm) <- c("True Price", "Predicted Price")
eval_svm <- as.data.frame(eval_svm)
head(eval_svm)

RMSE_svm <- round(sqrt(mean(error_svm^2)),2)
RMSE_svm

plot(test$selling_price,pred_svm, main="Scatterplot", col = c("blue","red"), xlab = "Actual Selling Price", ylab = "Predicted Selling Price")


#gradient boost
set.seed(123)

gbm <- gbm(
  formula = selling_price ~ .,
  distribution = "gaussian",
  data = train,
  n.trees = 6000,
  interaction.depth = 3,
  shrinkage = 0.1,
  cv.folds = 5,
  n.cores = NULL, # will use all cores by default
  verbose = FALSE
)  


gbm

pred_gbm <- predict(gbm, test)
error_gbm <- test$selling_price - pred_gbm
RMSE_gbm <- round(sqrt(mean(error_gbm^2)),2)
RMSE_gbm

eval_gbm <- cbind(test$selling_price, pred_gbm)
colnames(eval_gbm) <- c("True Price", "Predicted Price")
eval_gbm <- as.data.frame(eval_gbm)
head(eval_gbm)

plot(test$selling_price,pred_gbm, main="Scatterplot", col = c("blue","red"), xlab = "Actual Selling Price", ylab = "Predicted Selling Price")


Model <- c('Linear Regression','Random Forest','Gradient Boosting', 'K-Nearest Neighbour', "Support Vector Machine")
RMSE <- c(RMSE_lr,RMSE_rf,RMSE_gbm,RMSE_knn,RMSE_svm)
res <- data.frame(Model,RMSE)
res %>% arrange(RMSE,descending =TRUE)

ggplot(data = res, aes(x= Model, y = RMSE, fill = Model)) + geom_bar(stat="identity") + theme(axis.text.x = element_blank(), axis.ticks = element_blank())

summary(
  gbm, 
  cBars = 10,
  method = relative.influence, las = 2
)

trainControl <- trainControl(method = "cv",
                             number = 10,
                             returnResamp="all", ### use "all" to return all cross-validated metrics
                             search = "grid")

tuneGrid <- expand.grid(
  n.trees = c(5000, 10000),
  interaction.depth = c( 6, 13),
  shrinkage = c(0.01, 0.001),
  n.minobsinnode=c(5, 10)
)
gbm_hpt <- train(selling_price ~.,
                data = train,
                method = "gbm",
                tuneGrid = tuneGrid,
                trControl = trainControl,
                verbose=FALSE)

pred_gbm_hpt <- predict(gbm_hpt, test)
error_gbm_hpt <- test$selling_price - pred_gbm_hpt
RMSE_gbm_hpt <- round(sqrt(mean(error_gbm_hpt^2)),2)
RMSE_gbm_hpt


plot(test$selling_price,pred_gbm_hpt, main="Scatterplot", col = c("blue","red"), xlab = "Actual Selling Price", ylab = "Predicted Selling Price")

