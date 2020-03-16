# Title: Outlier detection: three standard deviations method
# Review: 2020-01-14T1502 AU
# URL: https://trainmydata.com/article/statistichieskiie-mietody-dlia-opriedielieniia-vybrosov-v-dannykh


### Outlier Detection: Three standard deviations method ####

# use statistics calculated before
d_mean
d_sd


## calculate limits for outlier detection as three standard deviations
cut_off = d_sd * 3
lower_SD = d_mean - cut_off
upper_SD = d_mean + cut_off


## identify outliers using `three standard deviations` rule
outliers_SD <-
  which(
    d$value < lower_SD |
      d$value > upper_SD
  )


## Print info
cat(
  'Outliers (3*SD method):', length(outliers_SD)
  , '\n'
)


## if any outliers found using IQR method, exclude outliers from data
if(length(outliers_SD) > 0) {
  d_new <-
    subset(
      d
      , d$value > lower_SD &
        d$value < upper_SD
    )
}
