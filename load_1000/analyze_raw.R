# check and creat modes table
mode_table <- results$Mode_freq_t
t <- table(mode_table)

# bind mode, freq and % in all data set
t_pt <- data.frame(cbind(
  mode = as.numeric(names(t))
  , freq = as.numeric(t)
  , prop = as.numeric(round(prop.table(t)*100, 2))
))

# order modes descending by frequency
t_pt <- t_pt[ order(-t_pt$freq), ]

# show top 3 modes
top_3 <- t_pt[1:3, ]

# vector of statistics to check correlation
X_statistics <- c("Mode_freq_t", "Time_period"
                  , "Value_min", "Value_max"
                  , "Range", 'Mean', 'Sd'
                  , 'Median', 'Sample_Index')

# Calculate correlation between statistics
ro <- round(cor(x = results[X_statistics]), 2)

# Mode correlation with other statistics
ro[,1]

# plot correlations
corrplot::corrplot(ro)
## AU: top variables are value_min, sd, and Mean (above 0.4)

X_cor <- c('Sample_Index', 'Mode_freq_t', 'Value_min', 'Sd', 'Mean')

# mode with most correlated variables table
results. <- results[,X_cor]
head(results., 3)

boxplot(results.$Mode_freq_t ~ results.$Time_period)
boxplot(results.$Mode_freq_t ~ results.$Value_min)
boxplot(results.$Mode_freq_t ~ results.$Sd)
plot(results.$Mode_freq_t, results.$Mean)


## review avergae time period per mode
mean_mode <- aggregate(results$Time_period, by = list(results$Mode_freq_t), FUN = mean)
names(mean_mode) <- c('mode', 'mean_period')
head(mean_mode)
plot(x = mean_mode$mode, y = mean_mode$mean_period, type='h')
## AU: smaller mode relates to smaller period


mean_sd <- aggregate(results$Sd, by = list(results$Mode_freq_t), FUN = mean)
names(mean_mode) <- c('mode', 'mean_Sd')
head(mean_mode)
plot(x = mean_mode$mode, y = mean_mode$mean_Sd, type='l')
## AU: 35 is the threshold for low mode - cut?

head(results[results$Mode_freq_t==8,])


hist(results$Value_min)
# remove records <= 2000

P. <- P[P$value >= 3000,]
cat('rows removed:',round((1 - (nrow(P.) / nrow(P)))*100, 2),'%')

plot(P$timestamp, P$value, type = 'l')
lines(P.$timestamp, P.$value, col = 'darkseagreen3')

