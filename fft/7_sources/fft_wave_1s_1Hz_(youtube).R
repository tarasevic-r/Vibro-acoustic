# 1 https://www.youtube.com/watch?v=mkGsMWi_j4Q&list=WL&index=45
# 2 https://betterexplained.com/articles/an-interactive-guide-to-the-fourier-transform/
# 3 https://riptutorial.com/r/example/14464/fourier-series


# Title

f <- 1 # 1 Hz

samples <- 256
sampling_frequency <- 1/samples

# generate a sequence of time steps (from, to, step size)
kn_N <-
  seq(
    from = 0
    , to = 1 # second!
    , by = sampling_frequency
  )


# generate wave 1
wave.1 <- sin(2*pi*kn_N)


# plot all waves
plot(
  x = kn_N
  , y = wave.1
  , col = 'blue'
  , type = 'l'
  , main = 'wave.1'
  , xlab = 'phase'
  , ylab = 'magnitude'
)

# which(wave.1==1)

fourier_transform <- fft(wave.1)

# remove all coefficients beyond Nyquist frequency / 2

## but double coefficients
fourier_transform <- 2*fourier_transform[0:(samples/2)+1]

plot(abs(Re(fourier_transform)), type='h')
# re <- Re(fourier_transform)
# im <- Im(fourier_transform)
0 -> fourier_transform[which(abs(Re(fourier_transform)) < 0.2)]

inverse_fft <-
  fft(
    fourier_transform
    , inverse = T
    )

plot(
  scale(wave.1)
  , col = 'green'
  , type='l'
  , main = 'FFT+iFFT - Raw (Green) + Inverted (Red)'
  )
points(
  scale(Re(inverse_fft))
  , col = 'red'
)

plot(Im(inverse_fft), type='l')

# plot one choisen point
choose_point <- 7
plot(
  re[choose_point]
  , im[choose_point]
  , xlim=c(0, re[choose_point])
  , ylim=c(0, im[choose_point])
  , main = paste('point:', choose_point)
  , xlab='Real'
  , ylab='Imaginary'
)
lines(
  c(0, re[choose_point])
  , c(0, im[choose_point])
  , col = 'red'
)

# calculate coefficient magnitude
( mag <-
    sqrt(
      re[choose_point]^2
      + im[choose_point]^2
    )
)


# calculate angle
( theta <-
    tan(im[choose_point]/re[choose_point])^-1
)


## periodogram
p <-
  TSA::periodogram(wave.1)

## analyze frequencies
dd = data.frame(freq=p$freq, spec=p$spec)
order = dd[order(-dd$spec),]
# display top frequencies
(top_frequencies = head(order, 3))
# convert frequency to time periods
(time = 1/top_frequencies$f)