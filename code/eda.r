
#Use library
library(magrittr) 
library(dplyr) 
library(ggplot2)
library(data.table)
library(tidyverse)
library(tidyr) 
library(tidyselect)
library(plotly)
library(reactable)
library(htmlwidgets)
library('IRdisplay')
library("scales")

#Import and view cleaned dataset
cardata <- read.csv('car_project.csv')

#View(cardata)

#overview of data
dim (cardata)
#The car data have 8128 observation of 13 variables.

#Look at the top rows of the car data
colnames(cardata)

#summarize the dataset
summary(cardata)

#structure of data
str(cardata)

#names of car
names(cardata)

# Function to plot width and height of plot
fig<-function(x,y){
  options(repr.plot.width = x, repr.plot.height = y)
}

#What are the top 10 most expensive cars?
expensive_cars <- cardata %>% group_by(name) %>% summarise(selling_price=max(selling_price))#%>%top_n(10)

head(expensive_cars)
print(expensive_cars)

expensive_cars <- expensive_cars[order(-expensive_cars$selling_price),]#%>%top_n(10)


typeof(expensive_cars$selling_price)
options(scipen = 999)
ggplot(data = expensive_cars, aes(y=name, x=selling_price, fill=selling_price))+
  geom_bar(stat="identity", width = 0.5, fill="#E14D2A",color = 'black')+
  geom_text(aes(label=selling_price), vjust=1.7, color="black", size=3.0)+
  scale_x_continuous(labels = comma)+
  labs(x="Car brand",
       y="Car Price", 
       title="Top 10 most expensive cars")+ 
  theme_bw()+
  theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10),
        axis.text.y= element_text(size=10), axis.title=element_text(size=10))

#What are the top 10 most cheapest cars?
cheapest_cars <- filter(cardata %>% group_by(name) %>% summarise(selling_price=max(selling_price)) %>% arrange(desc(selling_price)))


ggplot(data = tail(cheapest_cars,10), aes(y=name, x=selling_price, fill=selling_price))+
  geom_bar(stat="identity", width = 0.5, fill="#001253",color = 'white')+
  geom_text(aes(label=selling_price), vjust=1.9, color="black", size=3.0)+
  scale_x_continuous(labels = comma)+
  labs(x="Car brand",
       y="Car Price", 
       title="Top 10 most cheapest car model")+ 
  theme_bw()+
  theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10),
        axis.text.y= element_text(size=10), axis.title=element_text(size=10))

#What are the number of cars sold per year?
sold_per_year<- cardata %>% group_by(name, year)%>%summarise(Count=length(name))
sold_per_year

sold_per_year <- filter(sold_per_year, year>2000 & year<2018)


ggplot(sold_per_year, aes(year))+
  geom_line(stat="count", width = 0.7,color = 'black')+  # Stack for stacked chart
  labs(x="Year",
       y="Count", 
       title="Distribution of cars sold per year")+ 
  theme_bw()+
  theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10,angle=90),
        axis.text.y= element_text(size=10), axis.title=element_text(size=10))

#What is split distribution count of fuel types based on the car data?

fuel_type<- cardata %>% group_by(fuel) %>% summarise(Count=length(fuel)) %>% plot_ly(x=~fuel, y=~Count, color = ~fuel, colors = c("#764AF1","#F2F2F2"), type='bar')%>%layout(title="Distribution of fuel types on used car model", xaxis=list(title="Fuel type"))

fuel_type

#What is split distribution count of seller type based on the car data?

seller<- cardata %>% group_by(seller_type) %>% summarise(Count=length(seller_type)) %>% plot_ly(x=~seller_type, y=~Count, color = ~seller_type, colors = c("#00FFFF","#F2F2F2"), type='bar')%>%layout(title="Distribution of fuel types on used car model", xaxis=list(title="Seller type"))

seller

#What is split distribution count of transmission type?

transmission <- cardata %>% group_by(transmission) %>% summarise(Count=length(transmission)) %>% plot_ly(x=~transmission, y=~Count, color = ~transmission, colors = c("#00FF00","#F2F2F2"), type='bar')%>%layout(title="Distribution of used car model's transmission type", xaxis=list(title="transmission type"))

transmission


sold_per_year<- car %>% group_by(name, year)%>%summarise(Count=length(name))

sold_per_year

ggplot(sold_per_year, aes(year))+
  geom_line(stat="count", width = 0.7,color = 'black')+  # Stack for stacked chart
  labs(x="Year",
       y="Count", 
       title="Distribution of cars sold per year")+ 
  theme_bw()+
  theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10,angle=90),
        axis.text.y= element_text(size=10), axis.title=element_text(size=10))

#Relationship between Selling Price and Car Manufactured

ggplot(data = cardata, aes(x=year, y=selling_price, fill=selling_price)) + 
  geom_point()+
  labs(y="Selling Price",
       x="Year", 
       title="Relationship between Selling Price and Car Manufactured")+  
  theme_bw()+
  theme(plot.title = element_text(size=15)
        ,axis.text.x= element_text(size=10),
        axis.text.y= element_text(size=10),
        axis.title=element_text(size=10))



#Relationship between Selling Price and KM driven
ggplot(data = cardata, aes(x=km_driven, y=selling_price)) + 
  geom_line()+#geom_bar(stat = 'identity')+
  labs(y="Selling Price",
       x="KM driven", 
       title="Relationship between",x,"and",y)+  
  theme_bw()+
  theme(plot.title = element_text(size=15)
        ,axis.text.x= element_text(size=10),
        axis.text.y= element_text(size=10),
        axis.title=element_text(size=10))

title <- paste("Relationhip between", x, "and", y)
ggplot(data = cardata, aes(x=selling_price, y=owner)) + 
  geom_boxplot()+
  labs(title=title)
