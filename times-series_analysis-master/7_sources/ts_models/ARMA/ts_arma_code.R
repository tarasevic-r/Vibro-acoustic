# get differences
d1 <- diff(d$value)

write.csv(d1, 'd1.csv', row.names = F)

model_arma <- forecast::auto.arima(d1)

# get arma coefficients
# ar_coef <- model_arma$coef
ar_coefs <- grep('^ar', names(model_arma$coef))
ma_coefs <- grep('^ma', names(model_arma$coef))

my_list <- list(
  ar = c(
    model_arma$coef[ar_coefs[1]]
    , model_arma$coef[ar_coefs[2]]
    )
  , ma = c(
    model_arma$coef[ma_coefs[1]]
    , model_arma$coef[ma_coefs[2]]
    )
)

d_sim <- arima.sim(
  n = 4122
  , my_list
  , sd = sqrt(0.1796)
)


# interactive plot:
plot(d_sim)
plot(d1, type='l')
