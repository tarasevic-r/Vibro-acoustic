library("emuR")

plot(s, type ='l')

melfb <- melfilterbank(f=1024, wl = 512, m = 26, plot = T)

library("e1071")
hamming <- e1071::hamming.window(512)

dw= 512
slide = dw/4

# set starting sample index
j = 0

# Data window start in data set
from = j * dw + 1

# Data window end in data set
to = j * dw + dw

# empty table for results
filterbanks <- data.frame(num=c(1:12))
# filterbanks <- data.frame()

# iterate every data window size sample
while (to+slide <= length(s) ){
  filterbank <- data.frame()
  # fft with slide
  s_fft <- fft(s[from:to]*hamming)/length(dw) # multiplied by hamming window 2020.03.04
  pwr_sp <- Mod(s_fft)[1:(dw/2)]
  
  
  # calculate Melt cepstrum..
  for(i in 1:26){
    print(i)
    # i=1
    filter_energy <- sum(pwr_sp*melfb$amp[,i])
    
    filterbank <- rbind(filterbank, filter_energy)
    # plot(pwr_sp*melfb$amp[,i], type ='l')
    # Sys.sleep(0.1)
  }
  # log filter banks energy
  log_filte <- log(filterbank)
  
  # perform descrete cosine transform on log energy
  dct_coeff <- emuR::dct(log_filte[,1])[2:13] # MFCC
  filterbanks <- cbind(filterbanks, dct_coeff) # changed cbind to rbind and mean added
  
  j = j + 1
  from = from + slide
  to = to + slide
  
}

# plot all MFCC 
# plot(filterbanks$X.0.0803212360937434, type = 'l')
plot(filterbanks[,2], type = 'l', lwd = 2, ylim = c(-.20, .15))
for(l in 3:length(filterbanks)){
  lines(filterbanks[,l], lwd = 2, col=l)
  Sys.sleep(0.3)
}


write.csv(filterbanks, file = "MFCC.csv")
summary(filterbanks)
# 
# filterbanks <- data.frame()
# 
# # calculate Melt cepstrum..
# for(i in 1:26){
#   print(i)
#   filter_energy <- sum(pwr_sp*melfb$amp[,i])
#   
#   filterbanks <- rbind(filterbanks, filter_energy)
# }
# 
# # log filter banks energy
# log_filte <- log(filterbanks)
# library("emuR")
# # perform descrete cosine transform on log energy
# dct_coeff <- dct(log_filte[,1])[2:13] # MFCC
# # dct_coeff2 <- dct(log_filte[,1])[2:13]
# 
# 
# 
# plot(dct_coeff, type = 'l')
# lines(dct_coeff2, col='blue')
# dist(rbind(dct_coeff, dct_coeff2), method = "manhattan") # 0.218
# 
