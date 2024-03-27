# Automotive Price Forecasting and Prediction System

![](https://github.com/dimashidayat99/Automobile_Price_Prediction/assets/69446089/64719268-37d4-48a4-a6ad-f76015a38a7a)

# Project Background
At present, the amount of transfers held by the industry is increasing year by year. Thus, transfers play an important role in the development of automobiles. In developed countries, automobiles are referred to as an “industrial industry”. According to industry experts, the automotive industry is growing significantly. Apart from being the fastest growing country in the automotive industry, it also represents a global presence,as in most other countries, cars have become very popular among local residents and expatriates working in the country.

Today, almost everyone wants to own their own car, but due to factors such as affordability or financial situation, many people opt for used cars. Accurately predicting used car prices requires expertise, as they depend on many factors and characteristics. Used car prices in the market are not stable and both buyers and sellers need an intelligent system that allows them to effectively predict the price. In this project,used car price prediction was conducted on used car-related data. The data obtained from [Kaggle](https://www.kaggle.com/datasets/nehalbirla/vehicle-dataset-from-cardekho?datasetId=33080&sortBy=voteCount&language=R&select=Car+details+v3.csv)

# Project Questions

In order to predict used car price, there are several question can be ask which are:

* What are the algorithms is used and which algortihm performed the best in predicting used car selling price. 

* Which variables influence the used car selling price?

In this regard, machine learning algorithms is required in predicting the selling price of cars based on available variables.

# Project Objectives
Buying a used car from a dealership can be a frustrating and unsatisfying experience, as some dealers have been known to use deceptive sales tactics to close the deal. The project aims to :

* To build machine learning algorithms which can be implementing into used car recommendation system in predicting used car selling price.

* To identify what variables influence the used car selling price.

Considering this is an interesting research topic for the research community, and by continuing their steps and hope to achieve important results using more advanced methods from previous work.

# EDA
## Top 10 most expensive cars
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/expensive_car.png)

The most expensive car model is Volvo XC90 T8 Excellence BSIV, sold at 10,000,000. The second highest expensive car model is BMW X7 xDrive 30d DPE sold at 72,000,000. The third rank of expensive car brands is Audi A6 35 TFSI Matrix which was sold at 6,523,000.

## Top 10 most cheapest cars
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/cheap_car.png)

The most cheapest car model is Hyundai Santro LE, sold at 35,000. The second lowest car model sold is Tata Indica DLX sold at 40,000. The third and fourth rank share the same value of the cheapest car models sold at 45,000 which are Tata Nano LX SE and Maruti 800 DXBSII.

## Distribution car sold per year
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/selling_price_over_year.png)

From the data distributions of the used cars sold over past few years from 1996 to 2020, there is an increment of the car units sold. In 2012, there was a slight reduction in the number of counts and rose back up till 2017 where it reached its peak at 434 units sold. Then, the number of used cars sold decreases till 2020.

## Selling price against car manufactured
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/selling_price_car_manufactured.png)

From the relationship of data distributions of sold car selling price over the year, the graph shows that there is an incremental density in value. As the year in time increases, the selling price values increase.

## Selling price against km driven
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/selling_price_km_driven.png)

From the relationship of data distributions of sold car selling price over the km driven, the graph shows that there is an decrement density in value. As the year in km driven increases, the selling price values decrease.

# Modelling
Split the data into 80% training set and 20% testing set. 5 regression algorithms will be used for modelling and all of them will be evaluated and compared to find the best model. The evaluation metric will use RMSE score for evaluation. The comparison of each model will be discussed on the evaluation & conclusion section.

## Linear Regression
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/lr.png)

The RMSE value for Linear Regression is 463310.36 which are quite high. In the scatter plot the blue point represent true value while red point represent predicted value and the black line is regressed diagonal line which as benchmark where points that are closer to the line indicate the better performance of the model. In the Linear Regression model, the point of both values are dispersed away from the diagonal line which indicate that the model performance is low. In addition, some of the predicted value lies in the negative and zero value, it is impossible to have zero or negative value of selling price. There, it can be conclude that the performance of Linear regression model is worse.

## Random Forest Regression
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/rf.png)

The RMSE value for Random Forest model is 132959.53 which is very low compared to the Linear Regression model. Based on the scatter plot, all the point are reasonably close to the regressed diagonal line with only a few point is far from the regressed diagonal line which indicate the good performance of model. Based on the RMSE value and scatter plot, the Random Forest have good performance.
## K-Nearest Neighbor
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/knn.png)

The RMSE value for KNN model is 254246.6 which is significantly high compared to the Random Forest model. Based on the scatter plot, all the point are reasonably close to the regressed diagonal line with just a some point that are far from the regressed diagonal line which indicate the notable performance of model. However, based on RMSE and overall fit of the point, the performance of Random Forest model is still far better than KNN model.
## Support Vector Machine
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/svm.png)

The RMSE value for SVM model is 216376.51 which is almost the same as KNN model. Based on the scatter plot, all the point are reasonably close to the regressed diagonal line with just a some point that are far from the regressed diagonal line which indicate the notable performance of model. However, based on RMSE and overall fit of the point, the performance of Random Forest model is still far better than SVM model. 

## Gradient Boost
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/gb.png)

The RMSE value for Gradient Boost model is 121155.04 which is relatively low and almost similar with the Random Forest model. Based on the scatter plot, all the point are reasonably close to the regressed diagonal line with almost negligible points that far from regressed diagonal line which indicate the outstanding performance of model. Based on the RMSE and overall fit of the point, the Gradient Boost model have better performance compared to Random Forest model with small difference between RMSE score.

# Evaluation
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/rmse.png)

Gradient Boost model have the lowest RMSE score which is 121155.04 with only small difference with Random Forest model. Therefore, Gradient Boost model the best model among the other model while Linear Regression model have the highest RMSE score which is 463310.36 which indicate the worse model among the other model.

Using Gradient Boosting model, the features importance can be calculated to find which features or variables have greater influence in the price prediction.

# Features Importance
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/feature_importance.png)

From the features importance, the max_power variable is the biggest infrequence which 60% of relative influence in the predicting selling price based on this dataset and Gradient Boost model. The features importance rank from highest to lowest is max_power, year, torque, km_driven, name, engine, mileage, transmission, seller_type and owner.

Gradient Boost model and Random Forest model have less significant difference in RMSE value. Both model can be approved to be the best model, the selection of project this project are not fully utilizing the machine learning capabilities such as hyperparameter tuning. The hyperparameter tuning can not be utilized due to technical limitation.

# Deployment

The result of descriptive and predictive analysis will be integrated into the shiny application. The deployment will be in the form of dashboard by using shiny based on the selected machine learning algorithm (best model) to car prediction system. [Link](https://dimashidayat.shinyapps.io/AutomobilePrice_Prediction/) for shinny application.

# More About Project

Plase have a look to [RPubs](https://rpubs.com/dimas123/994155) to read and understanding whole project.
