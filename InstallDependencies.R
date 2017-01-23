# how to install rCharts
# http://stackoverflow.com/questions/31811539/r-installing-rcharts-on-r-3-2-1

#Install rtools33.exe from <https://cran.r-project.org/bin/windows/Rtools/Rtools33.exe>
install.packages("devtools")
install.packages("Rcpp")
library(devtools)
library(Rcpp)

install_github('ramnathv/rCharts')

