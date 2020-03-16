# Extract actual anomaly data points
# 2020-01-22 T10:48 RT

# Extracting actual anomaly data points
df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly == 'Yes') 


# Anomalies
anom <- df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly == 'Yes') 

