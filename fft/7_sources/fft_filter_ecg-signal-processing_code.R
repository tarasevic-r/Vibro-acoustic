# Title: ECG Signal Processing
# Review: 2020-01-15T1119 AU
# URL: <https://www.r-bloggers.com/ecg-signal-processing/>


cat(
'After reading (most of) \"The Scientists and Engineers Guide to Digital Signal Processing\" by Steven W. Smith, PhD, I decided to take a second crack at the ECG data.
I wrote a set of R functions that implement a windowed (Blackman) sinc low-pass filter.
The convolution of filter kernel with the input signal is conducted in the frequency domain using the fast Fourier transform, which is much of the focus of Smith\'s book.
The low-pass filter was first applied to eliminate the high frequency noise, anything greater than 30Hz.
I next applied the filter at a cutoff frequency of 1Hz in order to isolate the slow wave that corresponds to respirations.'
)


## Contents
# This file contains R code to:
# * read the ecg.csv file
# * perform some digital signal processing,
# * produce a plot ff the raw and filtered signals.


# Transform the real and imaginary portions of theFFT into magnitude and phase.
# The argument ff should be the output of the fft function
amplitude <- function( x ) { sqrt(Re(x)^2+Im(x)^2) }
phase     <- function( x ) { atan(Im(x)/Re(x)) }

#sinc function of frequency f
sinc      <- function( x, f ) { ifelse(x==0, 2*pi*f, sin(2*pi*f*x)/x) }

#Blackman window from 0..m
Blackman  <- function( m ) { 0.42-0.5*cos(2*pi*(0:m)/m)+0.08*cos(4*pi*(0:m)/m) }

#Hamming window from 0..m
Hamming   <- function( m ) { 0.54-0.46*cos(2*pi*(0:m)/m) }

#simple low pass filter
#y - vector to filter
#t - time interval between measurements (s)
#f - low pass frequency (Hz)
lpf <- function( y, t, f ) {
  rc <- 1 / ( 2 * pi * f )
  a  <- t / ( t + rc )
  n  <- length( y )
  yf <- y
  for( i in 2:length(y) ) {
    yf[i] <- a * y[i] + (1-a) * yf[i-1]
  }
  return( yf )
}  

#windowed sinc low pass filter
#y - vector to filter
#t - time interval between measurements (s)
#f - low pass frequency (Hz)
wlpf <- function( y, t, f ) {
  m  <- min(floor(length(y)/2), 500)
  #generate the sinc kernel
  rk <- sinc(-m:m, f*t)  
  #apply the Blackman window
  bk <- Blackman(2*m) * rk
  #pad the filter with zeros
  k  <- c(bk, rep(0,length(y)-length(bk)))
  #convolve y with the filter kernel
  fy  <- fft(fft(k)*fft(y), inverse=TRUE)
  return(Re(fy))
}


## Import data ####
# dat  <- scan("http://biostatmatt.com/csv/ecg.csv") # www version
dat  <- scan("../2_raw-data/ecg-signal-processing/ecg-signal-processing_data.csv")

## Process data ####
# standartization
dat  <- ( dat - mean(dat) ) / sd(dat)

#filter high frequency noise
fdat <- wlpf(dat, 1/1000, 30)
fdat <- (fdat-mean(fdat))/sd(fdat)

#isolate respiration bias
rdat <- wlpf(dat, 1/1000, 1)
rdat <- (rdat-mean(rdat))/sd(rdat)

#subtract respiration bias from ecg signal
edat <- fdat - rdat

require('lattice')
xplot <- rep((0:(length(dat)-1))/1000,4)
yplot <- c(dat, fdat, rdat, edat)
gplot <- c(rep("Raw",length(dat)),
           rep("High Frequency Filter",length(dat)),
           rep("Low Frequency Filter",length(dat)),
           rep("ECG",length(dat)))
tp <-
  xyplot(
    yplot~xplot|gplot
    , type="l"
    , layout=c(1,4)
    , xlab="Time"
    , ylab="V"
  )

#uncomment the following to save an image
#trellis.device(
#png
#, file="../3_figures/ecg-signal-processing_figure01.png"
#, height=750, width=750
#)
print(tp)
#dev.off()

## Sources ####
# Reproduce the analysis and the image giving the sequence of filtering by running the following command in R:
# source("http://biostatmatt.com/R/ecg.R")