library("sf")
library("gapminder")
library("tidyverse")
library("leaflet")

world_shapefiles <- read_sf(dsn = "data-raw/world-shape-files/")

gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_world <- world_shapefiles %>%
  left_join(gapminder_most_recent)

lifeExp_numeric_palette <- colorNumeric("Blues", domain = gapminder_world$lifeExp)

#use fill colour and opacity for even spread
gapminder_world %>%
  leaflet() %>%
  addPolygons(weight = 1,
              label = ~name,
              popup = ~paste("Country", name, "<br/>", pop),
              fillColor = ~lifeExp_numeric_palette(lifeExp),
              fillOpacity = 0.8,
              color = "#000")%>%
  addLegend(pal=lifeExp_numeric_palette,
            val=~lifeExp)
