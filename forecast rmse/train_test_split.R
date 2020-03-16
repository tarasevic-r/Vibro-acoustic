# Split training ant test data sets
# 2020-01-22 T10:30 RT

# Train set
y <- x[1:((nrow(x)*.7)+1)]
y_predicted <- y

# Test set
y.te <- x[((nrow(x)*0.7)+1):nrow(x)]