# library("LM")
# normalize data
dim(vec)
categor <- data.frame()
# loop every slide
for(i in 1:length(vec[1,])) {
  # classify energy values on one sub-band
  # i=1
  test = data.frame(vec[,i]) #i
  cat(i, '/', length(vec[1,]), '\n')  
  # perform classification
  result <- LPCM::ms(
    test,
    scaled=1,
    h = 0.05,
    plotms=-1)
  
  # assignment (labels)
  LPCM_assignment <- result$cluster.label
  
  # value
  LPCM_value <- result$cluster.center[LPCM_assignment,]
  
  # set labels for data
  data <- cbind(test, LPCM_assignment)
  
  colnames(data) <- c("value", "label")
  rownames(data) = NULL
  data = as.data.frame(data)
  # plot data 
  plot(data$value, col = data$label, lwd =2, pch=data$label )
  
  # add to categories data.frame
  categor <- rbind(categor, data$label) # row is a vector categories
}
# write results
write.csv(categor, file = "../4_data/categor.csv")
rownames(categor)=NULL
colnames(categor)=NULL
dim(categor)
# data$label <- as.factor(data$label)
# calculate "mean" category value of one energy subset
mean_cat = round(colMeans(categor),4)
mean_cat = scale(as.data.frame(mean_cat))
dim(mean_cat)
plot(mean_cat, type ='h')


#### classify categories by mean value ####


# perform classification of average energy categories
result <- LPCM::ms(
  mean_cat,
  scaled=1,
  h=0.05,
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

# plot data 
x11()
par(mfrow=c(2,1))
plot.ts(s_orig)
plot(data$value, col = data$label, lwd =2, pch=data$label )
