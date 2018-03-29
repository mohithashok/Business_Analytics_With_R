###############################################################
# Title:        ps3.r
# Author:       Mohith Ashok
# Date:         2017-10-30
# Description:  Deliverable for Problem set 3
###############################################################

rm(list=ls(all=TRUE))

## Import packages
library(data.table)
library(lmtest)
library(sandwich)
library(tseries)
library(plm)


## Question 1

context1  <- fread('hprice1.csv')

summary(context1)

model1 <- lm(context1$price~context1$bdrms+context1$lotsize+context1$sqrft, data=context1)

coeftest(model1)
coeftest(model1,vcov.=vcovHC)



lprice <- log(context1$price)
llotsize <- log(context1$lotsize)
lsqrft <- log(context1$sqrft)

model2 <- lm(lprice~context1$bdrms+llotsize+lsqrft, data = context1)

coeftest(model2)
coeftest(model2,vcov.=vcovHC)




## Interpretations for Question 1
# (a) According to the OLS test on model1, variables lotsize and sqrft are significant according to the p-values
# (b) According to the White-corrected significance test, only sqrft is significant (p-value < 1%)
# (c) According to the OLS test on model2, variables log(lotsize) and log(sqrft) are highly significant according to the p-values (< 1%)
# (d) According to the White-corrected significance test on model2, variables log(lotsize) and log(sqrft) are significant according to the p-values
# (e) When we take log() on the variables in the data, we reduce the variability of the data. This reduces the hetroskedasticity.


## Question 2

context2 <- fread('beveridge.csv')

model3 <- lm(context2$urate~context2$vrate, data = context2)
summary(model3)

coeftest(model3)

coeftest(model3,vcov=NeweyWest(model3,lag=5)) 

kpss.test(context2$urate, null="Level")
kpss.test(context2$urate, null="Trend")
kpss.test(diff(context2$urate), null="Level")
kpss.test(diff(context2$urate), null="Trend")
kpss.test(diff(diff(context2$urate)), null="Level")
kpss.test(diff(diff(context2$urate)), null="Trend")

kpss.test(context2$vrate, null="Level")
kpss.test(context2$vrate, null="Trend")
kpss.test(diff(context2$vrate), null="Level")
kpss.test(diff(context2$vrate), null="Trend")
kpss.test(diff(diff(context2$vrate)), null="Level")
kpss.test(diff(diff(context2$vrate)), null="Trend")


model4 <- lm(diff(urate) ~ diff(vrate) , data=context2)
summary(model4)

coeftest(model4) 
coeftest(model4,vcov=NeweyWest(model4,lag=5)) 


## Interpretations for Question 2
# (f)	Yes, the coefficient on the vacancy rate (vrate) is highly significant (p-value < 1%) before and after we correct for stationarity.
# 
# (g)	Unemployment rate (urate) is "Level Stationarity" on taking the first difference. Hence, we must take the first difference of the variable urate before modeling.
# 
# (h)	Vacancy rate (vrate) is "Level Stationarity" on taking the first difference. Hence, we must take the first difference of the variable vrate before modeling.
# 
# (i)	The coefficient on the vacancy rate (vrate) is significant from model 3. But, checking the results from model4, we see the coefficient on the vacancy rate (vrate) is NOT significant. 
# 
# (j)	Model 4 better describes the data as it is the result of a stationary data


## Question 3

context3    <- fread('JTRAIN.csv')
context3    <- plm.data(context3,index=c("fcode","year"))

context3$d88 <- factor (with ( context3, ifelse(( year == 1988 ), 1 ,0)))
context3$d89 <- factor (with ( context3, ifelse(( year == 1989 ), 1 ,0)))

context3$lscrap <- log(context3$scrap)

table(context3$grant)

for(i in 1:nrow(context3)){
  if(context3$year[i] == 1987)
    context3$grant_1[i] <- 0
  else if(context3$grant[i-1] == 1)
    context3$grant_1[i] <- 1
  else
    context3$grant_1[i] <- 0
}

model5 <- plm(lscrap ~ d88 + d89 + grant + grant_1, model ="pooling", data=context3)
summary(model5)
coeftest(model5) 

model6 <- plm(lscrap ~ d88 + d89 + grant + grant_1, model ="within", data=context3)

coeftest(model6) 

summary(model6, vcov=vcovHC(model6, method = "arellano"))


## Interpretations for Question 3
# (k) A firm recieving grant is associated with a 20% increase in scrap according to model5, controlling the other variables
# (l) A firm recieving grant in previous year is associated with 4.8936% increase in scrap according to model5, controlling the other variables
# (m) Since the Signs of B3 and B4 are positive, having a grant increases the scrape rate. This is because the data is pooled and hence not differentiated based on fcode.
# (n) A firm recieving grant is associated with 25.2315% decrease in scrap considering fixed effects according to model6, controlling the other variables
# (o) A firm recieiving grant last year is associated with 42.1590% decrease in scrap considering fixed effects
# (p) Having a grant(in same/previous year) decreases the scrape rate (since Signs of B3 and B4 are negative). This is because the data is studied fcode wise, hence effect is for every fcode individually.
# (q) In model 5 d89 becomes significant after arrelano and the rest remains same. In model 6 grant_ly loses significance after arrelano and the rest remains same


















