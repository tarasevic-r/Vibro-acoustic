sample_stats <- data.frame()
entropy_sample <- data.frame()
# process_ffts <- data.frame()


stat <- function(signal, N=7, from, to) {
  data.frame(
    from = from,
    to = to,
    mean = mean(signal),
    entropy = wavelet_entropy(signal, N))
}


# data window size
dw = 16
slide = dw/4

# set starting sample index
j = 0

# Data window start in data set
from = j * dw + 1

# Data window end in data set
to = j * dw + dw

# iterate every data window size sample
while (to+slide <= length(s) ) {
  print(to)
  
  # cat(j, '/', ceiling(length(s)/slide)-6, '\t', 'samples', '\n')
  
  
  # data window size sample
  P_dw <- s[from:to]
  
  # Calculate sample statistics
  sample_stat <- stat(signal = P_dw, from = from, to = to)
    
    
    # #### wavelet coefficients entropy 2020.02.18 RT ####
  # entropy <- wavelet_entropy(P_dw$value, N = 7)
  
  
  ## export sample results
  # write.table(
  #   sample_stat
  #   , file = "../4_data/stats_samples.csv"
  #   , col.names = F
  #   , row.names = F
  #   , sep = ','
  #   , append = T
       
  
  
  sample_stats <- rbind(sample_stats, sample_stat)
  
  
  # move to next sample
  j = j + 1
  from = from + slide
  to = to + slide
  
  
}

sample_stats$mean <- MinMaxScale(sample_stats$mean)
sample_stats$entropy <- MinMaxScale(sample_stats$entropy)

sample_stats
write.csv(sample_stats, file="signal.csv", row.names = T)

plot(s, type = 'l')


