library("tidyverse")
library("sf")
library("oidnChaRts")
library("gapminder")


gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_world <- data_world_shapefiles %>%
  left_join(gapminder_most_recent)



st_geometry(gapminder_world) <- NULL

gapminder_world <- gapminder_world %>%
  filter(!is.na(pop))

gapminder_world %>%
  write_csv("data/world-choropleth.csv")
