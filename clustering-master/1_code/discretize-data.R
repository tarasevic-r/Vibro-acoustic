## discretize data
# Ref: <https://www.rdocumentation.org/packages/arules/versions/1.6-4/topics/discretize>
## Review: 2020-01-07T1635 AU


# load selected data
load('../4_data/3.RData')


## check amount of complete cycles based on memory_size
(nrow(d) %/% memory_size)
# AU: we have 451 full cycles
(nrow(d) %% memory_size)
# AU: we need to exclude last 255 records

# AU: keep number of rows equal to the interval size
d <- d[1:(nrow(d) %/% memory_size * memory_size),]


ifelse(
  nrow(d) > memory_size
  , {
    
    ## 1. discretize variable `timestamp` ####
    x <- 'timestamp'
    
    # separate field
    dd <- as.integer(d[,x])
    
    ### look at the distribution before discretizing
    hist(dd, breaks = 20, main = x)
    
    # def.par <- par(no.readonly = TRUE) # save default
    # layout(mat = rbind(1:2,3:4))
    
    ### convert continuous variables into categories: equal interval width
    table(dd_disc_time <- arules::discretize(dd, method = "interval", breaks = memory_size))
    hist(dd, breaks = 20, main = "Equal Interval length")
    abline(v = arules::discretize(dd, method = "interval", breaks = memory_size, onlycuts = TRUE), col = "red")
    
    head(dd_disc_time)
    
    # capture discretized breaks
    dd_disc_time_breaks <- as.integer(attr(dd_disc_time, 'discretized:breaks'))
    
    # cut data to periods
    timestamp_cut <- as.integer(cut(dd, breaks = dd_disc_time_breaks))
    
    ## only choose those moment from data
    # d_disc_timed <- d[d$timestamp %in% dd_disc_time,]
    # AU: none data selected, because the time stamps are not correct
    
    ## export to file
    write.csv(
      dd_disc_time_breaks
      , '../4_data/dd_disc_time.csv'
      , row.names = F
    )
    
    
    ## 2. discretize variable `value` ####
    x <- 'value'
    
    head(d[,x])
    
    # separate field
    dd <- d[,x]
    
    ### look at the distribution before discretizing
    hist(dd, breaks = 20, main = x)
    
    # def.par <- par(no.readonly = TRUE) # save default
    # layout(mat = rbind(1:2,3:4))
    
    ### equal interval width
    table(dd_disc_value <- arules::discretize(dd, method = "interval", breaks = my_breaks))
    hist(dd, breaks = 20, main = "Equal Interval length")
    abline(v = arules::discretize(dd, method = "interval", breaks = my_breaks, onlycuts = T), col = "red")
    
    # discretized BREAKS
    dd_disc_value_breaks <- as.integer(attr(dd_disc_value, 'discretized:breaks'))
    
    value_cut <- as.integer(cut(dd, breaks = dd_disc_value_breaks))
    # head(value_cut)
    plot(table(value_cut))
    
    
    # discretized LEVELS
    # value_levels <- attr(dd_disc_value, 'levels')
    
    ## 
    # write.csv(dd_disc_value, 'dd_disc_value.csv')
    
    # d <- cbind(d, xxx)
    
    # d <- d[d$xxx <= 10,]
    
    # d <- na.omit(d)
    
    # head(d)
    
    # boxplot(d$value~d$xxx)
    
    
    
    # interactive plot:
    plotly::plot_ly(
      x = d$timestamp
      , y = d$xxx
      , type = 'scatter'
      , mode = 'lines'
    )
  }
  # if no:
  , cat('no discretization required')
)