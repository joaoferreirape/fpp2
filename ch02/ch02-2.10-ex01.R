# Adaptado de https://rpubs.com/elsimanataputro/goldprice

# Instalação de pacotes
install.packages("tidyverse")
install.packages("lubridate")
install.packages("forecast")
install.packages("MLmetrics")
install.packages("tseries")
install.packages("TSstudio")
install.packages("padr")
install.packages("imputeTS")

# Carregamento de bibliotecas
library(tidyverse)
library(lubridate)
library(forecast)
library(MLmetrics)
library(tseries)
library(TSstudio)
library(padr)
library(imputeTS)
theme_set(theme_minimal())

# Carregamento dos dados
gold <- read.csv("D:/Workspace/GitHub/joaoferreirape/fpp2/ch02/goldprice.csv")
gold

# #################
# Limpeza dos dados

# Verificar tipos de dados das colunas
str(gold)

# Modificar o tipo de dado da data
gold <- gold %>%
  mutate(Date = ymd(Date))

str(gold)

# Preenchimento de dados
gold <- gold %>%
  pad(interval = "day")
gold

# Valor NA com a observação do último dia
gold_clean <- gold %>% na.locf()
gold_clean

# #################
# Exploração dos dados

# Criação e plotagem da ts
gold_ts <- ts(data = gold_clean$Price,
             start = 2014,
             frequency = 7*4*12)
gold_ts %>%
  autoplot()

# #################
# Decomposição

gold_decompose <- gold_ts %>%
  decompose(type = "multiplicative")

gold_decompose %>%
  autoplot()

# Análise da sazonalidade
gold_decompose$seasonal %>%
  autoplot()

# Verificar o padrão da sazonalidade
gold_clean %>%
  mutate(Month = month(Date, label = T)) %>%
  mutate(seasons = gold_decompose$seasonal) %>%
  group_by(Month) %>%
  summarise(total = sum(seasons)) %>%
  ggplot(aes(Month, total)) +
  geom_col()+
  theme_minimal()
