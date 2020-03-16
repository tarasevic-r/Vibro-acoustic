
#rading data
df <- read.csv("C:/Users/user2/Desktop/T7_800_R6292.csv", sep = ",", header = T)
head(df)

subset <- subset(df, as.POSIXct(df$timestamp) >= as.POSIXct('2019-01-16 02:37:54') &
                   as.POSIXct(df$timestamp) <= as.POSIXct('2019-03-15 13:45:00'))


#converting date to POSIXct format and ploting
# date <- as.POSIXct(df$timestamp)
# plot(date, df$value, type = 'l')

date <- as.POSIXct(subset$timestamp)
plot(date, subset$value, type = 'l')

#converting to tible object
df_ts <- subset %>% rownames_to_column() %>% as_tibble() %>% 
  mutate(date = as.POSIXct(timestamp)) %>% select(-one_of('rowname'))

#head of sample data
head(df_ts)

#time series decomposition into "seasonal", "trend" and "remainder" components
#detecting and flaging anomalies in decomposed data
df_ts %>% 
  time_decompose(value, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(remainder, method = "gesd", alpha = 0.05, max_anoms = 0.2) %>%
  plot_anomaly_decomposition()


#timeseries recomposed back and ploted with detected anomalies
df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.5)


#extracting actual anomaly data points
df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly == 'Yes') 


#anomalies
anom <- df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly == 'Yes') 


#NOT anomalies
not_anom <- df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly != 'Yes') 



#select columns
not_anomaly <- as.data.frame(not_anom[,1:2])

x <- as_datetime(not_anomaly$date[2:length(not_anomaly$date)])
y <- diff(not_anomaly$observed)

# plot data without anomalies
# plot(diff(not_anomaly$observed), type = 'l')
#data set with differences
df_new <- cbind(x, y)


plot_ly
sd(not_anomaly$observed)
sd(subset$value)
# adf.test(not_anomaly$observed)
# plot(diff(not_anomaly$observed), type = 'l')


