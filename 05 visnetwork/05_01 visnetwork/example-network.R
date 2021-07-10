library("tidyverse")
library("visNetwork")

# ======= Basic network

map_nodes <- read_csv("data/nodes.csv")
map_edges <- read_csv("data/edges.csv")

visNetwork(map_nodes, map_edges)

# ====== Beautified network

beautified_nodes <- map_nodes
beautified_edges <- map_edges

beautified_edges <- beautified_edges %>%
  mutate(width = round(weight / 2))

beautified_nodes <- beautified_nodes %>%
  mutate(color = plyr::mapvalues(country, from = c("USA", "DEU"), to = c("#1b9e77", "#d95f02"))) %>%
  mutate(title = label) %>%
  mutate(group = country)

visNetwork(beautified_nodes, beautified_edges) %>%
  visEdges(color = "blue")

# ====== igraph

library("igraph")
letters_igraph <- graph.data.frame(beautified_edges,vertices = beautified_nodes)
visIgraph(letters_igraph, idToLabel = FALSE)

decompose(letters_igraph)[[1]] %>%
  as.undirected() %>%
  visIgraph(idToLabel = FALSE)

# ====== layout

decompose(letters_igraph)[[1]] %>%
  # as.undirected() %>%
  visIgraph(idToLabel = FALSE) %>%
  visHierarchicalLayout()
  
# ====== Clustering
## Data source: https://github.com/ShirinG/blog_posts_prep/tree/master/GoT
## Additional info: Data sources from https://www.kaggle.com/mylesoneill/game-of-thrones and manipulated by hand by https://shiring.github.io/

got_nodes <- read_csv("data/GoT_nodes.csv")
got_edges <- read_csv("data/GoT_edges.csv")

visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout()

got_nodes %>%
  mutate(group = superculture) %>%
  visNetwork(got_edges) %>%
  visClusteringByGroup(groups = unique(got_nodes$superculture)) %>%
  visIgraphLayout()

# ====== Legends
got_nodes <- read_csv("data/GoT_nodes.csv")
got_edges <- read_csv("data/GoT_edges.csv")

got_nodes_gendered <- got_nodes %>%
  mutate(group = gender) %>%
  mutate(color = recode(gender, "male" = "#1b9e77", "female" = "#d95f02"))

got_nodes_cultured <- got_nodes %>%
  mutate(group = superculture) 

visNetwork(got_nodes_cultured, got_edges) %>%
  visIgraphLayout() %>%
  visLegend()

# ====== Highlight nearest
got_nodes <- read_csv("data/GoT_nodes.csv")
got_edges <- read_csv("data/GoT_edges.csv")

got_nodes_grouped <- got_nodes %>%
  mutate(group = gender) %>%
  mutate(color = recode(gender, "male" = "#1b9e77", "female" = "#d95f02"))

visNetwork(got_nodes_grouped, got_edges) %>%
  visIgraphLayout() %>%
  visGroups(groupname = "male", color = "#1b9e77") %>%
  visGroups(groupname = "female", color = "#d95f02") %>%
  visLegend() %>%
  visOptions(highlightNearest = list(enabled = T, degree = 2, hover = T))



  
