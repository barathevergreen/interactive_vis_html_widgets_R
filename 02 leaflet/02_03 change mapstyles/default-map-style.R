library("tidyverse")
library("leaflet")

capital_cities <- read_csv("data/capitals_with_locations.csv")

# Additional map tiles: http://leaflet-extras.github.io/leaflet-providers/preview/index.html

capital_cities %>% 
leaflet() %>%
  # addTiles() %>%
  addProviderTiles(providers$OpenTopoMap) %>%
  addMarkers(lng = ~capital.longitude,
             lat = ~capital.latitude)
