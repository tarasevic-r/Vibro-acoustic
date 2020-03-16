# Converte date into POSIXt format
# 2020-01-22 T10:48 RT

# Converte date into POSIXt format
date <- as.POSIXct(subset$timestamp)
plot(date, subset$value, type = 'l')