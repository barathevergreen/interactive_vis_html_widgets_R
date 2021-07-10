library("tidyverse")
library("oidnChaRts")

data_scatter_geo %>%
  separate(location.name, sep = ",", into = c("country", "city"), 
           extra = "merge") %>%
  filter(country == "USA") %>%
  separate(city, c("sender.city", "sender.state"), sep = "\\(", fill = "right") %>%
  mutate(sender.state = gsub("\\)", "", sender.state)) %>%
  mutate(sender.state = ifelse(nchar(sender.state) == 2, sender.state, NA)) %>%
  group_by(sender.state) %>%
  mutate(items.sent = sum(count)) %>%
  select(items.sent) %>%
  unique()


write_csv("data/us-choropleth-data.csv")
