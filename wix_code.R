# Load necessary libraries
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
library(scales)
library(urca)
library(forecast)
library(tseries)

###############################################################################
###############################################################################

##Exercise 2 

##loading the table

vixhistory <- read.table("VIX_History.csv", header = TRUE, sep = ",")

View(vixhistory)

# converting date to the correct format
vixhistory$DATE <- as.Date(vixhistory$DATE, format = "%m/%d/%Y")

# plotting the 4 series in one plot
plot(vixhistory$DATE, vixhistory$OPEN, type = "l", col = "purple", xlab = "Date", ylab = "Price", main = "VIX Prices Over Time")
lines(vixhistory$DATE, vixhistory$CLOSE, col = "pink")
lines(vixhistory$DATE, vixhistory$HIGH, col = "lightgreen")
lines(vixhistory$DATE, vixhistory$LOW, col = "navy")
legend("topright", legend = c("Open", "Close", "High", "Low"), col = c("purple", "pink", "lightgreen", "navy"), lty = 1)


# extracting the close series
vix_close_series <- vixhistory$CLOSE

# creating a time series object
vix_close_ts <- ts(vix_close_series, frequency = 365) # i did take a shortcut and assumed daily frequency

# decomposing the time series
decomposed <- decompose(vix_close_ts)

# ploting the decomposed components
plot(decomposed)

adf_test <- ur.df(vix_close_series, type = "trend", lags = 10)
summary(adf_test)

# ploting ACF and PACF of the stationary series
par(mfrow = c(2, 1))
acf(vix_close_series, main = "ACF of Stationary Series")
pacf(vix_close_series, main = "PACF of Stationary Series")



# seting the seed for reproducibility
set.seed(123)

# simulating an ARIMA(1,0,0) process with 100 observations
# assuming that the AR1 coefficient is 0.7 based on PACF
simulated_data <- arima.sim(n = 100, model = list(ar = 0.7))

# ploting the simulated data
plot(simulated_data, main = "Simulated ARIMA(1,0,0) Process")



fitted_model <- auto.arima(vix_close_ts, max.p=1, max.d=0, max.q=0)

# summary of the model
summary(fitted_model)

# simulate the ARIMA process based on the fitted model
set.seed(123) # for reproducibility
simulated_arima <- simulate(fitted_model, nsim=length(vix_close_ts))

# ploting the actual time series and the simulated ARIMA process
plot(vix_close_ts, main="Actual vs Simulated ARIMA(1,0,0) Process", col="blue", ylab="VIX Close")
lines(simulated_arima, col="red")
legend("topright", legend=c("Actual", "Simulated"), col=c("blue", "red"), lty=1)


