library("sf")
library("geojsonio")
library("gapminder")
library("tidyverse")
library("highcharter")


shp_as_sf <- read_sf("data/world-shape-files/")

converted_geojson <- geojson_list(shp_as_sf)

gapminder_most_recent <- gapminder %>%
  filter(year == max(year))

highchart(type = "map") %>%
  hc_add_series_map(map = converted_geojson,
                    df = gapminder_most_recent,
                    value = "pop",
                    joinBy = c("name_long", "country")) %>%
  hc_title(text = "Population Choropleth for 2007 (Source: Gapminder)")
