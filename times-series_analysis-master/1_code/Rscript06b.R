# Title: Outlier detection: IQR method
# Review: 2020-01-14T1501 AU
# URL: https://trainmydata.com/article/statistichieskiie-mietody-dlia-opriedielieniia-vybrosov-v-dannykh


### Outlier Detection: Inter-Quartile Range (IQR) method ####
## calculate inter-quartile range as difference between 3 and 1 quartils 

IQR <- as.numeric( d_Q3 - d_Q1 )
## lower threshold as 1st quartile minus 1.5 standard deviations
lower_IQR <- d_Q1 - 1.5*IQR
## upper threshold as 3rd quartile plus 1.5 standard deviations
upper_IQR <- d_Q3 + 1.5*IQR


## identify outliers using IQR method
outliers_IQR <-
  which(
    d$value < lower_IQR |
      d$value > upper_IQR
  )


## Print info to user
cat(
  'Outliers (IQR method):', length(outliers_IQR)
  , '\n'
)


## if any outliers found using IQR method, exclude outliers from data
if(length(outliers_IQR) > 0) {
  d_new <-
    subset(
      d
      , d$value > lower_IQR &
        d$value < upper_IQR
    ) # time series without extreme values
}