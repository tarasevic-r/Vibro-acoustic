# Title: Prepare Data - Min Max Scale
# Review: 2020-02-04T1426 AU

## scaledata using min-max
d <- data.frame(sapply(d, MinMaxScale))

## notify user
cat('Data: min-max-scaled.\n')