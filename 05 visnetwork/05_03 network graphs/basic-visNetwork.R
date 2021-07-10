library("tidyverse")
library("visNetwork")

map_nodes <- read_csv("data/nodes.csv")
map_edges <- read_csv("data/edges.csv")


map_nodes <- map_nodes %>%
  mutate(id = row_number()) %>%
  mutate(title = location,
         label = city) %>%
  select(id, everything())

map_edges <- map_edges %>%
  mutate(from = plyr::mapvalues(send.location, from = map_nodes$location, to = map_nodes$id),
         to = plyr::mapvalues(receive.location, from = map_nodes$location, to = map_nodes$id)) %>%
  select(from, to, everything())

visNetwork(nodes = map_nodes, edges = map_edges)

#add a direction of travel: 
visNetwork(nodes = map_nodes, edges = map_edges) %>%
  visEdges(arrows = "to")

#arrows in the middle of the edges:
visNetwork(nodes = map_nodes, edges = map_edges) %>%
  visEdges(arrows = "middle")

#according to weight value show thickness of arrow
#as weight is quite big when visualized, we can use weight/3 or w/4
map_edges <- map_edges %>%
  mutate(width = weight/4)

visNetwork(nodes = map_nodes, edges = map_edges) %>%
  visEdges(arrows = "middle")

#color nodes by country column
#set colour using map values
map_nodes <- map_nodes %>%
  mutate(color = plyr::mapvalues(country,
                                 from = c("USA","DEU"),
                                 to = c("red", "green")))

visNetwork(nodes = map_nodes, edges = map_edges) %>%
  visEdges(arrows = "middle")

#Change shape of the nodes: 
visNetwork(nodes = map_nodes, edges = map_edges) %>%
  visEdges(arrows = "middle") %>%
  visNodes(shape = "square")

