# 
# The RMS value increase gradually as fault developed. However, RMS is unable
# to provide the information of incipient fault stage while it increases with the fault
# development
rms = function(s){
  round(mean(sqrt(s^2)), 2)
}
#
# Variance measures the dispersion of a signal around their reference mean value. 
var = round(var(s), 2)

#
# Skewness quantifies the asymmetry behavior of vibration signal through its
# probability density function (PDF). 
skewness = function(s){
  round(e1071::skewness(s), 2)
}
#
# Kurtosis quantifies the peak value of the PDF. The kurtosis value for normal
# rolling element bearing is well-recognized as 3.
kurtosis = e1071::kurtosis(s)
#
# Shape factor is a value that is affected by an object’s shape but is independent of
# its dimensions 
shape_factor = function(s){
  sqrt(1/length(s) * sum(s^2)) / (1/length(s) * sum(Mod(s)) ) 
}
#
# Crest factor (CF) calculates how much impact occur during the rolling element
# and raceway contact. CF is appropriate for “spiky signals” 
crest_factor = function(s){ 
  max(Mod(s)) / sqrt(1/length(s) * sum(s^2))
}
#
