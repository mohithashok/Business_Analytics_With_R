Data:
- WAGE1.csv contains data for various workers at the employee-level. We have data on their average hourly wage along with information about their years of education, experience, tenure (years at the same firm), and some job/industry characteristics.
- The data in ffportfolios.csv contains market returns for 32 stock market portfolios from July 1963 to September 2017.

Analysis:
- Developed a k-means clustering model for the data available in 'WAGE1.csv'. Identified the optimal number of clusters by using the elbow test on the Within sum of squares plot. Analyzed the clusters by looking at the means from the model.
- Developed a Principal Component Analysis (PCA) model for the data available in 'ffportfolios.csv'. Used the 'scree' plot to determine the number of principal components need for the data. Additonally, checked for level and trend stationarity in the data.
