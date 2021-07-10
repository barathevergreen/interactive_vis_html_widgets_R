library("sf")
library("gapminder")
library("tidyverse")
library("leaflet")

##Creating read file
# Obtained maps from http://www.naturalearthdata.com/downloads/50m-cultural-vectors/
download.file(
  url = "http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
  destfile = "data-raw/world-shape-files.zip")

unzip("data-raw/world-shape-files.zip", 
      exdir = "data-raw/world-shape-files")

#Access files using SF giving data source name:
world_shapefiles <- read_sf(dsn = "data-raw/world-shape-files/")

class(world_shapefiles)
colnames(world_shapefiles)
world_shapefiles %>% view()

#from gapminder dataset, extract only columns of interest
#set to some familiar value column in shape files dataset
gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_most_recent %>% view()

#we use left join to join these - mutate-joins {dplyr}
gapminder_world <- world_shapefiles %>% 
  rename(name = SOVEREIGNT) %>% 
  left_join(gapminder_most_recent)

##After getting File:
#get only desired columns for final 
gapminder_world %>%
  select(name,lifeExp)
#lifeExp as a vector - checking for NA
#world shape files has more countries than gapminder
gapminder_world$lifeExp

qpal <- colorNumeric("Blues", gapminder_world$lifeExp, na.color = "#808080")

gapminder_world %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(
    stroke = FALSE,
    smoothFactor = 0.2,
    fillOpacity = 1,
    color = ~ qpal(lifeExp),
    label = ~ name,
    popup = ~ paste("Country:", name, "<br/>", "Life Expectancy:", lifeExp)
  ) %>%
  addLegend(pal = qpal, values = ~lifeExp, opacity = 1,
            title = paste0("Life Expectancy <br/>(Gapminder in ",max(gapminder$year, na.rm = TRUE), ")"))
