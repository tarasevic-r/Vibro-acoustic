## Data generation 
# 2020-01-16 T17:30 RT

# Samples
N = 100

# Time Vector
t = seq(0.01, 3, 1/N)

# Sampling Frequency
Fs = 1/(t[2]-t[1])

# Nyquist Frequency
Fn = Fs/2

# Data window size
dw_size <- length(t)/3

# Signal 10hz
s1 <-
  sin(2*pi*10*t[1:dw_size])


# Signal 20hz
s2<-
  sin(2*pi*20*t[(dw_size+1):(length(t)-dw_size)])

# Signal 40hz
s3<-
  sin(2*pi*40*t[((length(t)-dw_size)+1):length(t)])


# add all signals together
s <- s1 + s2 + s3

# s <- c(s1,s2,s3)

# plot signal
plot(x = t[1:dw_size], y = s, type = 'l', xlim = c(0, 1)
     , main = "Generated signal"
     , xlab = "t"
     , ylab = "amplitude"
)
