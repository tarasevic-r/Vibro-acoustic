
# wavelet packet transform
s_wst <- wavethresh::wp(s, filter.number = best_index, family = best_family)
# plot(s, type = 'l')
# threshold the coefficients
s_wst_th <- threshold.wp(s_wst, levels = 6:s_wst$nlevels-1, by.level = T)#, policy = "manual", value = 5.21 )

# plot original wd levels
# plot(s_wst)

# plot wd levels after threshold removed
# plot(s_wst_th) # we can see that a lot of coefficients was removed by universal thresholding

# Now select packets for a basis using a Coifman-Wickerhauser algorithm
#
s_wp_nv <- MaNoVe.wp(s_wst_th)
# s_wp_nv

# lets invert thre representation with respect to this basis defined
# s_wp_nv_IB <- InvBasis.wp(s_wst_th, s_wp_nv)
s_wp_nv_IB <- InvBasis.wst(s_wst_th, s_wp_nv)


# and lets do an Average Basis reconstructino to compare
# s_wp_nv_AB <- AvBasis(s_wst_th)

# lets plot reconstructions and original plots
# par(bg='grey')
# plot(s, type = 'l')
# lines(s_wp_nv_IB, lwd=1, lty=2, col = 'blue')
# plot(s_wp_nv_IB, type = 'l')
# 
s = s_wp_nv_IB
