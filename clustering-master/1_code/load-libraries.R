# Title: Clustering Sensor Data
# Review: 2020-02-04T1156 AU
# Chapter: 0. Setup Project: load-libraries


# list of required libraries
required_libraries <-
  c(
    'arules'# discretize data
    , 'BiocManager'# for library `rhdf5`
    , 'fpc'# flexible procedures for clustering; function `plotcluster`
    , 'lubridate'# prepare date time
    # , 'rhdf5'# load data in format `hdf5`
    , 'PerformanceAnalytics'# for correlation chart
    , 'plotly' # interactive charts
  )


# check which of required libraries are available
has <- required_libraries %in% rownames(installed.packages())


# install any missing packages
if(any(!has)) install.packages(required_libraries[!has])


suppress_libraries <- function(x) {
  suppressPackageStartupMessages(library(x, character.only=T))
}

# load required libraries into environment
lapply(required_libraries, suppress_libraries)


# special loading for BiocManager rhdf5
# see https://www.bioconductor.org/packages/devel/bioc/vignettes/rhdf5/inst/doc/rhdf5.html
# BiocManager::install("rhdf5")


# cleanup
rm(has, required_libraries)


# end of chapter
cat('Libraries: loaded.\n')
