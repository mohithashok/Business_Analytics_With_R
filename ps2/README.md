Data:
- The data attend.csv contains 680 observations on students in a course on microeconomic principles.
- The data set in CEOSAL2.csv contains information on chief executive o¢ cers for U.S. corporations. The variable salary is annual compensation, in thousands of dollars. 
- hprice1.csv contains data on 88 U.S. houses, their characteristics, and their prices at the time of sale
- The data in JTRAIN2.csv come from a job training experiment conducted for low income men in the U.S. during 1976-1977; see Lalonde (1986).

Analysis:
- Created a new variable attendrt for the attendance rate (classes attended out of the total number of classes) and hwrt for the homework completion rate (homeworks turned in of out the total number of homework assignments). Ran linear regression models using the features as well as the new variables created. Identified good models and interpreted the coefficients from these models. Finally, predicted a value for termGPA using the features and the new variables.
- Log transformed the 'salary' feature in the CEOSAL2.csv data and ran Linear Regression models to analyze the effect of various features on the salary of a CEO.
- Log transformed various features and ran Linear Regression models in the hprice1.csv data. Used the most accurate model to predict the house prices based on sample feature values.
- Analyzed the data in JTRAIN2.csv using Linear Regression models and interpreted the estimated coefficients.
