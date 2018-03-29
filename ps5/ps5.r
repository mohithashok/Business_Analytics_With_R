###############################################################
# Title:        ps5.r
# Author:       Mohith Ashok
# Date:         5th Dec 2017
# Description:  Deliverable for Problem set 5
###############################################################

rm(list=ls(all=TRUE))

## Import packages
library(data.table)
library(lmtest)
library(sandwich)
library(tseries)

## Question 1

context1  <- fread('WAGE1.csv')

seed        <-	2	
maxClusters	<-	10 

wss	<- rep(-1,maxClusters)
for (i in 1:maxClusters) {
  set.seed(seed)
  model <- kmeans(context1,centers=i,nstart=10)
  wss[i] <- model$tot.withinss
}

plot(1:maxClusters,	wss, type="b", 
     xlab="Number of Clusters",
     ylab="Aggregate Within Group SS")

set.seed(seed)

# Model with k =3 and initial starts = 10
model1 <- kmeans(context1,centers=3,nstart=10)

# Means from model1
model1$centers

# Creating groups
groups1 <- model1$cluster
context1$groups1 <- groups1

# Creating models for cluster 1, 2 and 3 respectively
model2 <- lm(wage ~ educ + exper + tenure, data = subset(context1,groups1 == 1))
model3 <- lm(wage ~ educ + exper + tenure, data = subset(context1,groups1 == 2))
model4 <- lm(wage ~ educ + exper + tenure, data = subset(context1,groups1 == 3))

summary(model2)
summary(model3)
summary(model4)

## Interpretations for Question 1
# (a) The elbow seems to fall on 4 and hence the optimal number of clusters is 3.
# (b) According to model1, cluster-1 has a very high average experience compared to the other two clusters, followed by cluster-2
#     and cluster-1 has the least average experience. The same follows for tenure as well. Education on the other hand is 
#     somewhat similar in cluster-2 and cluster-3 but slighly lower in cluster-1. Although cluster-2 has a high average education,
#     the wage might be low because of low average experience.
# (c) Firstly, experience is significant only in model3 (at 1%) and model4 (at 5%). Additionally, experience is negatively correlated
#     in model2 and positively correlated in the other two models.



## Question 2

context2 <- read.csv("ffportfolios.csv")

for(i in 2:33) {
  kpss.test(as.matrix(context2)[,i],null="Level")
}
warnings()

Xdata <- context2[2:ncol(context2)]
model5 <- prcomp(Xdata)
screeplot(model5,type="lines")
factors <- model5$x[,1]

head(factors)
summary(factors)
var(factors)

context2$factor <- factors
context2$factor <- scale(context2$factor)
var(context2$factor)

ts.plot(context2$factor)

years<- subset(context2,factor < -2.58)
years$Year


## Interpretations for Question 2
# (a) Based on scree plot, we should use two principal components.
# (b) The principal component 'factor', accounts for the variation across portfolios. A high-negative value indicates that all the
#     portfolios have highly-negative returns. Secondly, a highly-positive value indicates that all the portfolios have
#     highly-positive returns.Lastly, huge variation in the portfolio returns lead to a very low factor value.














