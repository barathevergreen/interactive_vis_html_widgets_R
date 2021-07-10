library("tidyverse")
library("visNetwork")

# ====== Clustering
## Data from https://www.kaggle.com/mylesoneill/game-of-thrones and manipulated by hand

#read nodes and edges
#id and label
got_nodes <- read_csv("data/GoT_nodes.csv")
#from and to
got_edges <- read_csv("data/GoT_edges.csv")

#got_nodes %>% view()

#plotting vis with igraph:
visNetwork(got_nodes,got_edges) %>%
  visIgraphLayout()

##creating a group - based on culture column
got_nodes <- got_nodes %>%
  mutate(group = superculture)
#vis network allocates color based on group
visNetwork(got_nodes,got_edges) %>%
  visIgraphLayout()


#creating a cluster:
visNetwork(got_nodes,got_edges) %>%
  visIgraphLayout() %>%
  visClusteringByGroup(groups = unique(got_nodes$group))
