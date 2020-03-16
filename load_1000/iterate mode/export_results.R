## export results
write.csv(results, file = paste0(
  "results_"
  , N
  , "_files"
  , ".csv")
  , row.names = F )

## export files that contains less than 10 000 rows
write.csv(bad_results, file = paste0(
  "bad_results_"
  , "_files"
  , ".csv")
  , row.names = F )
