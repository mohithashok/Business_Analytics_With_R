Data:
- The htv.csv data set includes information on wages, education, parentsíeducation, and several other variables
for 1,230 working men in 1991.
- The loanapp.csv data contains information on individuals and whether or not they were approved for a loan to buy a house. The binary variable to be explained is 'approve', which is equal to one if a mortgage loan to an individual was approved. The key explanatory variable is 'white', a dummy variable equal to one if the applicant was white. The other applicants in the data set are 'black' and 'Hispanic'.
- We use the data in smoke.csv to estimate a demand function for daily cigarette consumption. Since most people do not smoke, the dependent variable, cigs, is zero for most observations. A linear model is not ideal because it can result in negative predicted values.
- The data in hdisease.csv contains patient information for patients admitted to four hospitals for different studies. The patients were admitted for chest pain and were diagnosed with or without heart disease. When they were diagnosed with heart disease, the disease was ranked in stages 1 to 4.


Analysis:
- Created OLS models using the features and log transformed features for the 'htv.csv' data. Using the AIC and BIC, determined the best model for describing the data. Additionally, explored the interaction variables and their significance in the models.
- Developed a logistic model using the glm function in R to predict the approval of loan, using the features (and their interaction variables) available in the 'loanapp.csv' data. Identified significant features in the prediction, using White heteroskedasticity robust standard errors. 
- Developed a poisson model using the glm function in R to estimate a demand function for daily cigarette consumption, using the features (and their interaction variables) available in the 'smoke.csv' data. Identified significant features in the prediction, using White heteroskedasticity robust standard errors. Finally, calculated the rate of change of demand with respect to age for a given set of feature values.
- Ran a recursive partitioning model using the 'evtree' function from the 'evtree' package on the data from 'hdisease.csv'. Ran the same recursive partitioning model using the 'ctree' function from the 'party' package. Finally, predicted the classification of various data points using the models.
