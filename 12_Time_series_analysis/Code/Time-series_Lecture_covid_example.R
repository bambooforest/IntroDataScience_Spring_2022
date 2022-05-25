#H1: The covid cases will increase
#H0: The covid cases will decrease

#Load the packages
#install.packages("tseries")
library(tidyverse)
library(tseries)

#Set the working directory and load the dataset

setwd("/home/marco/Desktop/Neuchatel_PhD/Lectures_Material/Time_Series/Datasets")

data <- read.csv("Covid_19_cases_EU.csv")

str(data)

#Explore the dataset and filter if necessary

data <- filter(data, Countries == "Sweden")

is.ts(data)

data$Date <- as.Date(data$Date)

data$Cases <- as.numeric(data$Cases)

data.ts <- ts(data$Cases, start = c(2020, 2), end = c(2022, 2), frequency = 365)

is.ts(data.ts)

print(data.ts)

str(data.ts)

start(data.ts)

end(data.ts)

frequency(data.ts)

deltat(data.ts)

#Plot as a time-series (plot + acf), which visualization is better?

par (mfrow=c(2,1), mar=c(4,4,4,4))

ts.plot(data.ts, col = 1:4, xlab = "Date", ylab = "Cases", main = "Covid cases Sweden", type = "l")

acf(data.ts, main = "acf Covid cases Sweden")

#Which model is more suitable?

data_diff <- diff(data.ts)

par (mfrow=c(1,1), mar=c(4,4,4,4))

ts.plot(data_diff, xlab = "Date", ylab = "Cases", main = "WN Covid cases --", type = "l")

arima(x= data.ts, order = c(0,0,0))

arima(x= data.ts , order = c(0,1,0))

data_AR <- arima(data.ts, order = c(1,0,0))
print(data_AR)
ts.plot(data.ts, xlab = "Date", ylab = "Cases", main = "AR Covid cases ---", type = "l")
AR_fitted <- data.ts - residuals(data_AR)
points(AR_fitted, type = "l", col = 2, lty = 2)

data_MA <- arima(data.ts, order = c(0,0,1))
print(data_AR)
ts.plot(data.ts, xlab = "Date", ylab = "Cases", main = "MA Covid cases ---", type = "l")
MA_fitted <- data.ts - residuals((data_MA))
points(MA_fitted, type = "l", col = 2, lty = 2)

#Forecast the time-series trend
ts.plot(data.ts, xlab = "Date", ylab = "Cases", main = "Prediction Covid cases ---", type = "l")
AR_forecast <- predict(data_AR, n.ahead = 10)$pred
AR_forecast_se <- predict(data_AR, n.ahead = 10)$se
points(AR_forecast, type = "l", col = 2)
points(AR_forecast - 2*AR_forecast_se, type = "l", col = 2, lty = 2)
points(AR_forecast + 2*AR_forecast_se,type = "l", col = 2, lty = 2)

ts.plot(data.ts, xlab = "Date", ylab = "Cases", main = "Prediction Covid cases ---", type = "l")
MA_forecast <- predict(data_MA, n.ahead = 10)$pred
MA_forecast_se <- predict(data_MA, n.ahead = 10)$se
points(MA_forecast, type = "l", col = 2)
points(MA_forecast - 2*MA_forecast_se, type = "l", col = 2, lty = 2)
points(MA_forecast + 2*MA_forecast_se,type = "l", col = 2, lty = 2)

#Which model is better?

cor(AR_fitted, MA_fitted)

#Autoregression
AIC(data_AR)

BIC(data_AR)

#Moving Average
AIC(data_MA)

BIC(data_MA)


