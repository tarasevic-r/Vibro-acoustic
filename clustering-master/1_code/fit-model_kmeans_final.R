# Title: Clustering Sensor Data
# Review: 2020-01-28T0845 AU
# Chapter: Evaluate Model


# append clusters to raw data
# load('../4_data/3.RData')

# exclude first row for differences
# d <- d[2:nrow(d),]
# d_raw_sample <- d

# load prepared sampled data
# load('../4_data/5.RData')


# Final K-Means Clustering
m <-
  kmeans(
    dn
    , k_final
    , iter.max = 1000
    , nstart = 25
  )

# save model to file
save(m, file='../5_models/model_kmeans.Rdata')



# cleanup
# rm(d2) # raw data
