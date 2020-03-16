
# function for main statistics calculation
statistics <- function(file_index, sample_index, time, value) {
  data.frame(
    Name = file_names[file_index]
    , Index = sample_index
    , mode = as.integer(Mode_f(diff(time)))
    , From = min(time)
    , To = max(time)
    , Time_period = round((max(as.numeric(time)) - min(as.numeric(time)))/3600, 2)
    , Count.of.NA= length(value[is.na(value)])
    , Min = round(min(value, na.rm=T), 2)
    , Max = round(max(value, na.rm=T), 2)
    , Range = round(max(value, na.rm=T) - min(value, na.rm=T), 2)
    , Mean = round(mean(value, na.rm=T), 2)
    , Sd = round(sd(value, na.rm=T), 2)
    , Variance= round(var(value, na.rm=T), 2)
    , Median = round(median(value, na.rm=T), 2)
    , Length = length(time)
  )
  
}