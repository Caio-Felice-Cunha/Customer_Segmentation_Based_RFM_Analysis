# Customer Segmentation Based on RFM Analysis (Recency, Frequency and Monetary Value)


# Setting the working directory
setwd("C:/Users/Caio/OneDrive/Desktop PC/Desktop/Portfolio/R/Customer Segmentation Based on RFM Analysis")
getwd()

# Imports
library(tidyverse)
library(dplyr)
library(ggplot2)
library(caret)
library(plotly)
library(readxl)
library(rfm)
library(stats)
library(factoextra)

# Function to load data from Excel spreadsheet
load_data <- function()
{
  setwd("C:/Users/Caio/OneDrive/Desktop PC/Desktop/Portfolio/R/Customer Segmentation Based on RFM Analysis")
  sheet1 <- read_excel('online_retail.xlsx', sheet = 'Year 2009-2010')
  sheet2 <- read_excel('online_retail.xlsx', sheet = 'Year 2010-2011')
  combined_data <- rbind(sheet1, sheet2)
  return(combined_data)
}

# Run the function
data <- load_data()
dim(data)
View(data)

# check for missing values
colSums(is.na(data))

# Let's just delete the records with missing values

# Clean and pre-process the data

# Creating a column called TotalPrice
data$TotalPrice <- data$Quantity * data$Price

# Remove records with missing values
data <- na.omit(data)

# We remove the lines from the Invoice column that contain the letter C (meaning that this order has been cancelled)
data <- data[!grepl("C",data$Invoice),]

colSums(is.na(data))
  
View(data)


# Checking the distribution of the Total Price variable
ggplot(data,
       aes(x = TotalPrice)) +
  geom_density(fill = "#69b3a2", color = "#e9ecef", alpha = 3.5) +
  labs(title = 'TotalPrice Variable Distribution')

# number of customers
length(data$`Customer ID`)
length(unique(data$`Customer ID`))


# Total money spent per customer
total_spent <- data %>%
  group_by(`Customer ID`) %>%
  summarise(Sum = sum(TotalPrice))

View(total_spent)

# Creating a custom date (Christmas 2011)
View(data)
max(data$InvoiceDate)
date1 = as.Date.character("25/12/2011","%d/%m/%Y")

# Convert dates from POISxt format to Date format
options(digits.secs = 3)
as.Date(as.POSIXct(data$InvoiceDate, 'GMT'))



# Function to calculate Recency, Frequency and Monetary Value

rfm_formula <- function(x){
  z <- x %>% 
    group_by(`Customer ID`) %>% 
     summarise(Recency = as.numeric(date1 - max(InvoiceDate)), 
               Frequency = n(), 
               Monetary = sum(TotalPrice),
               first_purchase = min(InvoiceDate))
  

  # Removing transactions with values above the 3rd Quartile and below the 1st Quartile (removing outliers)
  Q1 <- quantile(z$Monetary, .25)
  Q3 <- quantile(z$Monetary, .75)

  IQR <- IQR(z$Monetary)
  z <- subset(
    z, 
    z$Monetary >= (Q1 - 1.5*IQR) 
    & z$Monetary <= (Q3 + 1.5*IQR))
  return(z)
}

# Run the function
rfm_values <- rfm_formula(data)
View(rfm_values)


# Machine Learning - Kmeans Clustering



# Function for segmenting customers based on RFM values
segment_customer <- function(rfm)
{
  # Create a list
  results <- list()
  
  # Get the RFM values
  data_rfm <- select(rfm, c('Recency','Frequency','Monetary'))
  
  # Create the model
  kmeans_model <- kmeans(data_rfm, center = 5, iter.max = 50)
  
  # model plot
  results$plot <- fviz_cluster(kmeans_model, 
                                  data = data_rfm, 
                                  geom = c('point'), 
                                  ellipse.type = 'euclid')
  
  # Sort the data
  data_rfm$`Customer ID` <- rfm$`Customer ID`
  data_rfm$clusters <- kmeans_model$cluster
  results$data <- data_rfm
  
  return(results)
}

# Run the function
graphic <- segment_customer(rfm_values)[1]
graphic

rfm_table <- segment_customer(rfm_values)[2]
View(as.data.frame(rfm_table))