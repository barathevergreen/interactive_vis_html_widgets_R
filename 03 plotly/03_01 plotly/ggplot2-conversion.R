load("data/british_weather.rdata")

#ggplot static chart
gg_british_weather <- british_weather %>%
  mutate(tdiff = tmax - tmin) %>%
  group_by(region, mm) %>%
  dplyr::summarise(average.tdiff = mean(tdiff, na.rm = TRUE)) %>%
  ggplot(aes(
    x = mm,
    y = average.tdiff,
    group = region,
    col = region
  )) +
  geom_line() +
  geom_point() +
  labs(x = "Month", y = "Mean daily temperature difference") +
  ggtitle("Mean daily temperature difference in the UK", subtitle = "Split by region")

gg_british_weather

ggplotly(gg_british_weather)

## =================== Facet grid

gg_facet_weather <- british_weather %>%
  mutate(tdiff = tmax - tmin) %>%
  group_by(region, mm) %>%
  dplyr::summarise(average.tdiff = mean(tdiff, na.rm = TRUE)) %>%
  ggplot(aes(
    x = mm,
    y = average.tdiff,
    group = region,
    col = region
  )) +
  geom_line() +
  geom_point() +
  labs(x = "Month", y = "Mean daily temperature difference") +
  ggtitle("Mean daily temperature difference in the UK", subtitle = "Split by region") + 
  facet_wrap(~region)

ggplotly(gg_facet_weather)

## =================== Violin

gg_boxplot <- british_weather %>%
  mutate(tdiff = tmax - tmin) %>%
  group_by(region, mm) %>%
  ggplot(aes(
    x = region,
    y = tdiff,
    fill = region
  )) + geom_boxplot()

ggplotly(gg_boxplot)



