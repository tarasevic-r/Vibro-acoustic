# Title: Scale data
# Review: 2020-02-04T0958 AU


## scale data
d <-
  data.frame(
    scale(
      x = d
      , center = T
      , scale = T
    )
  )


# preview prepared data
head(d)


# # save loaded data in R format
# save(
#   d
#   , file='../4_data/5.Rdata'
# )


# end of chapter
cat('Data scaled.\n')
