# Title: Subset x using IQR method
# Review: 2020-02-05T1218 AU
# Input: x

cutoff_IQR <- function(x) {
  
  Q1_x <- stats::quantile(x, 0.25, names=F)
  Q3_x <- stats::quantile(x, 0.75, names=F)
  
  IQR_x <- Q3_x - Q1_x
  
  min_x <- round(Q1_x - 1.5*IQR_x, 4) # 207818.3047 matches with NTIA
  max_x <- round(Q3_x + 1.5*IQR_x, 4) # 310920.1172 matches with NTIA
  
  ## filter x
  x <- base::subset(x, x > min_x & x < max_x)
  
  return(x)
}

