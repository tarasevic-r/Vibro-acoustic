# URL: https://www.rdocumentation.org/packages/pracma/versions/1.9.9/topics/ifft
# Review: 2020-01-09 AU

## Library ####
library('pracma')


## Data ####

# generate data
x <- c(1, 2, 3, 4, 5, 6, 7, 8)

# perform Fast Fourier Transform
(y <- fft(x))

# Performs the inverse Fast Fourier Transform on original data
pracma::ifft(x)

# 3. Performs the inverse Fast Fourier Transform on result
xx <- pracma::ifft(y)

# 4. Data window
dw <- 4

# select data
row_from <- 1
row_to <- row_from+dw-1

sample <- x[row_from:row_to]

# examples
x1 <- c(1,2,3,3)
x2 <- c(4,2,3,4)

# plot x
plot(sample, type='h')
lines(x1, col='red')
lines(x2, col='green')

# specify distance function: L1
my_manhattan_dist <- function(vector1, vector2){
  distance <- abs(vector1-vector2)
  distance <- sum(distance)
  return(distance)
}

# specify distance function
my_chebyshev_dist <- function(vector1, vector2){
  distance <- abs(vector1 - vector2)
  distance <- max(distance)
  return(distance)
}


# get actual distances
my_manhattan_dist(sample, x1)
my_manhattan_dist(sample, x2)
my_manhattan_dist(x1, x2)

# get actual distances
my_chebyshev_dist(sample, x1)
my_chebyshev_dist(sample, x2)
my_chebyshev_dist(x1, x2)


##  Compute the derivative: F(df/dt) = (1i*k) * F(f)
#   hyperbolic secans f <- sech
df <- function(x) -sech(x) * tanh(x)
d2f <- function(x) sech(x) - 2*sech(x)^3
L <- 20                                 # domain [-L/2, L/2]
N <- 128                                # number of Fourier nodes
x <- linspace(-L/2, L/2, N+1)           # domain discretization
x <- x[1:N]                             # because of periodicity
dx <- x[2] - x[1]                       # finite difference
u <- sech(x)                            # hyperbolic secans
u1d <- df(x); u2d <- d2f(x)             # first and second derivative
ut <- fft(u)                            # discrete Fourier transform
k <- (2*pi/L)*fftshift((-N/2):(N/2-1))  # shifted frequencies
u1 <- Re(ifft((1i*k) * ut))             # inverse transform
u2 <- Re(ifft(-k^2 * ut))               # first and second derivative
## Not run: 
plot(x, u1d, type = "l", col = "blue")
points(x, u1)
grid()
figure()
plot(x, u2d, type = "l", col = "darkred")
points(x, u2)
grid()
## End(Not run)
