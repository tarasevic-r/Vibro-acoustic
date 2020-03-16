## FFT 
# 2020-01-15 T15:18 RT

# Order FFT coeficients ascending and choose all except main 3 coeficients
idx_weak_FTs1 <- order(magnitude1, decreasing = F)[1:(length(magnitude1)-3)]
# idx_weak_FTs2 <- order(magnitude2, decreasing = F)[1:(length(magnitude2)-3)]


# keep only 3 main coeficients, rest change to 0
# a)
if(length(idx_weak_FTs1) > 0) {
  0 ->
    FTs1[idx_weak_FTs1]
}

# b)
# if(length(idx_weak_FTs2) > 0) {
#   0 ->
#     FTs2[idx_weak_FTs2]
# }


# Get 3 main FFT coeficients
FTs1_strong <- FTs1[-c(idx_weak_FTs1)]
# FTs2_strong <- FTs2[-c(idx_weak_FTs2)]

## Main coeficients magnitude
magnitude1_strong <- round(Mod(FTs1_strong), 2)
# magnitude2_strong <- round(Mod(FTs2_strong), 2)
# 

## week and strong magnitudes sum
cat(
  '  number of weak s1:',length(magnitude1[idx_weak_FTs1]), 
  '& sum:', round(sum(magnitude1[idx_weak_FTs1]), 2),'\t'
  ,'number of strong s1:',length(magnitude1_strong), 
  '& sum:', sum(magnitude1_strong), '\n'
  
  # ,' number of weak s2:',length(magnitude2[idx_weak_FTs2])
  # ,'& sum:', round(sum(magnitude2[idx_weak_FTs2]), 2),'\t'
  # ,'number of strong s2:',length(magnitude2_strong), 
  # '& sum:', sum(magnitude2_strong)
)
#  ???? abejotini rezultatai 

## join reverse vector (matlab: fft_shift)
# FTs1 = c(FTs1, rev(FTs1))
# FTs2 = c(FTs2, rev(FTs2))
