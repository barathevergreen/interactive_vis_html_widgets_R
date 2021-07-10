library("tidyverse")
library("visNetwork")

map_nodes <- read_csv("data/nodes.csv")
map_edges <- read_csv("data/edges.csv")


map_nodes <- map_nodes %>%
  mutate(id = row_number()) %>%
  mutate(label = location) %>%
  select(id, everything())

map_edges <- map_edges %>%
  mutate(from = plyr::mapvalues(send.location, from = map_nodes$location, to = map_nodes$id),
         to = plyr::mapvalues(receive.location, from = map_nodes$location, to = map_nodes$id)) %>%
  select(from, to, everything())

visNetwork(nodes = map_nodes, edges = map_edges)