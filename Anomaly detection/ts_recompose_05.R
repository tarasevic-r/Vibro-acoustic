# Timeseries recomposed back and ploted with detected anomalies
# # 2020-01-22 T10:48 RT

df_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.5)