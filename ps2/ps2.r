###############################################################
# Title:        ps2.r
# Author:       Mohith Ashok
# Date:         2017-09-26
# Description:  Deliverable for Problem set 2
###############################################################

rm(list=ls(all=TRUE))

library(data.table)

## Question 1

context1  <- fread('attend.csv')

summary(context1)

attendrt <- context1$attend/32

hwrt <- context1$hw/8

model1 <- lm(context1$termGPA~context1$priGPA+context1$ACT+attendrt+hwrt, data = context1)
summary(model1)


# Call:
#   lm(formula = context1$termGPA ~ context1$priGPA + context1$ACT + 
#        attendrt + hwrt, data = context1)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -1.87210 -0.28100  0.00001  0.30164  1.49711 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)     -1.286983   0.164169  -7.839 1.77e-14 ***
#   context1$priGPA  0.548962   0.042418  12.942  < 2e-16 ***
#   context1$ACT     0.036099   0.006051   5.966 3.92e-09 ***
#   attendrt         1.052246   0.155436   6.770 2.81e-11 ***
#   hwrt             0.913031   0.116932   7.808 2.22e-14 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.4788 on 675 degrees of freedom
# Multiple R-squared:   0.58,	Adjusted R-squared:  0.5775 
# F-statistic:   233 on 4 and 675 DF,  p-value: < 2.2e-16

## Interpretations for Question 1
# (a) Every class attended by a student is associated with an increase of 0.03288269 (that is = 1.052246/32) in 
#     the GPA for the term
# (b) Every homework turned in by a student is associated with an increase of 0.1141289 (that is = 0.913031/8) in 
#     the GPA for the term
# (c) The GPA for the term is predicted to be 
#     2.909648 (that is =-1.286983 + (0.548962)*2.2 + (0.036099)*32 + (1.052246)*(28/32) + (0.913031)*(8/8)) 
#     by model1 when the student has a prior GPA of 2.2, an ACT score of 32, attended 28 classes 
#     and turned in 8 homeworks
# (d) The GPA for the term is predicted to be 
#     3.409695 (that is =-1.286983 + (0.548962)*3.9 + (0.036099)*20 + (1.052246)*(28/32) + (0.913031)*(8/8)) 
#     by model1 when the student has a prior GPA of 3.9, an ACT score of 20, attended 28 classes 
#     and turned in 8 homeworks
# (e) Intutively, the priGPA seems to have a higher impact on the termGPA than the ACT scores since a higher prior GPA (in (d))
#     has produced a better termGPA than a higher ACT score (in (c) )
# (f) The GPA for the term is predicted to be
#     2.77114 (that is =-1.286983 + (0.548962)*3 + (0.036099)*25 + (1.052246)*(32/32) + (0.913031)*(4/8))
#     by model1 when the student has a prior GPA of 3, an ACT score of 25, full attendance and has turned-in half
#     of the homework assignments 
# (g) The GPA for the term is predicted to be
#     2.701532 (that is =-1.286983 + (0.548962)*3 + (0.036099)*25 + (1.052246)*(16/32) + (0.913031)*(8/8))
#     by model1 when the student has a prior GPA of 3, an ACT score of 25, half attendance and has turned-in all
#     of the homework assignments 
# (h) Intutively, the class attendance seems to have a higher impact on the termGPA than the homework assignments turned in
# (i) It is easier to compare the attendrt and hwrt because they gives us a normalized value for the variables, which 
#     helps us in comparing them. When comparing priGPA and ACT score, we are comparing absolute values that are in 
#     different scales. This complicates the comparison of the magnitudes.



## Question 2

context2 <- fread('CEOSAL2.csv')
summary(context2)

lsalary = log(context2$salary)
lmktval = log(context2$mktval)
lsales  = log(context2$sales)

model2 <- lm(lsalary~lmktval+context2$profits+context2$ceoten)
summary(model2)

# Call:
#   lm(formula = lsalary ~ lmktval + context2$profits + context2$ceoten)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -2.63382 -0.34660  0.00627  0.35059  1.96220 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)      4.7095052  0.3954502  11.909  < 2e-16 ***
#   lmktval          0.2386220  0.0559166   4.267 3.25e-05 ***
#   context2$profits 0.0000793  0.0001566   0.506   0.6132    
# context2$ceoten  0.0114646  0.0055816   2.054   0.0415 *  
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.5289 on 173 degrees of freedom
# Multiple R-squared:  0.2514,	Adjusted R-squared:  0.2384 
# F-statistic: 19.36 on 3 and 173 DF,  p-value: 7.141e-11


model3 <- lm(lsalary~lmktval+context2$profits+context2$ceoten+lsales)
summary(model3)

# Call:
#   lm(formula = lsalary ~ lmktval + context2$profits + context2$ceoten + 
#        lsales)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -2.48792 -0.29369  0.00827  0.29951  1.85524 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)      4.558e+00  3.803e-01  11.986  < 2e-16 ***
#   lmktval          1.018e-01  6.303e-02   1.614   0.1083    
# context2$profits 2.905e-05  1.503e-04   0.193   0.8470    
# context2$ceoten  1.168e-02  5.342e-03   2.187   0.0301 *  
#   lsales           1.622e-01  3.948e-02   4.109 6.14e-05 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.5062 on 172 degrees of freedom
# Multiple R-squared:  0.3183,	Adjusted R-squared:  0.3024 
# F-statistic: 20.08 on 4 and 172 DF,  p-value: 1.387e-13

## Interpretations for Question 2
# (j) We use natural logs on most of the dollar-valued quantites because it is easier to think of money in 
#     multiplicative terms rather than additive terms. However, we didn't use natural log on the profits because
#     it contains negative values and log accepts only +ve values
# (k) Every 1% increase in market value of a company is associated with an increase of 0.2386220% increase in
#     the salary compensation for the CEO according to model2
# (l) Every 1% increase in market value of a company is associated with an increase of 0.1018% increase in
#     the salary compensation for the CEO according to model3
# (m) The correlation between lsales and lmktval(i.e cor(lsales,lmktval)) comes out to 0.7359232. This shows that in model2,
#     lmktval is acting as a proxy for lsales. This is the reason for lmktval becoming insignificant in model3. So, model2
#     has omitted variable bias
# (n) The coefficient of profits is not significant in model3 (p-value = 0.8470; i.e p-value > 0.05) 
# (o) Every 1% increase in sales of a company is associated with an increase of 0.1622% increase in the salary
#     compensation for the CEO according to model3



## Question 3

context3 <- fread('hprice1.csv')
summary(context3)

llotsize <- log(context3$lotsize)
lsqrft   <- log(context3$sqrft)
lprice   <- log(context3$price)

model4 <- lm(context3$price~context3$bdrms+llotsize+lsqrft+context3$colonial)
summary(model4)

# Call:
#   lm(formula = context3$price ~ context3$bdrms + llotsize + lsqrft + 
#        context3$colonial)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -109.603  -38.258   -4.325   22.984  220.766 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)       -2030.455    210.967  -9.625 3.68e-15 ***
#   context3$bdrms       18.572      9.308   1.995   0.0493 *  
#   llotsize             61.446     12.372   4.966 3.60e-06 ***
#   lsqrft              225.508     30.072   7.499 6.41e-11 ***
#   context3$colonial     4.134     14.509   0.285   0.7764    
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 59.66 on 83 degrees of freedom
# Multiple R-squared:  0.6781,	Adjusted R-squared:  0.6626 
# F-statistic: 43.71 on 4 and 83 DF,  p-value: < 2.2e-16

model5 <- lm(lprice~context3$bdrms+llotsize+lsqrft+context3$colonial)
summary(model5)

# Call:
#   lm(formula = lprice ~ context3$bdrms + llotsize + lsqrft + context3$colonial)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.69479 -0.09750 -0.01619  0.09151  0.70228 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)       -1.34959    0.65104  -2.073   0.0413 *  
#   context3$bdrms     0.02683    0.02872   0.934   0.3530    
# llotsize           0.16782    0.03818   4.395 3.25e-05 ***
#   lsqrft             0.70719    0.09280   7.620 3.69e-11 ***
#   context3$colonial  0.05380    0.04477   1.202   0.2330    
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.1841 on 83 degrees of freedom
# Multiple R-squared:  0.6491,	Adjusted R-squared:  0.6322 
# F-statistic: 38.38 on 4 and 83 DF,  p-value: < 2.2e-16


## Interpretations for Question 3
# (p) Every 1% increase in lotsize is associated with a $614.46 increase in the house price according to model4
# (q) Every 1% increase in lotsize is associated with an increase of 0.16782% increase in house price according to model5
# (r) A house being in colonial is associated with a $4134 increase in the house price according to model4
# (s) The model4 better fits the data as it has an R-squared value (0.6781) that is closer to 1 than the R-squared value of 
#     model5 (0.6491)
# (t) With an increase in 1 bedroom and 10% increase in square feet of the house, price of the house increases by (18.57 + 225.5*.1) = $44
#     New price of the house = $344k
#     If cost of expansion is $50k and value is $20, I expect a return of more than $330k ($350-$20)
#     Since the price of the house is estimated to $344k, the expansion should be implemented




## Question 4

context4 <- fread('JTRAIN2.csv')
summary(context4)

model6 <- lm(context4$re78~context4$re75+context4$train+context4$educ+context4$black)
summary(model6)

# Call:
#   lm(formula = context4$re78 ~ context4$re75 + context4$train + 
#        context4$educ + context4$black)
# 
# Residuals:
#   Min     1Q Median     3Q    Max 
# -9.120 -4.377 -1.756  3.353 54.058 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)   
# (Intercept)     1.97686    1.89028   1.046   0.2962   
# context4$re75   0.14697    0.09811   1.498   0.1349   
# context4$train  1.68422    0.62700   2.686   0.0075 **
#   context4$educ   0.41026    0.17267   2.376   0.0179 * 
#   context4$black -2.11277    0.82941  -2.547   0.0112 * 
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 6.496 on 440 degrees of freedom
# Multiple R-squared:  0.04917,	Adjusted R-squared:  0.04053 
# F-statistic: 5.688 on 4 and 440 DF,  p-value: 0.00018

## Interpretations for Question 4
# (u) Every $1000 increase in the real earnings in 1975 is associated with a $146.97 increase in the real earnings
#     in 1978 according to model6
# (v) A man being assigned to job training is associated with an increase in his real earning in 1978 by $1684.22 
#     according to model6. The coefficient is significant as the p-value (0.0075) is less than 0.05.
# (w) A person being black is associated with a drop in his real earning in 1978 by $2112.77 according to model6



