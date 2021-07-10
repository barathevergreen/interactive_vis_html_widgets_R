library("tidyverse")
library("sf")
library("geojsonio")
library("highcharter")
library("gapminder")

#Data 1 - read the shape files using read_sf
#convert to geojsn using geojson_list
world_as_sf <- read_sf("data/world-shape-files/")
world_as_geojsn <- geojson_list(world_as_sf) 

#Data 2 - read through gapminder
gapminder_most_recent <- gapminder %>%
  filter(year == max(year)) 

#create a highchart map - with a value to shade based on parameter
#common values tags are used in joinBy
#add a series name using name = 
highchart(type = "map") %>%
  hc_add_series_map(map = world_as_geojsn,
                    df = gapminder_most_recent,
                    value = "pop",
                    joinBy = c("name_long", "country"))

#add a series name using name = 
highchart(type = "map") %>%
  hc_add_series_map(map = world_as_geojsn,
                    df = gapminder_most_recent,
                    value = "pop",
                    joinBy = c("name_long", "country"),
                    name = "Population:")


