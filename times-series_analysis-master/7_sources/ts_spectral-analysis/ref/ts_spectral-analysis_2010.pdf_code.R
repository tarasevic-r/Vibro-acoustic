t <- seq(0, 256, 0.1)
head(t)

x <- cos(2*pi*t/16) + 0.75*sin(2*pi*t/5)
plot(x, type='l')

par(mfrow=c(2,1))
plot(t,x,'l')
spectrum(x)
