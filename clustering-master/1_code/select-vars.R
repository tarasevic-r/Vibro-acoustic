# Title: Select variables
# Review: 2020-02-04T1200 AU



## id non-data features
X_remove <-
  c(
    'Sample_start'
    , 'Sample_end'
    , 'Max_diff_time_hours'
    , 'Period_from'   
    , 'Period_to'
  )


## remove non-data features
d <- d[,-which(names(d) %in% X_remove)]


cat('Non-data features: removed.\n')
