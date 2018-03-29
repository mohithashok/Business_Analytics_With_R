###############################################################
# Title:        ps1.r
# Author:       Mohith Ashok
# Date:         2017-09-11
# Description:  Deliverable for Problem set 1
###############################################################

rm(list=ls(all=TRUE))

library(data.table)

context1  <- fread('Wage1.csv')

summary(context1)

lwage = log(context1$wage)      

model1 = lm(context1$wage~context1$educ, data=context1)

model2 = lm(context1$wage~context1$educ+context1$exper+context1$tenure, data=context1)

model3 = lm(lwage~context1$educ+context1$exper+context1$tenure, data=context1)

summary(model1)

# Call:
#   lm(formula = context1$wage ~ context1$educ, data = context1)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -5.3707 -2.1578 -0.9854  1.1864 16.3975 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   -0.93389    0.68769  -1.358    0.175    
# context1$educ  0.54470    0.05346  10.189   <2e-16 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 3.392 on 524 degrees of freedom
# Multiple R-squared:  0.1654,	Adjusted R-squared:  0.1638 
# F-statistic: 103.8 on 1 and 524 DF,  p-value: < 2.2e-16

summary(model2)

# Call:
#   lm(formula = context1$wage ~ context1$educ + context1$exper + 
#        context1$tenure, data = context1)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -7.6498 -1.7708 -0.6407  1.2051 14.7201 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)     -2.91354    0.73172  -3.982 7.81e-05 ***
#   context1$educ    0.60268    0.05148  11.708  < 2e-16 ***
#   context1$exper   0.02252    0.01210   1.861   0.0633 .  
# context1$tenure  0.17002    0.02173   7.825 2.83e-14 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 3.096 on 522 degrees of freedom
# Multiple R-squared:  0.3072,	Adjusted R-squared:  0.3032 
# F-statistic: 77.15 on 3 and 522 DF,  p-value: < 2.2e-16


summary(model3)

# Call:
#   lm(formula = lwage ~ context1$educ + context1$exper + context1$tenure, 
#      data = context1)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -2.05911 -0.29563 -0.03302  0.28590  1.42657 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)     0.282635   0.104331   2.709  0.00697 ** 
#   context1$educ   0.092256   0.007340  12.569  < 2e-16 ***
#   context1$exper  0.004137   0.001726   2.397  0.01687 *  
#   context1$tenure 0.022112   0.003098   7.138 3.19e-12 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.4415 on 522 degrees of freedom
# Multiple R-squared:  0.3165,	Adjusted R-squared:  0.3125 
# F-statistic: 80.56 on 3 and 522 DF,  p-value: < 2.2e-16





## Interpretations
# (a) Every one year increase in education for a worker is associated with an increase of $0.54470 in 
#     average hourly earnings according to model1
# (b) Every one year increase in education for a worker is associated with an increase of $0.60268 in 
#     average hourly earnings according to model2
# (c) Every one year increase in experience for a worker is associated with an increase of $0.02252 in 
#     average hourly earnings according to model2
# (d) Every one year increase in experience with current employer for a worker is associated with an increase 
#     of $0.17002 in average hourly earnings according to model2
# (e) For a worker with no education and experience (neither with the current employer nor 
#     with any other employer), the model predicts a wage of $(-2.91354) according to model2. Since the wages 
#     can't be negative, the worker will have no wages effectively. (Such a person would probably choose to not work at all)
# (f) Every one year increase in education for a worker is associated with an increase of 9.2256% in 
#     average hourly earnings controlling for experience and tenure according to model3
# (g) Every one year increase in experience for a worker is associated with an increase of 0.4137% in 
#     average hourly earnings controlling for education and tenure according to model3
# (h) Every one year increase in experience with current employer for a worker is associated with an increase 
#     of 2.2112% in average hourly earnings controlling for education and tenure according to model3