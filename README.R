# Instalação de pacotes
install.packages("devtools", repos = "http://cran.us.r-project.org")
install.packages("dplyr", repos = "http://cran.us.r-project.org")
install.packages("fabletools", repos = "http://cran.us.r-project.org")
install.packages("fpp2", repos = "http://cran.us.r-project.org")
install.packages("ggplot2", repos = "http://cran.us.r-project.org")
install.packages("tsibble", repos = "http://cran.us.r-project.org")
install.packages("tsibbledata", repos = "http://cran.us.r-project.org")
install.packages("GGally", repos = "http://cran.us.r-project.org")

# Instalar pacotes a partir do github
devtools::install_github("robjhyndman/forecast")

# Carregamento de bibliotecas
library(dplyr)
library(fabletools)
library(fpp2)
library(ggplot2)
library(tsibble)
library(tsibbledata)
library(GGally)
