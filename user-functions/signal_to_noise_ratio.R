# Title: User Function `signal_to_noise_ratio`
# Review: 2020-01-31T1221 AU


#' Signal/Noise ratio
#'
#' @export SNR
#' @param x Original reference signal.
#' @param y Restored or noisy signal.
#' @return Signal/Noise ratio.
#' @examples
#' n <- 2^4
#' x <- MakeSignal('HeaviSine', n)
#' y <- x + rnorm(n, mean=0, sd=1)
#' SNR(x, y)
#' URL: <https://github.com/fabnavarro/rwavelet/blob/master/R/SNR.R>


signal_to_noise_ratio <- function(x, y) {
  v <- 20 * log10(normvec(as.vector(x))/normvec(as.vector(x) - as.vector(y)))
  return(v)
}

# Written by Maureen Clerc and Jerome Kalifa, 1997
# clerc@cmapx.polytechnique.fr, kalifa@cmapx.polytechnique.fr

# Part of Wavelab Version 850 Built Tue Jan 3 13:20:39 EST 2006 This is
# Copyrighted Material For Copying permissions see COPYING.m Comments? e-mail
# wavelab@stat.stanford.edu
