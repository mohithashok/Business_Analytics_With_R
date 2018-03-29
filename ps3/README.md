Data:
- hprice1.csv contains data on 88 U.S. houses, their characteristics, and their prices at the time of sale.
- beveridge.csv includes monthly observations on vacancy rates and unemployment rates for the U.S. from December 2000 through February 2012.
- JTRAIN.csv has data on the scrap rates of various firms whether they were given a grant to increase their productivity. The scrap rate for a manufacturing firm is the number of defective items - products that must be discarded - out of every 100 produced. Thus, for a given number of items produced, a decrease in the scrap rate reflects higher worker productivity.

Analysis:
- Created OLS models using the features and log transformed features for the 'hprice1.csv' data. Secondly, identified significant variables using the White-corrected significance test. Through this, analyzed the effect of log transformation on data with heteroskedasticity.
- Created OLS models using the features and log transformed features for the 'beveridge.csv' data. Consequently, computed the OLS significance test and the Newey-West-corrected significance test and identified the significance of various features. Performed the level and trend KPSS tests on unemployment rate and vacancy rate, before and after differencing. Finally, found a model that best describes the data.
- Firstly, generated a new variable indicating whether or not the firm had a grant last year on the 'JTRAIN.csv' data. Developed a pooled linear model (PLM) using the features and the variable created. Additionally, created a fixed effects model using the 'plm' function. Finally, computed the results for OLS significance test and and the HAC-corrected significance test (Arellano) for the models.
