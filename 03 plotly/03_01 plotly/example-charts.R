library("tidyverse")
library("plotly")
library("oidnChaRts")

## =================== BarChart
data_stacked_bar_chart %>%
  plot_ly(x = ~count,
          y = ~occupation,
          color = ~country_group) %>%
  add_bars() %>%
  layout(barmode = "stack", barnorm = "normal",
         margin = list(l = 240),
         yaxis = list(title = list(text = "")))

data_stacked_bar_chart %>%
  plot_ly(x = ~count,
          y = ~occupation,
          color = ~country_group) %>%
  add_bars() %>%
  layout(barmode = "stack", barnorm = "percent",
         margin = list(l = 240),
         yaxis = list(title = list(text = "")))

## =================== Scatter
data_scatter_plot %>%
  plot_ly(x = ~x,
          y = ~y,
          color = ~type) %>%
  add_markers()

## =================== Line Chart
data_line_chart %>%
  plot_ly(x = ~x,
          y = ~y,
          color = ~trace) %>%
  add_trace(x = ~x,
            y = ~y,
            color = ~trace,
            mode="lines+markers",
            type = "scatter")

## =================== Histogram
diamonds %>%
  plot_ly(x = ~cut, color = ~clarity) %>%
  add_histogram()

## =================== Choropleth
library("gapminder")

gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

plot_geo() %>%
  add_trace(
    data = gapminder_most_recent,
    z = ~lifeExp,
    locations = ~name, 
    locationmode = "country names"
  )

