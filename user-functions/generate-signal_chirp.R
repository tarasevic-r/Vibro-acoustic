# Title: generate Signal - Chirp
# Review: 2020-01-28T1112 AU

## Time Index
t0 <- 0; t1 <- 1; n <- 512; dt <- (t1-t0)/n
tt <- 1:n

## Generate Signal: Chirp
xt <- 2 * sin(2*pi * (tt + 0.002*( tt - 256)^2) / 16)
