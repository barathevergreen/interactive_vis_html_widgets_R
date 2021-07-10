library("tidyverse")
library("plotly")

## Scatter Plot
scatter_data <- read_csv("data/scatter_data.csv") 

#creating a scatter plot
#mention explicitly to remove warnings
scatter_data %>%
  plot_ly() %>%
  add_trace(x= ~x,
            y= ~y,
            color = ~type,
            type = "scatter",
            mode = "markers",
            opacity = 0.8) #for Zoom

## Line Charts

lines_data <- read_csv("data/lines_data.csv") #%>% view()

#lines_data is a scatter plot with mode = lines+markers:
lines_data %>%
  plot_ly() %>%
  add_trace(x = ~x,
            y = ~y,
            color = ~trace,
            type = "scatter",
            mode = "lines+markers",
            opacity = 0.8) #to see when zoom


## Bubble Chart
library("gapminder")
gapminder_oldest <- gapminder %>%
  filter(year == min(year))

gapminder_oldest %>% view()

#Normal Plot:
gapminder_oldest %>%
  plot_ly(x = ~gdpPercap,
          y = ~lifeExp,
          size = ~pop,
          color = ~continent)

#we find that the graph is too much packed:
#so we need to seperate them using type = log

gapminder_oldest %>%
  plot_ly() %>%
  add_trace(x = ~gdpPercap,
          y = ~lifeExp,
          size = ~pop,
          color = ~continent) %>%
  layout(xaxis = list(type = "log"))