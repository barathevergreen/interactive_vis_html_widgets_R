library("tidyverse")
library("visNetwork")
library("igraph")

# ======= Basic network

map_nodes <- read_csv("data/nodes.csv")
map_edges <- read_csv("data/edges.csv")

map_nodes <- map_nodes %>%
  mutate(id = row_number()) %>%
  mutate(title = location,
         label = city) %>%
  select(id, everything())

map_edges <- map_edges %>%
  mutate(
    from = plyr::mapvalues(send.location, from = map_nodes$location, to = map_nodes$id),
    to = plyr::mapvalues(receive.location, from = map_nodes$location, to = map_nodes$id)
  ) %>%
  select(from, to, everything())

visNetwork(map_nodes,
           map_edges)

#use graph.data.frame to convert to igraph object
letters_igraph <- graph.data.frame(map_edges, 
                                   vertices = map_nodes)
#verify igraph object
class(letters_igraph)

#Arrange and get all details - from largest to smallest
decompose(letters_igraph)

#Biggest component
decompose(letters_igraph)[[1]]

#Plot a vis
#by default idToLabel is TRUE
decompose(letters_igraph)[[1]] %>%
  visIgraph()

#Explicitly set idToLabel is FALSE
decompose(letters_igraph)[[1]] %>%
  visIgraph(idToLabel = FALSE)
