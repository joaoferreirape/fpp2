set.seed(30)
y <- ts(rnorm(50))
autoplot(y) + ggtitle("White noise")
