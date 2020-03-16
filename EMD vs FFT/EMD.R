## EMD 
# 2020-01-16 T18:09 RT
library("EMD")

# EMD calculation
s1_noise_emd <- EMD::emd(xt = s1_noise, tt = t[1:dw_size])
s2_noise_emd <- EMD::emd(xt = s2_noise, tt = t[1:dw_size])
s_emd <- EMD::emd(xt = s, tt = t[1:dw_size])

# Number of imf's
s1_nimf <- s1_noise_emd$nimf
s2_nimf <- s2_noise_emd$nimf
s_nimf <- s_emd$nimf


# Print results
cat(' original sample IMF number is:',s_nimf,'\n'
    ,'sample with simple noise IMF number is:',s1_nimf,'\n'
    ,'sample with complex noise IMF number is:',s2_nimf
    )
