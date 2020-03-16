setwd("C:/Users/user2/Desktop/code/IMF's FFT")
# source("fft_filter.R")
source("main_n_fft_coef.R")

xs <- seq(-2*pi, 2*pi, pi/100)
noise <- rnorm(401, 2, 0.2)

# simulate signals with random noise
wave_1 <- sin(3*xs) + cos(0.5*xs) + noise
# wave_2 <- 13*sin(12*xs^2) + 3*cos(5*xs^2) + noise
wave_2 <- sin(3*xs) + cos(2*xs) + noise
# wave_3 <- 2*sin(12*xs) + 0.5*cos(5*xs) + noise
wave_3 <- 4*sin(0.4*xs) + 0.5*cos(2.6*xs) *0.8 + sin(1.4*xs) + noise

TSA::periodogram(wave_1)
TSA::periodogram(wave_2)
TSA::periodogram(wave_3)

# plot signals
par(mfrow=c(3,1))
plot(wave_1, type = 'l')
plot(wave_2, type = 'l')
plot(wave_3, type = 'l')


# perform emd
emd_wave <- EMD::emd(wave_1)
emd_wave_2 <- EMD::emd(wave_2)
emd_wave_3 <- EMD::emd(wave_3)

cat(' wave_1 imf\'s number:', emd_wave$nimf, '\n',
    'wave_2 imf\'s number:', emd_wave_2$nimf, '\n',
    'wave_3 imf\'s number:', emd_wave_3$nimf, '\n')

# extract 1st imf's
imf_1_1 <- emd_wave$imf[,1]
imf_1_2 <- emd_wave_2$imf[,1]
imf_1_3 <- emd_wave_3$imf[,1]

# 1st imf's plot
plot(imf_1_1, type = 'l')
plot(imf_1_2, type = 'l')
plot(imf_1_3, type = 'l')

# calculate distance between 1st imf's
dist(rbind(
  imf_1_1, imf_1_2, imf_1_3
))

# 1st imf's main fft coeficients
fft_1_1 <- stats::fft(imf_1_1)
coef_1_1 <- main_coef(fft_1_1, 5)  
fft_1_2 <- stats::fft(imf_1_2)
coef_1_2 <- main_coef(fft_1_2, 5)  
fft_1_3 <- stats::fft(imf_1_3)
coef_1_3 <- main_coef(fft_1_3, 5)  
fft_1_3[coef_1_3]
# coeficients table
tbl_1 <- data.frame(abs(fft_1_1[coef_1_1]), abs(fft_1_2[coef_1_2]), abs(fft_1_3[coef_1_3]))
print(tbl_1)

########################################
 
# extract 2nd imf's
imf_2_1 <- emd_wave$imf[,2]
imf_2_2 <- emd_wave_2$imf[,2]
imf_2_3 <- emd_wave_3$imf[,2]

# 2nd imf's plot
plot(imf_2_1, type = 'l')
plot(imf_2_2, type = 'l')
plot(imf_2_3, type = 'l')

# calculate distance between 2st imf's
dist(rbind(
  imf_2_1, imf_2_2, imf_2_3
))

# 2nd imf's main fft coeficients
fft_2_1 <- stats::fft(imf_2_1)
coef_2_1 <- main_coef(fft_2_1, 5)  
fft_2_2 <- stats::fft(imf_2_2)
coef_2_2 <- main_coef(fft_2_2, 5)  
fft_2_3 <- stats::fft(imf_2_3)
coef_2_3 <- main_coef(fft_2_3, 5)  
# coeficients table
tbl_2 <- data.frame(coef_2_1, coef_2_2, coef_2_3)
print(tbl_2)

#####################################################

# extract 3rd imf's
imf_3_1 <- emd_wave$imf[,3]
imf_3_2 <- emd_wave_2$imf[,3]
imf_3_3 <- emd_wave_3$imf[,3]

# 3rd imf's plot
plot(imf_3_1, type = 'l')
plot(imf_3_2, type = 'l')
plot(imf_3_3, type = 'l')

# calculate distance between 3rs imf's
dist(rbind( ## we can see obvious different between waves
  imf_3_1, imf_3_2, imf_3_3 ## and distance shows same result
))       

# 3rd imf's main fft coeficients
fft_3_1 <- stats::fft(imf_3_1)
coef_3_1 <- main_coef(fft_3_1, 5)  
fft_3_2 <- stats::fft(imf_3_2)
coef_3_2 <- main_coef(fft_3_2, 5)  
fft_3_3 <- stats::fft(imf_3_3)
coef_3_3 <- main_coef(fft_3_3, 5)  
# coeficients table
tbl_3 <- data.frame(coef_3_1, coef_3_2, coef_3_3)
print(tbl_3)

################################################

# extract 4th imf's
imf_4_1 <- emd_wave$imf[,4]
imf_4_2 <- emd_wave_2$imf[,4]
imf_4_3 <- emd_wave_3$imf[,4]

# 4th imf's plot
plot(imf_4_1, type = 'l')
plot(imf_4_2, type = 'l')
plot(imf_4_3, type = 'l')

# calculate distance between 4th imf's
dist(rbind(
  imf_4_1, imf_4_2, imf_4_3
))

# 4th imf's main fft coeficients
fft_4_1 <- stats::fft(imf_4_1)
coef_4_1 <- main_coef(fft_4_1, 5)  
fft_4_2 <- stats::fft(imf_4_2)
coef_4_2 <- main_coef(fft_4_2, 5)  
fft_4_3 <- stats::fft(imf_4_3)
coef_4_3 <- main_coef(fft_4_3, 5)  
# coeficients table
tbl_4 <- data.frame(coef_4_1, coef_4_2, coef_4_3)
print(tbl_4)




