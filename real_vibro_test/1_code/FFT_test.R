
# set data window and slide parameters
from = 1
to = 2^12
dw=4096
slide = dw/3

results_coef = data.frame()
results_mag = data.frame()

while(to <= length(s_orig)) {
s_fft <- fft(s_orig[from:to])

magnitude <- Mod(s_fft)[1:(length(s_fft)/2)]
# perc <- percentils(magnitude, 0.95)
magnitude = normalize(magnitude)
perc <- order(magnitude, decreasing = T)[1:5]
# plot(magnitude, type = 'l')

# main_coef <- which(magnitude>=perc)
main_coef <- perc
main_mag <- round(magnitude[main_coef], 3)

results_coef <- rbind(results_coef, main_coef)
results_mag <- rbind(results_mag, main_mag)

from = from + slide
to = to+slide


}
# 
# results_coef
# results_mag

colnames(results_coef) <- NULL
colnames(results_mag) <- NULL

results <- cbind(results_coef, results_mag)
# write.csv(results, file = "../../results.csv", row.names = F)

dist(results_coef)
