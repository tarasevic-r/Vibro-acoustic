# check and creat modes table
mode_table <- results_clean$Mode_freq_t
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
ro <- round(cor(x = results_clean[X_statistics]), 2)

# Mode correlation with other statistics
ro[,1]

# plot correlations
corrplot::corrplot(ro)
## AU: top variables are value_min, sd, and Mean (above 0.4)

X_cor <- c('Sample_Index', 'Mode_freq_t', 'Value_min', 'Sd', 'Mean')

# mode with most correlated variables table
results_clean. <- results_clean[,X_cor]
head(results_clean., 3)

boxplot(results_clean.$Mode_freq_t ~ results_clean.$Time_period)
boxplot(results_clean.$Mode_freq_t ~ results_clean.$Value_min)
boxplot(results_clean.$Mode_freq_t ~ results_clean.$Sd)
plot(results_clean.$Mode_freq_t, results_clean.$Mean)


## review avergae time period per mode
mean_mode <- aggregate(results_clean$Time_period, by = list(results_clean$Mode_freq_t), FUN = mean)
names(mean_mode) <- c('mode', 'mean_period')
head(mean_mode)
plot(x = mean_mode$mode, y = mean_mode$mean_period, type='h')
## AU: smaller mode relates to smaller period