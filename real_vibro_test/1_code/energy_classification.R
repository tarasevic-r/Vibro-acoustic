
#### classify categories by mean value ####

# perform classification of average energy categories
result <- LPCM::ms(
  mean_cat,
  scaled=1,
  h=0.035,
  plotms=-1)

# assignment (labels)
LPCM_assignment <- result$cluster.label

# value
LPCM_value <- result$cluster.center[LPCM_assignment,]

# set labels for training data
data <- cbind(mean_cat, LPCM_assignment)

colnames(data) <- c("value", "label")
rownames(data) = NULL
data = as.data.frame(data)

Sys.sleep(0.5)
# plot data
x11()
par(mfrow=c(2,1))
plot.ts(s_orig, ylab = "value", main = "Original signal")
plot(data$value, col = data$label, lwd =2, pch=data$label
     , ylab = NULL, main = "Clustered signal")

cat('', length(unique(data$label)), "categories found", '\n',
"signal clustering DONE!")  
