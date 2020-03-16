# Extract NOT anomaly data points
# 2020-01-22 T10:48 RT


# NOT anomalies
not_anom <- df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly != 'Yes') 