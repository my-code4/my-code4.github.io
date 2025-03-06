install.packages("prophet")
library(prophet)
install.packages("remotes")
remotes::install_github('facebook/prophet@*release',subdir='R')
pkgbuild::check_build_tools(debug = TRUE)
co2.df = data.frame(
    ds=zoo::as.yearmon(time(co2)),
    y=co2
)
m = prophet::prophet(co2.df)
f = prophet::make_future_dataframe(m, periods=8, freq="quarter")
p = predict(m, f)
plot(m, p)


london_weather = read.csv("data/london_weather_data_1979_to_2023.csv")
head(london_weather)
tail(london_weather)
london_weather["DATE"]
ncol(london_weather$DATE)
ncol(london_weather)
nrow(london_weather)
class(london_weather)

date = london_weather$DATE
max_temp = london_weather["TX"]

install.packages("lubridate")
library(lubridate)
library(prophet)
format_date = lubridate::ymd(london_weather$DATE)
format_date

daily_temp = data.frame(ds = lubridate::ymd(london_weather$DATE),
                        y = london_weather$TX)
m = prophet::prophet(daily_temp)
f = make_future_dataframe(m, periods = 3650, freq = "day")
p = predict(m, f)
plot(m, p)
fifteen_year_prediction = make_future_dataframe(m, periods = 5479, freq="day")
predict_next_15_years = predict(m, fifteen_year_prediction)
pred_15 = plot(m, predict_next_15_years)

library(zoo)
time_series = read.zoo(daily_temp)
time_series
ts_time_series = ts(time_series, start = 1990, frequency = 365)
ts_time_series
class(ts_time_series)
plot(ts_time_series)
plot(time_series)
class(time_series)

HW_method = HoltWinters(ts_time_series)
HW_methos_bg = HoltWinters(ts_time_series, beta = FALSE, gamma = FALSE)
HW_method_g = HoltWinters(ts_time_series, gamma = FALSE)
HW_method_b = HoltWinters(ts_time_series, beta = FALSE)
detrend = stats::decompose(ts_time_series)
plot(HW_method)
plot(detrend)
plot(ts_time_series)
plot(HW_methos_bg)
plot(HW_method_g)
plot(HW_method_b)

HW_predict = predict(HW_method, 3650)
plot(HW_method, HW_predict)

plot(diff(ts_time_series))


