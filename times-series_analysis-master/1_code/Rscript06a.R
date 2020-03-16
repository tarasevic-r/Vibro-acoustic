# Title: Outlier Detection: boxplot method
# Review: 2020-01-14T1501 AU
# URL: https://trainmydata.com/article/statistichieskiie-mietody-dlia-opriedielieniia-vybrosov-v-dannykh


### Outlier Detection: boxplot method ####

# If any found, then outliers are marked as points outside box and whiskers:

## plot boxplot for outlier
boxplot(
  d$value
  , main = 'Boxplot chart'
  , ylab = 'value'
)


## numeric outliers using `boxplot.stats`
outliers_box <- boxplot.stats(d$value)$out

## Print info to user
cat(
  'Outliers (boxplot method):', length(outliers_box)
  , '\n'
)


## if any outliers found using IQR method, exclude outliers from data
if(length(outliers_box) > 0) {
  d_new <-
    subset(
      d
      , ! d$value %in% outliers_box
    ) # time series without extreme values
}