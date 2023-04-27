# Customer Segmentation Based RFM Analysis
Machine Learning in R using K means for RFM Analysis<br>

![Clueter Plot](https://user-images.githubusercontent.com/111542025/234997192-48b627e7-997b-4fc9-9eb7-fabad495ccd5.png)

## This is the 1st version

## Business Problem
> Data source: the data was extracted from the [isc uci - 
Online Retail II Data Set](https://archive.ics.uci.edu/ml/datasets/Online+Retail+II)<br>

RFM stands for Recency, Frequency and Monetary Value and entails analyzing transactional data and identifying different customer segments based on their conversion history.<br>

RFM Analysis is a marketing strategy for analyzing and estimating a customer's value, based on three variables: Recency (How often did the customer make a purchase?), Frequency (How often do they buy), and Monetary Value (How much do they spend?) in order to predict which customers are most likely to make new purchases in the future.<br>

The RFM model is based on three quantitative factors:
* Recency: How recently a customer made a purchase. Generally speaking, recency indicates how long ago your customer took a desired action (most often a purchase).

* Frequency: How often a customer makes a purchase. Frequency indicates how many times the customer repeated that action in a given time period.

* Monetary Value: how much money a customer spends on purchases. Monetary value indicates what that customer is worth to a company's business.
<br>
RFM Analysis numerically ranks a customer in each of these three categories, usually on a scale of 1 to 5 (the higher the number, the better the result). The “best” customer will receive a maximum score in all categories.<br>

According to these metrics, it is possible to segment customers into groups to understand which of them buy a lot of things frequently, who buy few things, but often, and who have not bought anything for a long time. This is exactly what we will do here. First we will calculate the RFM score and then use this data to do the segmentation using Machine Learning with unsupervised learning.

## Solution Strategy
For our purpose, we will use the Machine Learning K means model.
* Step 01: Loading the Data and Data Understandment;
* Step 02: Cleaning and missing values;
* Step 03: Correctly preparing the dataset and its variables to be able to apply them to the machine learning model (Data Wrangling);
* Step 04: RFM Formula;
* Step 05: K means Clustering.


## Conclusion
The image seen at the beginning of this file is the conclusion we reached

## Next Steps
* Improve hyperparameters and data classification.






## Disclaimer 
A good part of this project was largely done in the Data Science Academy, Big Data Analytics with R and Microsoft Azure Machine Learning course (part of the Data Scientist training)
