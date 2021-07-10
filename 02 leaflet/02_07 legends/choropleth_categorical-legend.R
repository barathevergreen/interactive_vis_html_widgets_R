library("sf")
library("gapminder")
library("tidyverse")
library("leaflet")

#read dataset
world_shapefiles <- read_sf(dsn = "data-raw/world-shape-files/")

#Format table: check factor,remove unwanted columns,rename for join:
gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>% 
  filter(year == max(year)) %>% 
  select(-continent, -year) %>%
  rename(name = country) %>% 

gapminder_most_recent %>% view()

#Join with shapefiles:
gapminder_world <- world_shapefiles %>%
  left_join(gapminder_most_recent)

#Using Dark2 colour Palette
#We want to apply based on continents
continent_palette <- colorFactor("Dark2", unique(gapminder_world$continent))

#plotting choropleth
#hover - Display Name
#click - Display Name: Population
gapminder_world %>%
  leaflet() %>%
  addPolygons(weight = 1,
              label = ~name,
              popup = ~paste("Country:", name, "<br/>", pop),
              color = ~continent_palette(continent)) %>% #add our own name in title
  addLegend(pal = continent_palette,
            value = ~continent,
            title = "Barath Continents")

