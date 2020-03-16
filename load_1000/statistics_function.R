
# function for main statistics calculation
statistics <- function(sample_index, time, value, from, to) {
  data.frame(
    Sample_Index = sample_index
    , Length = length(time)
    , Sample_start = from
    , Sample_end = to
    , Mode_freq_t = as.integer(Mode_f(diff(time)))
    , Period_from = min(time)
    , Period_to = max(time)
    , Time_period = round((max(as.numeric(time)) - min(as.numeric(time)))/3600, 2)
    , Value_min = round(min(value, na.rm=T), 2)
    , Value_max = round(max(value, na.rm=T), 2)
    , Range = round(max(value, na.rm=T) - min(value, na.rm=T), 2)
    , Mean = round(mean(value, na.rm=T), 2)
    , Sd = round(sd(value, na.rm=T), 2)
    , Median = round(median(value, na.rm=T), 2)
  )
  
}


