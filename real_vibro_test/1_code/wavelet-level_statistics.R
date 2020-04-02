par(mfrow=c(1,1))
# set data window parameters
# s_orig=signal::decimate(s_orig, 10 )
# plot.ts(s_orig)
n=11 #15
from = 1
to = 2^n
dw = 2^n
slide = dw/4


s = s_orig[1:dw]


plot(Mod(fft(s)), type = 'h',xlim=c(0,dw/2))
quant <- quantile(Mod(fft(s)[1:1024]), 0.95)
max_fr = max(which(Mod(fft(s)[1:512]) > quant))

# Empty table for statistics
statistika <- data.frame()

index = data.frame()
# decomposition level

l=1
size = 2^l

while((size/2) <= max_fr){
  l = l+1
  size = 2^l
}

l = l-1 #n-5 # detail coefficients number = 2^l
2^l

while((to+slide) <= length(s_orig)) {
  s <- s_orig[from:to]
  source("family_selection.R")
  # source("threshold.R")
  s_dwt <- wavethresh::wd(s)
  
  #
  
  detail_coeff <- accessD(s_dwt, level = l) # detail coeff

  # energija <- rbind(energija, statistics_function(detail_coeff))
  statistika <- rbind(statistika, statistics_function(detail_coeff))

  index <- rbind(index, best_index)
  # 
  # source("sub-band_energy.R")
  # energija <- rbind(energija, t(sub_energy))

  to = to+slide
  from=from+slide
  
}
# plot.ts(index)
# statistika <- cbind(statistika, index)
head(statistika)
plot.ts(statistika$shape_factor)
# write energy to csv
write.csv(statistika, file = "../4_data/statistika.csv")

# statistika$entropy[!is.finite(statistika$entropy)] <- 0
vec = scale(statistika)
# vec = vec[,-3]
