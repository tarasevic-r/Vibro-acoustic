


rm(list=ls())

# load data
d <- read.csv("C:/Users/user2/Downloads/d_sample_sma.csv")


# converte into POSIXct
d$timestamp <- as.POSIXct(d$timestamp)
d$timestamp <- as.numeric(d$timestamp)


dw = 100
idx = 0


# Empty data frame
results <- data.frame()

# mode function
Mode_f<-function(x) {
  Mx<-unique(x)
  Mx[which.max(tabulate(match(x,Mx)))]
}


for (idx in 1:93) {
  
  # idx from
  from = idx * dw + 1
  
  # idx to
  to = idx * dw + dw
  
  result <-
    data.frame(
      idx = idx
      , mode = Mode_f(diff(d$timestamp[from:to]))
    )
  
  results <- rbind(results, result )  
  
}

Mode_f(results$mode)

barplot(table(results$mode))
