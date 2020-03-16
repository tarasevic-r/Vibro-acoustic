# Title: Boxplot with ggplot
# Review: 2020-02-04T1427 AU


library('reshape')
# <https://stackoverflow.com/questions/11346880/r-plot-multiple-box-plots-using-columns-from-data-frame>


## boxplot: basic
boxplot(data=melt(d), value~variable)


## boxplot: ggplot
p <-
  ggplot(
    melt(d)
    , aes(factor(variable), value)
  ) +
  geom_boxplot() +
  facet_wrap(~variable, scale="free")


## export to file
png(file= '../3_figures/boxplot_d.png', width=1024, height = 768)
p
dev.off()
