library("tidyverse")
library("geosphere")
library("leaflet")
#installing library from Github:
#devtools::install_github("martinjhnhadley/statesRcontiguous")
library("statesRcontiguous")

#read a geolines dataset - read_csv{readr}:
sample_geo_lines <- read_csv("data/sample_geo_lines.csv")

#great arcs between 2 locations:
#gcIntermediate - get intermediate points from location coordinates in degrees
geo_lines <- gcIntermediate(
  sample_geo_lines %>%
    select(start.longitude, start.latitude),
  sample_geo_lines %>%
    select(end.longitude, end.latitude),
  sp = TRUE, # SpatialLines are what Leaflet wants
  addStartEnd = TRUE, # By default this is FALSE, and would be inaccurate
  n = 50 # number of intermediate points
)

#using leaflet html widget library to build visulaization - leaflet map:
leaflet() %>%
  #we use various graphic elements and layers:
  addTiles() %>%
  addPolylines(data = geo_lines, color = "#2c7bb6", opacity = 0.2) %>%
  addPolygons(data = shp_all_us_states,
              weight = 1,
              color = "#000000",
              popup = ~paste("State:", state.name)
              ) %>%
  addCircleMarkers(data = sample_geo_lines, 
                   lat = ~end.latitude, 
                   lng = ~end.longitude,
                   radius = 3,
                   color = "#1b9e77",
                   popup = ~paste("Location:", end.location, "<p>Total Items Received:", items.received)) %>%
  addCircleMarkers(data = sample_geo_lines, 
                   lat = ~start.latitude, 
                   lng = ~start.longitude,
                   radius = 3,
                   color = "#d95f02",
                   popup = ~paste("Location:", start.location, "<p>Total Items Sent:", items.send))
