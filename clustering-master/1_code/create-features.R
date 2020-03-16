# Title: Clustering Sensor Data
# Review: 2020-01-07T1454 AU
# Chapter: Create features


## separate classes of frequency ####

# load data 3

# label data with class
x <- 'class'
xx <- 'value'
d[,x] <- '' # initiate new feature
d[d[,xx] > 6000,x] <- 'E' # 
d[d[,xx] > 3000 & d[,xx] <= 6000,x] <- 'D' # 
d[d[,xx] > 1500 & d[,xx] <= 3000,x] <- 'C' # 
d[d[,xx] > 800 & d[,xx] <= 1500,x] <- 'B' # 
d[d[,xx] <= 800,x] <- 'A'

# table
t_x <- table(d[,x])
round(prop.table(t_x) * 100, 2)


# pie chart
x <- 'class'

pie(
  t_x
  , main = paste0(x, ': pie chart')
  , labels =
    paste0(
      names(t_x)
      , ': '
      , round(prop.table(t_x) * 100, 2)
      , '%'
    )
  , col = rainbow(length(t_x))
)

barplot(
  t_x
  , main = paste0(x, ': barplot')
  , names.arg =
    paste0(
      names(t_x)
      , ': '
      , round(prop.table(t_x) * 100, 2)
      , '%'
    )
  , col = rainbow(length(t_x))
)


# boxplot both classes
boxplot(
  d$value ~ d$class
  , main = 'process class by value boxplot based on density plot'
  , col = rainbow(length(t_x))
)


# density plot
x <- 'value'

def.par <- par(no.readonly = T) # save default
layout(mat = rbind(1,2:6))

# par(mat=c(1,2:6))
plot(density(d[,x]), main=paste0(x, ': full data')) # all
plot(density(d[d$class == 'A',x]), main=paste0(x, ': class A'))
plot(density(d[d$class == 'B',x]), main=paste0(x, ': class B'))
plot(density(d[d$class == 'C',x]), main=paste0(x, ': class C'))
plot(density(d[d$class == 'D',x]), main=paste0(x, ': class D'))
plot(density(d[d$class == 'E',x]), main=paste0(x, ': class E'))
par(mfrow=c(1,1))

