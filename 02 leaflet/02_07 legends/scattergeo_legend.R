library("tidyverse")
library("leaflet")

#read capital cities - lng,lat of few countries:
capital_cities <- read_csv("data/capitals_with_locations.csv")

capital_cities #%>% view()

#add legend and specify a color
capital_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude,
                   lat = ~capital.latitude) %>%
  addLegend(colors = "blue",
            labels = "Capital City")

#change position
capital_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude,
                   lat = ~capital.latitude) %>%
  addLegend(colors = "blue",
            labels = "Capital City",
            position = "bottomleft")
