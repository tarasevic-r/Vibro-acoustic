# Check accuracy
# 2020-01-22 T10:30 RT

# check rmse
print(Metrics::rmse(x, y_predicted))

# plot rmse results dependet on forecast range
plot(results$RMSE, type = 'l')