## Normalize data using Min Max (exclude NA values)
normalize <-
  function(x, na.rm = TRUE) {
    ranx <- range(x, na.rm = na.rm)
    (x - ranx[1]) / diff(ranx)
  }
# call: normalize(x)
