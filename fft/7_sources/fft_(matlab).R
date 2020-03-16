# URL: <https://www.mathworks.com/matlabcentral/answers/356692-how-to-normalize-a-fft-to-plot-in-frequency-domain#comment_484457>

# Samples
N = 100

# Time Vector
t = seq(0, 5*pi, 1/N)
# t = seq(0, 10*pi, 1/N)

# Sampling Frequency
Fs = 1/(t[2]-t[1])

# Nyquist Frequency
Fn = Fs/2

# Signal Vector
s1 <-
  sin(2*pi*0.5*t + pi/2) + cos(2*pi*0.5*t + pi/2)


s2 <-
  sin(2*pi*4*t) + cos(2*pi*4*t)
# 0.5 * sin(2*pi*3000*t) - 0.5 * cos(2*pi*3000*t) +
  # 0.1 * sin(2*pi*1000*t) + 0.1 * cos(2*pi*1000*t)

s <- c(s1, s2)

# x11()
plot(s, type='l', ylim=c(-1, 1))

# Perform and Normalise FFT
FTs = fft(s) / N
# The division by `N` is to normalise the Fourier transform for the energy in the signal.
# Normalise the fft by dividing it by the length of the _original signal_ in the time domain.
# The length to use to normalise the signal is the length before adding zero-padding.


# Frequency Vector (2-Sided)
# Fv2 = seq(-N/2, N/2, N)*Fs


# str(FTs)

# library('mrbsizeR')
# mrbsizeR::fftshift(as.matrix(FTs))
# ifftshift

#plot(Fv2, fftshift(FTs))

## Inverse FFt
IFTs = fft(FTs, inverse=T)*N
# Multiply By `N` To Reconstruct Signal


## custom function. Normalize data using Min Max (exclude NA values)
normalize <-
  function(x, na.rm = T) {
    ranx <- range(x, na.rm = na.rm)
    (x - ranx[1]) / diff(ranx)
  }


## Plot Scaled Original and Reconstructed Data
x11()
plot(
  normalize(s)
  , type='l'
  , main = 'Original (green) and Reconstructed (gold) Signals'
  , sub = 'Normalized with Min-Max'
  , col = 'green'
)
points(
  normalize(Re(IFTs))
  , col = 'gold'
)
