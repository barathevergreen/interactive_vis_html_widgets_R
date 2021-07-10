library("tidyverse")
library("visNetwork")
library("igraph")

## Data sources: https://www.kaggle.com/mylesoneill/game-of-thrones and manipulated by hand by https://shiring.github.io/

got_nodes <- read_csv("data/GoT_nodes.csv")
got_edges <- read_csv("data/GoT_edges.csv")

#normal vis.js - takes more time
visNetwork(got_nodes, got_edges)

#with igraph - very faster
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout()

#explicit specify - star
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout(layout = "layout.star")

#explicit specify - grid
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout(layout = "layout_on_grid")

#explicit specify - sphere
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout(layout = "layout_on_sphere")
 

