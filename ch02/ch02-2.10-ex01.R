# Adaptado de https://rpubs.com/elsimanataputro/goldprice

# Instalação de pacotes
install.packages("tidyverse", repos = "http://cran.us.r-project.org")
install.packages("lubridate", repos = "http://cran.us.r-project.org")
install.packages("forecast", repos = "http://cran.us.r-project.org")
install.packages("MLmetrics", repos = "http://cran.us.r-project.org")
install.packages("tseries", repos = "http://cran.us.r-project.org")
install.packages("TSstudio", repos = "http://cran.us.r-project.org")
install.packages("padr", repos = "http://cran.us.r-project.org")
install.packages("imputeTS", repos = "http://cran.us.r-project.org")

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
gold <- read.csv("/home/joaof/Work/Workspace/GitHub/joaoferreirape/fpp2/ch02/goldprice.csv")
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




# #################
# #################
# #################
# Time Series Model and Forecasting
## Construiremos um modelo de série temporal com base em nossos dados. Nossos dados têm sazonalidade e tendência, então faremos um modelo de Suavização Exponencial Tripla e, para comparação, faremos um modelo ARIMA também.

# Vamos tentar prever 6 meses a frente e atrás dos dados utilizando 2 modelos diferentes

# Cross Validation
## 6 meses = 7 * 4 * 12 = 168
train <- head(gold_ts, -168)
test <- tail(gold_ts, 168)



# #################
# Modelo 1
# Triple Exponential Smoothing Model
## Em Triple Exponential Smoothing há valores para alfa, beta e gama. Esse valor é ajustável, mas queremos que a função defina o valor para nosso modelo.
gold_HWmodel <- HoltWinters(train, seasonal = "multiplicative")
gold_HWmodel$alpha
gold_HWmodel$beta
gold_HWmodel$gamma
# Holt’s Winter Model Forecasting
## Depois de criar o modelo, tentaremos fazer previsões usando nossos dados de teste e visualizá-los.
gold_HWforecast <- forecast(gold_HWmodel, h = 168)
gold_ts %>%
  autoplot() +
  autolayer(gold_HWmodel$fitted[,1], lwd = 0.5,
            series = "HW model") +
  autolayer(gold_HWforecast$mean, lwd = 0.5,
            series = "Forecast 1 year")
## No gráfico, podemos ver que a linha azul (modelo HW) com dados de trem é bem similar aos nossos dados originais. Infelizmente, a linha vermelha (Previsão) não é realmente precisa, a previsão prevê que o preço vai subir, mas os dados originais vão cair. Vamos verificar nosso erro com o MAPE.
MAPE(gold_HWmodel$fitted[,1], train)*100
MAPE(gold_HWforecast$mean, test)*100



# #################
# Modelo 2
# ARIMA Model
## Como alternativa, faremos o modelo ARIMA. ARIMA é uma integração de 2 métodos, AR (Auto Regressão) e MA (Média Móvel). Queremos que o método ARIMA considere nossos dados de sazonalidade, então usaremos STLM com o método ARIMA.
gold_arima_stl <- stlm(y = train, method = "arima")
gold_arima_stl$model
# ARIMA Model Forecasting
## Depois de criar o modelo, tentaremos fazer previsões usando nossos dados de teste e visualizá-los.
gold_ARIMAforecast <- forecast(gold_arima_stl, h = 168)
gold_ts %>%
  autoplot() +
  autolayer(gold_arima_stl$fitted, lwd = 0.5,
            series = "ARIMA model") +
  autolayer(gold_ARIMAforecast$mean, lwd = 0.5,
            series = "Forecast 1 year")
## No gráfico, podemos ver que a linha vermelha (modelo ARIMA) com dados de trem é bem similar aos nossos dados originais. Infelizmente, a linha azul (Previsão) ainda tem desvio dos dados originais. Verificaremos nosso erro com o MAPE.
MAPE(gold_arima_stl$fitted, train)*100
MAPE(gold_ARIMAforecast$mean, test) * 100



# #################
# Model Evaluation
## Depois de fazer a previsão, avaliaremos nosso modelo ARIMA com verificação de suposições.
## No Auto Correlation
### H0: residual has no-autocorrelation
### H1: residual has autocorrelation
Box.test(gold_arima_stl$residuals, type = "Ljung-Box")
## Normality of Residuals
### H0: residual normally distributed
### H1: residual not normally distributed
shapiro.test(gold_arima_stl$residuals)
# p-value < 0.05 (residual not normally distributed).
# Our model fail in Normality of Residuals check.



# #################
# Conclusão

# Para resumir nossa análise, temos que retornar ao nosso objetivo principal. Já fizemos um modelo que pode prever o preço do ouro em 6 meses à frente, com erro de previsão de 1,468% e ainda precisa de melhoria na verificação da normalidade dos resíduos. Como alternativa, já fizemos outro modelo com o Método de Suavização Exponencial Tripla com erro de previsão de 1,85%.

# Aqui está uma recomendação que pode melhorar nosso modelo: Podemos tentar fazer um modelo ARIMA usando arima() e definir o parâmetro por conta própria.
