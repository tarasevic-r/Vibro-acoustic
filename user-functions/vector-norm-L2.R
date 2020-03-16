# Title: vector L-2 norm |x|
# Review: 2020-01-15T1253 AU
# URL: <http://mathworld.wolfram.com/L2-Norm.html>

# Definition:
# vector `l^2 norm` |X| is a vector norm for a complex vector X = [x_1,..,x_n]
# by formula: |X|_2 = {sqrt}( {sum;k=1;n} (|x_k|^2) ), |x_k| = complex modulus

## function to calculate vector l2 norm

## define function
norm_l2 <- function(x) {
  if(class(x)=='complex')
	return(sqrt(sum(Mod(x^2))))
  else
	cat('Error: please provide a complex vector `x`\n')
}

## calculate l2 norm for FFT coefficients
(norm_l2_x <- norm_l2(Y))
