# Title: Data Dimensions and Summary
# Review: 2020-01-31T1716 AU
# Input: d
# Output: stats to /4_data


### Data Preview ####

## Data dimensions
dim(d)[1] ## rows
dim(d)[2] ## columns


## Summary of basic statistical data properties:
summary(d)


## assign local variable
x <- d$value


## collect basic statistics
stats <-
  data.frame(
    'min' = min(x)
    , 'Q_05%' = quantile(x, 0.05)
    , 'Q1' = quantile(x, 0.25)
    , 'mean' = mean(x)
    , 'median' = median(x)
    , 'Q3' = quantile(x, 0.75)
    , 'Q_95%' = quantile(x, 0.95)
    , 'max' = max(x)
    , 'sd' = sd(x)
    , 'var' = var(x)
  )


## try to export stats to file and catch errors
e <- simpleError("error: export to file")

tryCatch(
  expr =
    write.csv(
      stats
      , file = '../4_data/stats.csv'
      , row.names = F
    )
  , error = function(e) e
  , finally = cat("Stats exported to /4_data")
)
