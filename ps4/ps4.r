###############################################################
# Title:        ps4.r
# Author:       Mohith Ashok
# Date:         2017-11-26
# Description:  Deliverable for Problem set 4
###############################################################

rm(list=ls(all=TRUE))

## Import packages
library(data.table)
library(sandwich)
library(lmtest)
library(ggplot2)
library(mfx)
library(pscl)
library(party)
library(evtree)


## Question 1

context1  <- fread('htv.csv')

summary(context1)

lwage <- log(context1$wage)

model1 <- lm(lwage~abil+educ+exper, data=context1)

c(AIC(model1),BIC(model1))
#[1] 1935.995 1961.569

context1$abilsq <- context1$abil^2
context1$educsq <- context1$educ^2
context1$expersq <- context1$exper^2
context1$abileduc <- context1$abil*context1$educ
context1$educexper <- context1$educ*context1$exper
context1$abilexper <- context1$abil*context1$exper


# model2 <- lm(log(wage)~abil+educ+exper+abilsq+educsq+expersq+abileduc+abilexper+educexper,data=context1)
# summary(model2)
# c(AIC(model2),BIC(model2))
# model3 <- lm(log(wage)~abil+educ+exper+abilsq,data=context1)
# model4 <- lm(log(wage)~abil+educ+exper+educsq,data=context1)
# model5 <- lm(log(wage)~abil+educ+exper+expersq,data=context1) #low bic
# c(AIC(model3),AIC(model4),AIC(model5))
# c(BIC(model3),BIC(model4),BIC(model5))
# model6 <- lm(log(wage)~abil+educ+exper+abilsq+educsq+expersq,data=context1)
# c(AIC(model6),BIC(model6))

 
model2 <- lm(lwage~exper+abileduc+educexper,data=context1)
summary(model2)
c(AIC(model2),BIC(model2))
#[1] 1926.457 1952.031

## Interpretations for Question 1
# (a) Firstly, the BIC of model 2 (1952) is lower than the BIC of model 1 (1961). Additionally, there is an interaction between 
#     the independent variables in model2
# (b) The interaction variable is improving the accuracy of the model by incorporating the dependancy of the independent varibles
#     wih each other


## Question 2

context2 <- fread('loanapp.csv')

context2$whiteobrat <- context2$white*context2$obrat

model3 <- glm(approve~white,family=binomial(link="logit"),data=context2)
coeftest(model3,vcov.=vcovHC)

model4 <- glm(approve~white+hrat+obrat+loanprc+unem+male+married+dep+sch+cosign+chist+pubrec+mortlat1+mortlat2+vr,family=binomial(link="logit"),data=context2)
coeftest(model4,vcov.=vcovHC)

model5 <- glm(approve~white+hrat+obrat+loanprc+unem+male+married+dep+sch+cosign+chist+pubrec+mortlat1+mortlat2+vr+whiteobrat,family=binomial(link="logit"),data=context2)
coeftest(model5,vcov.=vcovHC)


## Interpretations for Question 2
# (a) It indicates that being white increases the chance of loan approval
# (b) Yes, it is still significant at 0.1% level
# (c) The coefficient decreases and it's no more significant after adding the interaction variables
# (d) white*obrat is the interaction variable. It has affected the model so greatly because 
#     it incorporated the relationship between the white and obrat variables which made the model
#     more accurate for analysis of dependent variable


## Question 3

context3 <- fread('smoke.csv')

context3$agesq <- (context3$age)^2
context3$lnincome <- log(context3$income)

model6 <- glm(cigs~educ+age+agesq+lnincome+restaurn,family=poisson(link="log"),data=context3)
coeftest(model6,vcov.=vcovHC)


## Interpretations for Question 3
# (a) Increase in 1 year of schooling is associated with a 6% decrease in number of cigs smoked per day, controlling for age, 
#     annual income and restaurant smoking restrictions
# (b) y ~ .11399x-.001367(x^2)  and dy ~ .11399 -2*.001367x  so putting the values 20 and 60 in this the rate of change in g(cigs) 
#     is 0.05931 and -0.05005


## Question 4

context4 <- fread('hdisease.csv')

context4$exang		<-	ifelse(context4$exang=="yes",1,0)
f <- hdisease ~ age + cp + trestbps + thalach + exang


model7 <- evtree(f, data=context4)
plot(model7)

model8 <- ctree(f, data=context4)
plot(model8)

context5 <- fread('hdisease-new.csv')
context5$hdisease_pred <- predict(model8,context5)



## Interpretations for Question 4
# (a) model7 is underfitting the data and model8 is overfitting the data
# (b) dset is a categorical variable which needs to be converted into numeric one or the one having multiple levels 
#     but using the numeric values won't give the results as expected












