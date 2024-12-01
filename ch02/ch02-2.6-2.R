as.data.frame(elecdemand) |>
  ggplot(aes(x=Temperature, y=Demand)) +
  geom_point() +
  ylab("Demand (GW)") + xlab("Temperature (Celsius)")
