par(mfrow=c(1,1))
# set data window parameters

n=11 #15
from = 1
to = 2^n
dw = 2^n
slide = dw/2


s = s_orig[1:dw]

plot(Mod(fft(s)), type = 'h',xlim=c(0,dw/2))
quant <- quantile(Mod(fft(s)[1:1024]), 0.95)
max_fr = max(which(Mod(fft(s)[1:512]) > quant))

u=1
size = dw/2^(u-1)

while((size/2) > max_fr) {
  u = u+1
  size = dw/2^(u-1)
}
u=u-1

if(u==2){
  u=u+1
}



#for vibration u=u+4
if(vibration ==T){
  u = u+4
  size = dw/2^(u-1)
}

cat(" Highest dominant harmonic: ", max_fr, '\n',
    "Wavelet decomposition level: ", (u-1), '\n',
    "Wavelet sub-bands number: ", 2^(u-1), '\n',
    "Sub-band size: ", size, '\n',
    "Data window size: ", dw, '\n',
    "Slide: ", slide)

