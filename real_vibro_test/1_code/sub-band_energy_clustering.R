# normalize data
# dim(energija)

categor <- data.frame()
# loop every slide
for(i in 1:length(energija[1,])) {
  # classify energy values on one sub-band
  test = data.frame(energija[,i]) #i
  cat(i, '/', length(energija[1,]), '\n')  
  # perform classification
  result <- LPCM::ms(
    test,
    scaled=1,
    h=0.045,
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
  categor <- rbind(categor, data$label)
  # Sys.sleep(0.2)
}
# write results
write.csv(categor, file = "../4_data/categor.csv")
rownames(categor)=NULL
colnames(categor)=NULL
dim(categor)

cat('\n', 'categories saved as categor.csv', '\n',
    "--------------------------------", '\n'
    , "sub-band energy clustering DONE!")
