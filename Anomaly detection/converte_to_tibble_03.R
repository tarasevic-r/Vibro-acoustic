# Converting to tible object
# # 2020-01-22 T10:48 RT

df_ts <- subset %>% tibble::rownames_to_column() %>% as_tibble() %>% 
  mutate(date = as.POSIXct(timestamp)) %>% select(-one_of('rowname'))

# Head of sample data
head(df_ts)