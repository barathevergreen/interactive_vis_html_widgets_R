library("tidyverse")
library("visNetwork")

# ====== Clustering
## Data from https://www.kaggle.com/mylesoneill/game-of-thrones and manipulated by hand by https://shiring.github.io/

got_nodes <- read_csv("data/GoT_nodes.csv")
got_edges <- read_csv("data/GoT_edges.csv")

got_nodes <- got_nodes %>%
  mutate(group = superculture)

#create a vis graph:
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout()

#create a legend
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout() %>%
  visLegend()

#adjust legend position - legibility
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout() %>%
  visLegend(ncol = 2)

#reducing the scope of groups
#say only interested groups
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout() %>%
  visGroups(groupname = "Unknown Culture",
            color = "red") %>%
  visGroups(groupname = "Northmen",
            color = "purple")

#tell legend not to use group column
#we need to explicitly add the ineterested groups
visNetwork(got_nodes, got_edges) %>%
  visIgraphLayout() %>%
  visGroups(groupname = "Unknown Culture",
            color = "red") %>%
  visGroups(groupname = "Northmen",
            color = "purple") %>%
  visLegend(useGroups = FALSE, 
            addNodes = list(
              list(label = "Unknown Culture",
                   color = "red"),
              list(label = "Northmen",
                   color = "purple")
            ))
