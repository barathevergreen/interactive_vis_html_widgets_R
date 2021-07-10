library("tidyverse")
library("gapminder")
library("plotly")

## == World Choropleth

world_choropleth_data <- read_csv("data/world-choropleth.csv") 

world_choropleth_data %>%
  plot_geo() %>%
  add_trace(
     locationmode = "country names",
     locations = ~name,
     z = ~pop
  )


## == US Choropleth

us_choropleth_data <- read_csv("data/us-choropleth-data.csv")

us_choropleth_data %>%
  plot_geo() %>%
  add_trace(
    locationmode = "USA-states",
    locations = ~sender.state,
    z = ~items.sent
  ) %>%
  layout(geo = list(scope = "usa"))
