library("tidyverse")
library("sf")

esri_shapefile <- read_sf("data/world-shape-files/")

geojson_shapefile <- read_sf("data/world-geojson.json")

#check class - spatial df
class(esri_shapefile)
class(geojson_shapefile)

