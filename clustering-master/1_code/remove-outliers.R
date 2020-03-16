# Title: Remove Outliers
# Review: 2020-02-04T1424 AU
# URL: <http://r-statistics.co/Outlier-Treatment-With-R.html>


## collect outliers to a single place
outliers_df <- data.frame()


## iterate all columns from dataset
for(idx in 1:ncol(d)) {
  # idx <- 1
  
  
  ## notify user which step
  cat(idx, '\t', names(d)[idx], '\t')
  
  
  ## boxplot for single variable
  png(paste0('../3_figures/outliers_boxplot_', idx, '_', names(d)[idx], '.png'), width=300, height=600)
  boxplot(d[,idx], main = names(d)[idx])
  dev.off()
  
  
  ## identify outliers in chosen variables
  idx_outliers <-
    which(
      d[,idx] %in% boxplot.stats(d[,idx])$out
    )
  
  
  ## output info
  cat('outliers:', ifelse(length(idx_outliers) > 0, length(idx_outliers), 0), '\n')
  
  
  ## review properties
  d_outliers <- d[idx_outliers,idx]
  # summary(d_outliers)
  
  # d_outliers[-idx_outliers] <- 0
  # d_outliers[idx_outliers]
  
  
  
  ## Review outliers in original data
  # png(paste0('../3_figures/', 'outlier_', names(d)[idx], '.png'), width=1024, height=768)
  # plot(d[,idx], type='l')
  # points(d_outliers[idx_out], col='red')
  # text(x=1:(length(d[,idx])+1), y=d[,idx], labels=ifelse(d[,idx]>4*mean(d[,idx], na.rm=T),names(d[,idx]),""), col="red")
  # dev.off()
  
  # head(d[,idx])
  
  
  ## Append variable outliers to global outliers list
  outliers_df <- 
    rbind(
      outliers_df
      , cbind(
          'index' = idx_outliers
          , 'variable' = rep(names(d)[idx], len = length(idx_outliers))
        )
      )
}


## all outliers
outliers_unique <- c(unique(outliers_df$index))


## notify user
cat('unique outliers found:', length(outliers_unique))


## review outliers in raw data
d_outliers <- d[outliers_unique,]


## review statistical properties of outliers
summary(d_outliers)


## remove outliers
d <- d[-outliers_unique,]


## outlier counts
table(outliers_df$variable)


## top outliers by
head(table(outliers_df$variable),1)


## notify user
cat('Outliers: removed.\n')