library(shiny)
library(shinyWidgets)
library(scales)
library(grid)
library(gridExtra)
library(shinydashboard)
library(rsconnect)
library(textyle)


# Source in model file
source('model.R')
source('eda.r')

saveRDS(final, "pricemodel.rds")

priceModel <- readRDS("pricemodel.rds")
shiny_df <- bind_rows(predictions_train, predictions_train)

priceModel

years <- unique(sold_per_year$year)
years

colnames(cardata)

plottype <- c("bar", "line", "box")

plottype
sort(years)
ui <- dashboardPage(
  dashboardHeader(title = "Automobile Price"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("magnifying-glass-chart", lib = "font-awesome")),
      menuItem("Prediction Tools", tabName = "tools", icon = icon("gear", lib = "font-awesome"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              h1("Desriptive Analysis of Automobile Price"),
              fluidRow(
                box(title = "Cars sold across year", width = 6, height = 300, solidHeader = TRUE, plotOutput("plot3", height = 250)),
                box(title = "Number of car sold in a year", width = 6, height = 300, solidHeader = TRUE, plotOutput("plot4", height = 250))
              ),
              fluidRow(
                box(title = "Select years: ",height = 300,  sliderInput("slider3", "Years:", min(years), max(years),c(min(years), max(years)))),
                box(title = "Select a year ",height = 300,  selectInput("slider4", "years:", choices= sort(years)))
              ),
              fluidRow(
                box(title = "Most expensive cars", width = 6, height = 300, solidHeader = TRUE, plotOutput("plot1", height = 250)),
                box(title = "Most cheapest cars", width = 6, height = 300, solidHeader = TRUE, plotOutput("plot2", height = 250))
              ),
              fluidRow(
                box(title = "Select number of top cars: ",height = 300,  sliderInput("slider1", "Number of expensive cars:", 3, 10, 5), selectInput("carname1", "select car model:", choices= sort(c(unique(shiny_df$name), "All")))),
                box(title = "Select number of top cars: ",  height = 300, sliderInput("slider2", "Number of cheapest cars:", 3, 10, 5), selectInput("carname2", "select car model:", choices= sort(c(unique(shiny_df$name), "All"))))
              ),
              fluidRow(
                box(title = "Exploration between two variables", width = 12, height = 300, solidHeader = TRUE, plotOutput("plot5", height = 250))
                
              ),
              fluidRow(
                box(title = "Select variables:",  width = 12, height = 300, selectInput("select1", "Variable X:", choices = colnames(cardata)), selectInput("select2", "Variable Y:", choices= colnames(cardata), "All"), selectInput("select3", "Type of plot:", choices = plottype)))
              ),
      
      tabItem(tabName = "tools",
              h1("Predictive Analysis of Automobile Price"),
              fluidRow(
                box(title = "Select car name", width = 3, height = 150, solidHeader = TRUE, selectInput("carname", "name of car", choices= sort(unique(shiny_df$name)))),
                box(title = "Select year", width = 3, height = 150, solidHeader = TRUE, numericInput("caryear", "year", 2011)),
                box(title = "Select number of kilometer", width = 3, height = 150, solidHeader = TRUE, numericInput("carkm", "Number of kilometer driven", 100000)),
                box(title = "Select fuel type", width = 3, height = 150, solidHeader = TRUE, selectInput("carfuel", "Type of fuel", choices= sort(unique(shiny_df$fuel))))
              ),
              fluidRow(
                box(title = "Select seller type", width = 3, height = 150, solidHeader = TRUE, selectInput("carseller", "Seller type", choices= sort(unique(shiny_df$seller_type)))),
                box(title = "Select car transmission", width = 3, height = 150, solidHeader = TRUE, selectInput("cartransmission", "Type of transmission", choices= sort(unique(shiny_df$transmission)))),
                box(title = "Select number of previous owner", width = 3, height = 150, solidHeader = TRUE, selectInput("carowner", "Number of previous owner", choices= sort(unique(shiny_df$owner)))),
                box(title = "Select number of mileage", width = 3, height = 150, solidHeader = TRUE, numericInput("carmileage", "Mileage of the car",21))
              ),
              fluidRow(
                box(title = "Select engine capacity", width = 3, height = 150, solidHeader = TRUE, numericInput("carengine", "Engine capacity of the car",1400)),
                box(title = "Select maximum engine power", width = 3, height = 150, solidHeader = TRUE, numericInput("carmaxpower", "Max power of the engine",80)),
                box(title = "Select engine tourque", width = 3, height = 150, solidHeader = TRUE, numericInput("cartourque", "Tourque of the engine",200)),
                box(title = "Select number of seat", width = 3, height = 150, solidHeader = TRUE, selectInput("carseat", "Number of seat", choices= sort(unique(shiny_df$seats))))
              ),
              fluidRow(
                box(align = "center", status = "info", title = "The vehicle price prediction", width =12, height =500, 
                    actionButton("submitbutton", "Submit", class = "btn btn-primary"), br(), br(),
                    textOutput('text'), br(),#,
                    tags$head(tags$style("#text{color: black;
                                 font-size: 20px;
                                 font-style: italic;
                                 font-weight: bold;
                                 }"
                    )),
                    imageOutput('image', width = 210, height = 250)))
              #fluidRow(
               # box(width = 6, height = 300, actionButton("submitbutton", "Submit", class = "btn btn-primary")),
                #box(width = 6, height = 300, textyle(tags$p("TEXTYLE", style = "font-size:7rem;font-weight:900;")),textOutput("text")))
              )
            )
          )
  )
        
      

server <- function(input, output, session) {
  #set.seed(122)
  
  output$plot1 <- renderPlot({
    
    expensive_cars <- cardata %>% group_by(name) %>% summarise(selling_price=max(selling_price))#%>%top_n(input$slider1)
    expensive_cars <- expensive_cars[order(-expensive_cars$selling_price),]#%>%top_n(10)
    
    if (input$carname1 == "All"){
      selectdata <- grepl("", expensive_cars$name)
  
    } else {
      selectdata <- grepl(input$carname1, expensive_cars$name)
    }
    
    expensive_cars <- expensive_cars[selectdata,]%>%top_n(input$slider1)
    #head(expensive_cars)
    #print(expensive_cars)
    
    title <- paste("Top", input$slider1, "most expensive cars")
    options(scipen = 999)
    ggplot(data = expensive_cars, aes(y=name, x=selling_price, fill=selling_price))+
      geom_bar(stat="identity", width = 0.5, fill="#001253",color = 'black')+
      geom_text(aes(label=selling_price), vjust=1.9, color="black", size=3.0)+
      scale_x_continuous(labels = comma)+
      labs(x="Car Price",
           y="Car Brand", 
           title=title)+ 
      theme_bw()+
      theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10),
            axis.text.y= element_text(size=10), axis.title=element_text(size=10))

  })
  
  output$plot2 <- renderPlot({
    

    cheapest_cars <- filter(cardata %>% group_by(name) %>% summarise(selling_price=max(selling_price)) %>% arrange(desc(selling_price)))
    
    if (input$carname2 == "All"){
      selectdata <- grepl("", cheapest_cars$name)
      
    } else {
      selectdata <- grepl(input$carname2, cheapest_cars$name)
    }
    
    cheapest_cars <- cheapest_cars[selectdata,]
    #head(expensive_cars)
    #print(expensive_cars)
    title <- paste("Top", input$slider2, "most cheapest cars")
    
    ggplot(data = tail(cheapest_cars,input$slider2), aes(y=name, x=selling_price, fill=selling_price))+
      geom_bar(stat="identity", width = 0.5, fill="#001253",color = 'black')+
      geom_text(aes(label=selling_price), vjust=1.9, color="black", size=3.0)+
      scale_x_continuous(labels = comma)+
      labs(x="Car brand",
           y="Car Price", 
           title=title)+ 
      theme_bw()+
      theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10),
            axis.text.y= element_text(size=10), axis.title=element_text(size=10))
    
  })
  
  my_range <- reactive({
    cbind(input$slider3[1],input$slider3[2])
  })
  
  output$plot3 <- renderPlot({
    
    
    sold_per_year<- cardata %>% group_by(name, year)%>%summarise(Count=length(name))
    
    
    sold_per_year <- filter(sold_per_year, year>my_range()[1] & year<my_range()[2])
    title<- paste("Distribution of cars sold from",input$slider3[1],"to",input$slider3[2])
    
    ggplot(sold_per_year, aes(year))+
      geom_line(stat="count", width = 0.7,color = 'blue')+  # Stack for stacked chart
      labs(x="Year",
           y="Count", 
           title=title)+ 
      theme_bw()+
      theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10,angle=90),
            axis.text.y= element_text(size=10), axis.title=element_text(size=10))
    
  })
  
  output$plot4 <- renderPlot({
    
    
    sold_per_year<- car %>% group_by(name, year)%>%summarise(Count=length(name))
    sold_per_year <- filter(sold_per_year, year==input$slider4)
    
    sold_per_year
    
    title <- paste("Number of cars sold in ", input$slider4)
    ggplot(data = sold_per_year, aes(y=Count, x=name))+
      geom_bar(stat="identity", width = 0.5, fill="#001253", color = "blue")+
      geom_text(aes(label=Count), vjust=1.7, color="black", size=3.0)+
      labs(x="Car brand",
           y="Count", 
           title=title)+ 
      theme_bw()+
      theme(plot.title = element_text(size=15),axis.text.x= element_text(size=10),
            axis.text.y= element_text(size=10), axis.title=element_text(size=10))
  })
  output$plot5 <- renderPlot({
    
    title <- paste("Relationhip between", input$select1, "and", input$select2)
    
    
    if (input$select3 == "bar"){
    
    ggplot(data = car, aes_string(x=input$select1, y=input$select2)) + 
      geom_bar(stat = 'identity',color = 'blue')+
      labs(title=title)
    } else if (input$select3 == "line"){
      
    ggplot(data = car, aes_string(x=input$select1, y=input$select2)) + 
      geom_line(colour = "blue")+
      labs(title=title)
    } else if (input$select3 == "box"){
      
      ggplot(data = car, aes_string(x=input$select1, y=input$select2)) + 
      geom_boxplot(colour = "blue")+
      labs(title=title)
    }
      
        
    
  })
  datasetInput <- reactive({
    
    
    test <- data.frame(
      name = c(input$carname),
      year = c(input$caryear),
      km_driven = c(input$carkm),
      fuel = c(input$carfuel),
      seller_type = c(input$carseller),
      transmission = c(input$cartransmission),
      owner = c(input$carowner),
      mileage = c(input$carmileage),
      engine = c(input$carengine),
      max_power = c(input$carmaxpower),
      torque = c(input$cartourque),
      seats = c(as.numeric(input$carseat)))
    
    priceModel <- readRDS("pricemodel.rds")
    
    Output <- predict(priceModel,test)
    Output <- paste("The price of car based on selected features: - USD ", round(Output), " -")
  
    paste(" ", Output, " ", sep="\n")
  })
  
  
  
  output$image <- 
    renderImage({
    if (input$submitbutton>0){
      
      img <- c("image1.png",
               "image2.png",
               "image3.png",
               "image4.png",
               "image5.png",
               "image6.png",
               "image7.png",
               "image8.png")
      
      
      img_ch <- sample(img, 1)
      
      
      list(src = file.path("images", img_ch),
           width = "100%",
           height = "100%")
      
    } else{
      list(src = file.path("images/28this.jpg"),
           width = "100%",
           height = "100%")
    }
      }, deleteFile = F)
  
  output$text <- renderText({
    if (input$submitbutton>0) { 
      #isolate("Calculation complete.")
      isolate(datasetInput())
    } else {
      return("Server is ready for calculation.")
    }
  })
}

shinyApp(ui, server)

              