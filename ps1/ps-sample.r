###############################################################
# Title:        ps-sample.r
# Author:       Jason Parker
# Date:         2017-09-04
# Description:  Turn-in product for problem set sample
###############################################################

rm(list=ls(all=TRUE))

## Import packages
library(data.table)

## Data import and validation
context1    <- fread('MEAP93.csv')
summary(context1)
# variable name   type    format     label      variable label
# lnchprg         float   %9.0g                 perc of studs in sch lnch prog
# enroll          int     %9.0g                 school enrollment
# staff           float   %9.0g                 staff per 1000 students
# expend          int     %9.0g                 expend. per stud, $
# salary          float   %9.0g                 avg. teacher salary, $
# benefits        int     %9.0g                 avg. teacher benefits, $
# droprate        float   %9.0g                 school dropout rate, perc
# gradrate        float   %9.0g                 school graduation rate, perc
# math10          float   %9.0g                 perc studs passing MEAP math
# sci11           float   %9.0g                 perc studs passing MEAP science

## Generate new variables
totcomp     <- context1$salary + context1$benefits
lenroll     <- log(context1$enroll)

## Run models
model1      <- lm(math10~totcomp+lenroll, data=context1)
model2      <- lm(sci11 ~totcomp+lenroll, data=context1)

## Summarize
summary(model1)
# Call:
# lm(formula = math10 ~ totcomp + lenroll, data = context1)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -23.437  -6.972  -0.728   5.915  41.813 
# 
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  1.449e+01  4.548e+00   3.187  0.00155 ** 
# totcomp      4.769e-04  9.964e-05   4.786 2.39e-06 ***
# lenroll     -1.148e+00  6.876e-01  -1.669  0.09580 .  
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 10.22 on 405 degrees of freedom
# Multiple R-squared:  0.05576,	Adjusted R-squared:  0.0511 
# F-statistic: 11.96 on 2 and 405 DF,  p-value: 9.003e-06
summary(model2)
# Call:
# lm(formula = sci11 ~ totcomp + lenroll, data = context1)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -43.280  -7.699  -0.319   7.714  39.253 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 3.661e+01  5.532e+00   6.617 1.16e-10 ***
# totcomp     2.615e-04  1.212e-04   2.157   0.0316 *  
# lenroll     3.433e-01  8.364e-01   0.410   0.6817    
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 12.43 on 405 degrees of freedom
# Multiple R-squared:  0.01931,	Adjusted R-squared:  0.01447 
# F-statistic: 3.987 on 2 and 405 DF,  p-value: 0.01928

## Interpretations
# 1a    Every $1000 increase in total compensation for teachers is 
#       with a 0.4769 percentage point increase in the math pass 
#       rate for 10th graders controlling for enrollment.
# 1b    Every 100% increase in enrollment is associated with a 1.148 
#       percentage point decrease in the math pass rate for 10th 
#       graders controlling for total teacher compensation.
# 1c    Every $1000 increase in total compensation for teachers is 
#       associated with a 0.2615 percentage point increase in the 
#       science pass rate for 11th graders controlling for enrollment.
# 1d    Every  100% increase in enrollment is associated with a 0.3433 
#       percentage point increase in the science pass rate for 11th 
#       graders controlling for total teacher compensation.
# 1e    For a school with no funding for teachers and having only 1 
#       student enrolled, the model predicts a 36.61 percentage pass 
#       rate for the science exam for 11th graders.