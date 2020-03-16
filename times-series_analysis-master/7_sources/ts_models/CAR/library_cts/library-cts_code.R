install.packages("cts")

library("cts")
data("V22174")
R> plot(V22174, type = "l", xlab = "Time in kiloyears", ylab = "")
R> rug(V22174[, 1], col = "red")