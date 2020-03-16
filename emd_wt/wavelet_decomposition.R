# Wavelet decomposition
# perform wavelet transform
wd <- wavelets::dwt(s, filter = "d4")
wavelets::plot.dwt(wd)
# summary(wd@V$V3)
# W - wavelet coefficients (high pass filter, detail coefficients) - mother wavelet
# The detail coefficients represent the output of the high pass filter (difference filter) of the DWT.
#
# V - scale coefficients (low pass filter, approximation coefficients) - father wavelet
# The approximation coefficients represent the output of the low pass filter (averaging filter)
#of the DWT.
#
#By applying the DWT again on the approximation coefficients of the previous DWT,
#we get the wavelet transform of the next level.

