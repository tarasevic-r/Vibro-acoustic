# Time series decomposition into "seasonal", "trend" and "remainder" components
# 2020-01-22 T10:48 RT

# Detecting and flaging anomalies in decomposed data
df_ts %>% 
  anomalize::time_decompose(value, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(remainder, method = "gesd", alpha = 0.05, max_anoms = 0.2) %>%
  plot_anomaly_decomposition()