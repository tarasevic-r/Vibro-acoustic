# isskaidyti i dw = 100
# paskaiciuoti laiko diff kiekvienam lange ir paziureti kokia moda gaunasi
# galiausiai ideti i slenkanti langa

rm(list=ls())

# load data
d <- read.csv("C:/Users/user2/Downloads/d_sample_sma.csv")

# converte into POSIXct
d$timestamp <- as.POSIXct(d$timestamp)

dw = 100
idx = 0


# 
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

plot(results$X16, type = 'l')
