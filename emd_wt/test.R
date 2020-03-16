##file:///C:/Users/user2/Downloads/WaveletPacketAnalysisandEmpiricalModeDecompositionfortheFaultDiagnosisofReciprocatingCompressors.pdf

library("wavethresh")

# wavelet packet transform
s_wp <- wavethresh::wp(s, filter.number = 4, family = "DaubExPhase")
# 
# # access to different level coefficients
# accessD.wp(wp=s_wp,level = 9)

# Create a node vector ( selecting best nodes by Coifman - Wickerhauser )
s_nv <- MaNoVe.wp(s_wp,verbose = F)# Entropy based basis selection that tries to find the nodes with minimum cost
length(s_nv$node.list)


# select node number at level you want and see the path
nodeVector9 <- numtonv(3, 2)

# plot packets
plot(s_nv, type = 'l')

# background color = grey
par(bg="grey")
plot(s_wp,s_nv, color.force=T, WaveletColor="darkblue", dotted.turn.on=7)
# The wavelet coefficients are plotted in blue. Packets from the node vector
# are depicted in green. The node vector gets plotted after the wavelet
# coefficients so the green packets overlay the Blue. The vertical dotted lines start at resolution
# level 7.


# extract a packet of coefficients from wavelet packet object
# index = 0 refers to the father wavelet coefficients
# index = 1 refers to the mother wavelet coefficients
numtonv(0, 5)
#
plot(getpacket.wp(s_wp, level = 7, index = 0), type = 'l') # w(5,3) - 48-64Hz (1024 data points)
seewave::spec(getpacket.wp(s_wp, level = 7, index = 0), f=128)

# select nodes, that are covering required frequency (0-60 Hz)
w_6.0 <- getpacket.wp(s_wp, level = 6, index = 0)
w_6.1 <- getpacket.wp(s_wp, level = 6, index = 1)
w_6.2 <- getpacket.wp(s_wp, level = 6, index = 2)
w_6.3 <- getpacket.wp(s_wp, level = 6, index = 3)
w_6.4 <- getpacket.wp(s_wp, level = 6, index = 4)
w_6.5 <- getpacket.wp(s_wp, level = 6, index = 5)
w_6.6 <- getpacket.wp(s_wp, level = 6, index = 6)
w_6.7 <- getpacket.wp(s_wp, level = 6, index = 7)

# 8th level, 0th node energy
ENG_6.0 <- sum(abs(w_6.0)^2)
ENG_6.1 <- sum(abs(w_6.1)^2)
ENG_6.2 <- sum(abs(w_6.2)^2)
ENG_6.3 <- sum(abs(w_6.3)^2)
ENG_6.4 <- sum(abs(w_6.4)^2)
ENG_6.5 <- sum(abs(w_6.5)^2)
ENG_6.6 <- sum(abs(w_6.6)^2)
ENG_6.7 <- sum(abs(w_6.7)^2)
# 8th level, 0th node energy ratio
RENG_8.0 <- ENG_8.0/(ENG_8.0+ENG_8.1)
RENG_7.0 <- ENG_7.0 / (ENG_7.0 + ENG_7.1 +ENG_7.2 +ENG_7.3)
RENG_6.0 <- ENG_6.3 / (ENG_6.0 + ENG_6.1 +ENG_6.2 +ENG_6.3 + ENG_6.4 + ENG_6.5 +ENG_6.6 +ENG_6.7)


############################################
# extract subbands that consist your frequency and calculate energy, entropy, statistics,
# scalling coefficients

############################################
# empty data frame for different frequency band energies
E <- data.frame()

0.5*1024/256

for(i in 1:(s_wp$nlevels-1)){
  print(i)
  # sub band energy to total original energy ratio
  e <- (sum((s_wp$wp[i,])^2)/sum(s^2))*100
  
  E <- rbind(E,e)
}

colnames(E) <- "Energy ratio %"
E



######################
# node energy ratio calculation, basis node selection (above threshold 30% ) for feature extraction 
## 
# node selection:
# 1) select single level basis selection ( level that explains the most of the signal)
# 2) select some of the nodes from the whole tree




# 3) feature extracting on selected basis and understending what frequencies signal contains 
