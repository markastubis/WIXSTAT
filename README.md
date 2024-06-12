# WIXSTAT
Took  CBOE  Volatility  Index data and decided to check for data stationarity, then simulate it on the ARIMA process based on ACF and PACF results.

Firstly, I decided to plot the data to see what we are dealing with.

Then, I picked CLOSE value series and made it into time series,(made a pretty heavy assumption that I am planning on fixing in the future, that every day is a trading day) and decomposed the time series.

After, I checked for stationarity using Augmented  Dicky-Fuller  test  for  unit  root.

Furthermore, plotted ACF and PACF to check for stationarity.

Lastly, performed ARIMA process based on ACF and PACF results, and plotted in one graph your time series and my chosen simulates ARIMA process
