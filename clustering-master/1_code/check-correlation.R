# Title: Check Correlation
# Review: 2020-02-04T1428 AU
# URL 1: <https://www.trchome.com/docs/5-cluster-analysis-gets-complicated/file>
# URL 2: <https://stats.stackexchange.com/questions/62253/do-i-need-to-drop-variables-that-are-correlated-collinear-before-running-kmeans>


## check constants
sapply(d, sd)

# ## select features
# X <-
#   c(
#       'Mode_freq_t'
#     , 'Time_range'
#     , 'Value_min'
#     , 'Value_max'
#     , 'Value_range'
#     , 'Mean'
#     , 'Sd'
#     , 'Median'
#     , 'abs_fft'
#     , 'rms'
#     , 'kurtosis_value'
#   )


## check correlation chart and export to file
png(file='../3_figures/correlation.png', height=1024, width=1024)
PerformanceAnalytics::chart.Correlation(d)
dev.off()


## choose variables ####
sapply(d, sd)

fn_range <- function(x) { range(x)[2] - range(x)[1] }
sapply(d, fn_range)


# 20200203 manual review
# PerformanceAnalytics::chart.Correlation(d)

## exclude range:
d$Value_range <- NULL # max or range? range makes less sense

# d$Mean <- NULL # Mean vs RMS: mean has lower range
# d$Sd <- NULL # SD vs RMS: sd has lower range
# d$Median <- NULL # Median vs RMS: Median has lower range


## draw a final correlation chart and export to file
png(file='../3_figures/correlation__final.png', height=1024, width=1024)
PerformanceAnalytics::chart.Correlation(d)
dev.off()

# diff(range(d$Mean))# remove mean, smaller sd than Median, and also correlated linearly


## notify user
cat('Correlation: reviewed.\n')