# Forecasting: Principles and Practice

Este repositório contém resumo do material oriundo e da implementação do que consta na segunda edição do livro on-line de ``Rob J Hyndman`` e ``George Athanasopoulos``, disponível em [https://otexts.com/fpp2/](https://otexts.com/fpp2/)

Há uma terceira edição do livro, disponível em [https://otexts.com/fpp3](https://otexts.com/fpp3)

## Ambiente

As instruções seguem o processo de construção e instalação do ambiente de desenvolvimento R e RStudio para Microsoft Windows 11.

O site oficial do R está disponível em: [The R Project for Statistical Computing](https://www.r-project.org/)

Há vários tutoriais e portais com material de ajuda disponível, dois bem interessantes são mantidos

* [LEG: Laboratório de Estatística e Geoinformação da UFPR](http://leg.ufpr.br/~paulojus/embrapa/Rembrapa/)
* [Enciclopédia sobre Linguagem de Programação R mantida na Universidade Federal do Rio Grande do Sul](https://www.ufrgs.br/wiki-r)

### Instalação do R

* R base [https://cran.r-project.org/bin/windows/base/](https://cran.r-project.org/bin/windows/base/)
* Rtools [https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/)
* RStudio Desktop [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)

### Instalação de pacotes e bibliotecas

Antes de seguir com os procedimentos será necessário instalar um conjunto de pacotes do R e do repositório [https://github.com/robjhyndman/forecast](https://github.com/robjhyndman/forecast), além de efetuar o carregamento da biblioteca ``fpp2``

```bash
# ./README.R

# Instalação de pacotes
install.packages("devtools")
install.packages("dplyr")
install.packages("fabletools")
install.packages("ggplot2")
install.packages("tsibble")
install.packages("tsibbledata")

# Instalar pacotes a partir do github
devtools::install_github("robjhyndman/forecast")

# Carregamento de bibliotecas
library(dplyr)
library(fabletools)
library(fpp2)
library(ggplot2)
library(tsibble)
library(tsibbledata)

```

## Lista de capítulos

* [Chapter 1 Getting started](./ch01/ch01.md)
* [Chapter 2 Time series graphics](./ch02/ch02.md)
