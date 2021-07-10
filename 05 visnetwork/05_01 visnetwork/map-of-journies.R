library("tidyverse")
library("leaflet")
library("oidnChaRts")

transport_data <- read_csv("data/transport_data.csv")

colnames(transport_data) <- colnames(transport_data) %>%
  gsub("sender", "start", .) %>%
  gsub("receiver", "end", .)

transport_data <- transport_data %>%
  unite(start.location, c(start.country, start.city, start.state)) %>%
  unite(end.location, c(end.country, end.city, end.state))


transport_data %>%
  geo_lines_plot()

