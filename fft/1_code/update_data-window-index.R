# Title: Update data window index
# source('update_data-window-index.R')
# Review: 2020-01-23T1635 AU


## a) update index: brute force (every step): +1
index_mode = 1

## c) update index: data window step size
index_mode = data.window / data.window_step

## b) update index: window size
index_mode = data.window

## Update index
idx.from <- idx.from + index_mode
idx.to <- idx.to + index_mode
