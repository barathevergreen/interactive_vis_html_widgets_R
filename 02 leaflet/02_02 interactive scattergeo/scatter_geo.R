library("tidyverse")

#create a tibble dataset using africa latitudes and longtudes:
#good idea
africa_data_points <- tibble(
  lat = rnorm(26, mean = 6.9, sd = 10),
  lng = rnorm(26, mean = 17.7, sd = 10),
  size = runif(26, 5, 10),
  label = letters
)

library("leaflet")

#creating location markers from dataset:
#choice 1
africa_data_points %>% #view()
  leaflet() %>%
  addTiles() %>%
  addMarkers()

#choice 2
#here data is available only to addMarkers():  
leaflet() %>%
  addTiles() %>%
  addMarkers(data = africa_data_points)

#Creating standard circle markers
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = africa_data_points)

#Creating circle markers based on a value
leaflet() %>%
  addTiles() %>%
  #label based on label column
  addCircleMarkers(data = africa_data_points,
                   radius = ~size,
                   label = ~label)

#Creating circle markers based on a multiple labels
leaflet() %>%
  addTiles() %>%
  #label based on label column
  addCircleMarkers(data = africa_data_points,
                   radius = ~size,
                   label = ~paste("label:",label,"| Size:",size))

#adding a value when hover circle markers
leaflet() %>%
  addTiles() %>%
  #radius based on size column
  addCircleMarkers(data = africa_data_points,
                   radius = ~size)

capital_cities <- read_csv("data/capitals_with_locations.csv")
head(capital_cities)

#indicating lng and lat of capital cities
#showing radius according to population
#Without Scaling
capital_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude,
                   lat = ~capital.latitude,
                   radius = ~country.population)

#With Scaling
capital_cities %>% #view()
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude,
                   lat = ~capital.latitude,
                   radius = ~country.population/100000000)

#with hover effect - use popup, linebreak in display labels
capital_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude,
                   lat = ~capital.latitude,
                   radius = ~country.population/100000000,
                   popup = ~paste("Capital: ",Capital,"<br/>", "Country: ", Country))
