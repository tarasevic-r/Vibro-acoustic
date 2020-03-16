# 1. threshold wavelet decomposition
# 2. select packets bassis using lowest cost function
# 3. reconstruct signal after threshold removing and basis selection
library("wavethresh")

# wavelet packet transform
s_wst <- wavethresh::wp(s, filter.number = 4, family = "DaubLeAsymm")

# threshold the coefficients
s_wst_th <- threshold.wp(s_wst, levels = 1:9, by.level = T)#, policy = "manual", value = 5.21 )

# plot original wd levels
plot(s_wst)
# plot wd levels after threshold removed
plot(s_wst_th) # we can see that a lot of coefficients was removed by universal thresholding

# Now select packets for a basis using a Coifman-Wickerhauser algorithm
#
s_wp_nv <- MaNoVe.wp(s_wst_th)
s_wp_nv

# lets invert thre representation with respect to this basis defined
s_wp_nv_IB <- InvBasis.wp(s_wst_th, s_wp_nv)

# and lets do an Average Basis reconstructino to compare
# s_wp_nv_AB <- AvBasis(s_wst_th)

# lets look at the Integrated Squared Error in each case
#
sum( (s - s_wp_nv_IB)^2 )
#
# sum( (s - s_wp_nv_AB)^2 ) # average basis method do better (error is less)

# lets plot reconstructions and original plots
par(bg='grey')
plot(s, type = 'l')
lines(s_wp_nv_IB, lwd=1, lty=2, col = 'blue')
plot(s_wp_nv_IB, type = 'l')



# lines(s_wp_nv_AB, lwd=2, lty=2, col = 'green')
# spectru <- seewave::spec(s_wp_nv_IB, f=512, PMF=T)
# plot(spectru, xlim=c(0,0.08), type = 'l')
# abline(v=by, lty= 2, col = "darkblue")
# 
# seewave::spec(s, f=512, PMF=T)
# ###################################################
# scalo <- wavScalogram::scalogram(s_wp_nv_AB, dt=dt, figureperiod = F)
# signalas <- s_wp_nv_AB
# 
# plot(signalas, type ='l')
# library(Rwave)
# 
# cwtsign <- cwt(s, 8)
