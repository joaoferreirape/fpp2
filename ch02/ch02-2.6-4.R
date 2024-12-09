#install.packages("GGally", repos = "http://cran.us.r-project.org")
#library(GGally)

GGally::ggpairs(as.data.frame(visnights[,1:5]))
