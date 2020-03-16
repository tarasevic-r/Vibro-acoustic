## calculate periodogram
p <- TSA::periodogram(P$value)

## plot periodogram
plot(
  x = p$freq
  , y = p$spec
  , log = 'y'
  , type = 'h'
  , main = 'Power Spectrum'
  , sub = 'log'
  )
