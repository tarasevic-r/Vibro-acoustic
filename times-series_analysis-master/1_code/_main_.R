# Title: R scripts - Time Series Analysis - _main_ file
# Review: 2020-01-31T1250 AU

rm(list=ls())

## load user functions for time series analysis
source('_include_.R')

source('Rscript01.R')       ## load raw data
# source('Rscript01_plots.R') ## chart: raw data
source('Rscript03.R')       ## select sample
# source('Rscript03_plots.R') ## chart: sample
source('Rscript02.R')       ## data dimensions and summary
source('Rscript04.R')       ## data mode
# source('Rscript04_plots.R') ## chart: top frequencies
# source('Rscript05.R')       ## chart: data density

## outlier detection using IQR method
# source('Rscript06a.R') # boxplot
# source('Rscript06b.R') # IQR
# source('Rscript06c.R') # 3*sd

# source('Rscript07.R') ## linear interpolation
# source('Rscript08.R') ## simple moving average

# source('Rscript09a.R') ## autocorrelation (acf)
# source('Rscript09b.R') ## partial autocorrelation (pacf)
# source('Rscript09c.R') ## cross-correlation between two series (ccf)

# !! source('Rscript10.R') ## fast fourier transform - missing comments

source('Rscript11.R') ## cross-correlation
source('Rscript11_plots.R') ## cross-correlation

