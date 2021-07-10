library("tidyverse")
library("highcharter")

## Scatter Plot
scatter_data <- read_csv("data/scatter_data.csv")

#scatter chart
scatter_data %>%
  hchart(type = "scatter",
         hcaes(x = x,
               y = y,
               group = type))
#same as earlier
scatter_data %>%
  hchart(type = "scatter",
         hcaes(group = type))

## Line Charts

lines_data <- read_csv("data/lines_data.csv")

#line chart
lines_data %>%
  hchart(type = "line",
         hcaes(group = trace))
         
#marker = list(enabled = TRUE)) - no need for new version

lines_data %>%
  hchart(type = "line",
         hcaes(group = trace),
         marker = list(enabled = TRUE)) %>%
  hc_yAxis(type = "logarithmic")


## Bubble Chart

library("gapminder")
gapminder_oldest <- gapminder %>%
  filter(year == min(year))

gapminder_oldest %>%
  hchart(type = "bubble",
         hcaes(y = lifeExp,
               x = gdpPercap,
               size = pop,
               group = continent))

#we can do a log of highly packed data (whichever axis)
gapminder_oldest %>%
  hchart(type = "bubble",
         hcaes(y = lifeExp,
               x = gdpPercap,
               size = pop,
               group = continent)) %>%
  hc_xAxis(type = "logarithmic") 

#Increase Bubble Size for clarity
gapminder_oldest %>%
  hchart(type = "bubble",
         hcaes(y = lifeExp,
               x = gdpPercap,
               size = pop,
               group = continent)) %>%
  hc_xAxis(type = "logarithmic") %>%
  hc_plotOptions(bubble = list(maxSize = "30%"))