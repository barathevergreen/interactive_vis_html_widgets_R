library("tidyverse")

load("data/british_weather.rdata")

#create apt columns for ggplot:
gg_british_weather <- british_weather %>% 
  mutate(tdiff = tmax - tmin) %>%
  group_by(region, mm) %>%
  dplyr::summarise(average.tdiff = mean(tdiff, na.rm = TRUE)) %>%
  ggplot(aes(
    x = mm,
    y = average.tdiff,
    group = region,
    col = region,
    text = paste0("UK(",region,")")
  )) +
  geom_line() +
  geom_point() + #using ggplot{labs} to change axis or legend or plot info:
  labs(x = "Month", y = "Mean daily temperature difference") + #Main title and subtitle:
  ggtitle("Mean daily temperature difference in the UK", subtitle = "Split by region") +
  facet_wrap(~region)

gg_british_weather

library("plotly")
ggplotly(gg_british_weather)

#Adding tooltip argument to update ggplotly
#Fix region 2 times

ggplotly(gg_british_weather, 
         tooltip = c("x","y","text"))

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
 


