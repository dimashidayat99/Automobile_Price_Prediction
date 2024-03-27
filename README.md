# Automotive Price Forecasting and Prediction System

<p align="middle">
<img src="https://github.com/dimashidayat99/Automobile_Price_Prediction/assets/69446089/64719268-37d4-48a4-a6ad-f76015a38a7a"  width="800" />
</p>

# Project Background
At present, the amount of transfers held by the industry is increasing year by year. Thus, transfers play an important role in the development of automobiles. In developed countries, automobiles are referred to as an “industrial industry”. According to industry experts, the automotive industry is growing significantly. Apart from being the fastest growing country in the automotive industry, it also represents a global presence, as in most other countries, cars have become very popular among residents and expatriates working in the country.

Today, almost everyone wants to own their car, but due to factors such as affordability or financial situation, many people opt for used cars. Accurately predicting used car prices requires expertise, as they depend on many factors and characteristics. Used car prices in the market are not stable and both buyers and sellers need an intelligent system that allows them to effectively predict the price. In this project, used car price prediction was conducted on used car-related data. The data obtained from [Kaggle](https://www.kaggle.com/datasets/nehalbirla/vehicle-dataset-from-cardekho?datasetId=33080&sortBy=voteCount&language=R&select=Car+details+v3.csv)

# Project Questions

To predict used car prices, there are several questions can be asked which are:

* What are the algorithms used and which algorithm performed the best in predicting used car selling price? 

* Which variables influence the used car selling price?

In this regard, machine learning algorithms are required to predict the selling price of cars based on available variables.

# Project Objectives
Buying a used car from a dealership can be a frustrating and unsatisfying experience, as some dealers have been known to use deceptive sales tactics to close the deal. The project aims to :

* To build machine learning algorithms that can be implemented into a used car recommendation system in predicting used car selling prices.

* To identify what variables influence the used car selling price.

Considering this is an interesting research topic for the research community, and by continuing their steps, and hope to achieve important results using more advanced methods from previous work.

# EDA
## Top 10 most expensive cars
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/expensive_car.png)

The most expensive car model is the Volvo XC90 T8 Excellence BSIV, sold at 10,000,000. The second highest expensive car model is the BMW X7 xDrive 30d DPE sold at 72,000,000. The third rank of expensive car brands is Audi A6 35 TFSI Matrix which was sold at 6,523,000.

## Top 10 most cheapest cars
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/cheap_car.png)

The cheapest car model is the Hyundai Santro LE, sold at 35,000. The second lowest car model sold is the Tata Indica DLX sold at 40,000. The third and fourth rank share the same value of the cheapest car models sold at 45,000 which are Tata Nano LX SE and Maruti 800 DXBSII.

## Distribution cars sold per year
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/selling_price_over_year.png)

From the data distributions of the used cars sold over the past few years from 1996 to 2020, there is an increment of the car units sold. In 2012, there was a slight reduction in the number of counts, and rose back up till 2017 when it reached its peak at 434 units sold. Then, the number of used cars sold decreases till 2020.

## Selling price against car manufactured
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/selling_price_car_manufactured.png)

From the relationship of data distributions of sold car selling prices over the year, the graph shows that there is an incremental density in value. As the year in time increases, the selling price values increase.

## Selling price against km driven
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/selling_price_km_driven.png)

From the relationship of data distributions of sold car selling price over the km driven, the graph shows that there is a decrease in density in value. As the year in km driven increases, the selling price values decrease.

# Modelling
Split the data into 80% training set and 20% testing set. 5 regression algorithms will be used for modeling and all of them will be evaluated and compared to find the best model. The evaluation metric will use the RMSE score for evaluation. The comparison of each model will be discussed in the evaluation & conclusion section.

## Linear Regression
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/lr.png)

The RMSE value for Linear Regression is 463310.36 which is quite high. In the scatter plot, the blue point represents the true value while the red point represents the predicted value and the black line is a regressed diagonal line which is a benchmark where points that are closer to the line indicate the better performance of the model. In the Linear Regression model, the points of both values are dispersed away from the diagonal line which indicates that the model performance is low. In addition, some of the predicted value lies in the negative and zero values, it is impossible to have a zero or negative value of the selling price. There, it can be concluded that the performance of the Linear regression model is worse.

## Random Forest Regression
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/rf.png)

The RMSE value for the Random Forest model is 132959.53 which is very low compared to the Linear Regression model. Based on the scatter plot, all the points are reasonably close to the regressed diagonal line with only a few points far from the regressed diagonal line which indicates the good performance of the model. Based on the RMSE value and scatter plot, the Random Forest has good performance.
## K-Nearest Neighbor
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/knn.png)

The RMSE value for the KNN model is 254246.6 which is significantly high compared to the Random Forest model. Based on the scatter plot, all the points are reasonably close to the regressed diagonal line with just a few points that are far from the regressed diagonal line which indicates the notable performance of the model. However, based on RMSE and the overall fit of the point, the performance of the Random Forest model is still far better than the KNN model.
## Support Vector Machine
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/svm.png)

The RMSE value for the SVM model is 216376.51 which is almost the same as the KNN model. Based on the scatter plot, all the points are reasonably close to the regressed diagonal line with just a few points that are far from the regressed diagonal line which indicates the notable performance of the model. However, based on RMSE and the overall fit of the point, the performance of the Random Forest model is still far better than the SVM model. 

## Gradient Boost
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/gb.png)

The RMSE value for the Gradient Boost model is 121155.04 which is relatively low and almost similar to the Random Forest model. Based on the scatter plot, all the points are reasonably close to the regressed diagonal line with almost negligible points that far from the regressed diagonal line which indicates the outstanding performance of the model. Based on the RMSE and overall fit of the point, the Gradient Boost model has a better performance compared to the Random Forest model with a small difference between RMSE scores.

# Evaluation
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/rmse.png)

The Gradient Boost model has the lowest RMSE score which is 121155.04 with only a small difference from the Random Forest model. Therefore, the Gradient Boost model is the best model among the other models while the Linear Regression model has the highest RMSE score which is 463310.36 which indicates the worst model among the other models.

Using the Gradient Boosting model, the features importance can be calculated to find which features or variables have a greater influence on the price prediction.

# Features Importance
![](https://github.com/dimashidayat99/Automobile_Price_Prediction/blob/main/result/feature_importance.png)

From the features importance, the max_power variable is the biggest influence with 60% of relative influence in predicting selling price based on this dataset and the Gradient Boost model. The features importance rank from highest to lowest is max_power, year, torque, km_driven, name, engine, mileage, transmission, seller_type, and owner.

The Gradient Boost model and Random Forest model have less significant differences in RMSE value. Both models can be approved to be the best model, but the selection of project this project does not fully utilize machine learning capabilities such as hyperparameter tuning. The hyperparameter tuning can not be utilized due to technical limitations.

# Deployment

The result of descriptive and predictive analysis will be integrated into the shiny application. The deployment will be in the form of a dashboard using Shiny based on the selected machine learning algorithm (best model) for the car prediction system. [Link](https://dimashidayat.shinyapps.io/AutomobilePrice_Prediction/) for the Shiny application.

# More About Project

Please have a look at [RPubs](https://rpubs.com/dimas123/994155) to read and understand the whole project.
