
library(wavethresh)
wt <- wd(signal, family = "DaubLeAsymm", filter.number = 6, type = "wavelet", bc = "periodic")
wt2 <- wd(signal2, family = "DaubLeAsymm", filter.number = 6, type = "wavelet", bc = "periodic")

W1 = t(GenW(n = 8, filter.number = 8, family = "DaubLeAsymm"))

yy = DJ.EX()$doppler


plot(wt)
plot(wt2)



par(mfrow=c(1,1))
plot(accessD(wt, level = 8), type = 'l')
lines(accessD(wt2, level = 8), type = 'l', col ='red', lwd=2)

accessD(wt, level = 7)
wt2$C
wt2$D

C <- wt$C[257:length(wt$C)]
C <- matrix(C, ncol=wt$nlevels)
D <- wt$D
D <- matrix(D, ncol=wt$nlevels)

C2 <- wt2$C[257:length(wt2$C)]
C2 <- matrix(C2, ncol=wt2$nlevels)
D2 <- wt2$D
D2 <- matrix(D2, ncol=wt2$nlevels)

for(i in 1:(wt$nlevels-1)) {
  print(i)
  C[,i] <- as.integer(MinMaxScale(C[,i])*255)
  D[,i] <- as.integer(MinMaxScale(D[,i])*255)  
  
  C2[,i] <- as.integer(MinMaxScale(C2[,i])*255)
  D2[,i] <- as.integer(MinMaxScale(D2[,i])*255)
  
  
}

head(C)
head(D)
image(C[,1:(wt$nlevels-1)], col = gray((0:255)/255))
image(C2[,1:(wt$nlevels-1)], col = gray((0:255)/255))
par(mfrow=c(1,2))
image(D[,1:(wt$nlevels-1)], col = gray((0:255)/255))

image(D2[,1:(wt$nlevels-1)], col = gray((0:255)/255))

# 
# level_1 <- wt$D[1:256]
# level_2 <- wt$D[257:512]
# level_3 <- wt$D[513:768]
# level_4 <- wt$D[769:1024]
# level_5 <- wt$D[1025:1280]
# level_6 <- wt$D[1281:1536]
# level_7 <- wt$D[1537:1792]
# level_8 <- wt$D[1796:2048]
# 
# par(mfrow=c(1,1))
