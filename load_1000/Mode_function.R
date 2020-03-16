# mode function

Mode_f<-function(x) {
  Mx<-unique(x)
  Mx[which.max(tabulate(match(x,Mx)))]
}