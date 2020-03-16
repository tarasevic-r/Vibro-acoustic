# User functions:
source("features_function.R")

#### sub-band energy calculation function ####
nodes <- function(wp, level, node, calculate = T ){
  # get node coefficients
  nodes <- getpacket.wp(wp, level = level, index = node)
  
  if(calculate == T){
    # if sub - band length is greater or equal to 8, calculate energy
    # if(length(nodes)/2 >= 8){
    
    # W <- getpacket.wp(wp, level = level, index = node)
    
    sum(abs(nodes)^2)
    
    # } 
    # print error if lenght is less
    # else{cat(" Error! \n Max freq we can detect in this node is:\t"
    #          ,length(getpacket.wp(s_wp, level = level, index = node))/2, "Hz" )}
  } else {return(nodes)}
}


#### zero crossing number function ####
zero_cross <- function(signal){
  
  up_down <- c(0, diff(sign(signal)))
  ix <- which(up_down != 0)
  
  return(length(ix))
}

##### mean crossing number function ####
signal = s
mean_cross <- function(signal){
  
  up_down <- c(0, diff(sign(mean(signal) - signal)))
  ix <- which(up_down != 0)
  
  return(length(ix))
}

##### percentils functino ####
percentils <- function(signal, prob){
  
  percentil <- data.frame(quantile(signal, probs = c(prob)))
  colnames(percentil) = NULL
  percentil <- percentil[,1]
  
  return(percentil)
}

#### statistics #####
statistics_function <- function(signal){
  data.frame(
    signal_length = length(signal),
    # n5 = round(percentils(signal, 0.05), 2),
    # n25 = round(percentils(signal, 0.25), 2),
    # n75 = round(percentils(signal, 0.75), 2),
    # n95 = round(percentils(signal, 0.95), 2),
    # median = round(median(signal), 2),
    # mean = round(mean(signal), 2),
    # sd = round(sd(signal), 2),
    energie = sum(abs(signal)^2),
    variance = round(var(signal), 2),
    kurtosis = round(e1071::kurtosis(s), 2),
    skewness = round(e1071::skewness(s), 2),
    rms = round(mean(sqrt(signal^2)), 2) # root mean squared value
    # kurtosis = round(kurtosis(signal),2),
    # zero_crossing = zero_cross(signal),
    # mean_crossing = mean_cross(signal)
    
  )
}

