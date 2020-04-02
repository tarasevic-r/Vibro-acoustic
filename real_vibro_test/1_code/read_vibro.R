d1 = rmatio::read.mat("../../data/VIBRO/data 1/healthy/H-A-1.mat")
d2 = rmatio::read.mat("../../data/VIBRO/data 1/healthy/H-B-1.mat")
# d2 = rmatio::read.mat("../../data/VIBRO/bearing data/normal_2.mat")
# d3 = rmatio::read.mat("../../data/VIBRO/bearing data/IR014_2.mat")
# d4 = rmatio::read.mat("../../data/VIBRO/bearing data/B007_3.mat")
# d5 = rmatio::read.mat("../../data/VIBRO/bearing data/B021_1.mat")




d = c(d1$Channel_1,
      d2$Channel_1)

s_orig = d

s_orig=signal::decimate(s_orig, 10 )

if (graph == T) {
  png(filename = paste0("../3_figures/vibration.png")
      , width = 2048, height = 1024)
  
  par(mfrow=c(1,1))
  plot(s_orig, type = 'l',
       ylab = "value", main = "Vibration signal")
  dev.off()
  
  plot(s_orig, type = 'l',
       ylab = "value", main = "Vibration signal")
}
###### 

cat("\n", 'Original signal decimated by 10', '\n',
    '--------------------------------', '\n',
    'Decimated sgnal LOADED and SAVED!')