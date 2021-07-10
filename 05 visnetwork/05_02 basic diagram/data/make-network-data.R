library("tidyverse")

transport_data <- read_csv("data/transport_data.csv")


##### ============= Nodes
nodes_intermediate <- transport_data %>%
  mutate(send.location = paste(sender.country, sender.city, sender.state)) %>%
  mutate(receive.location = paste(receiver.country, receiver.city, receiver.state)) %>%
  select(-date,-number.of.items) %>%
  unique()

send_nodes <- nodes_intermediate %>%
  select(contains("send"))
colnames(send_nodes) <-
  c("country", "city", "state", "latitude", "longitude", "location")

receive_nodes <- nodes_intermediate %>%
  select(contains("receive"))
colnames(receive_nodes) <-
  c("country", "city", "state", "latitude", "longitude", "location")

nodes <- full_join(send_nodes, receive_nodes) %>%
  unique()
  # mutate(., id = 0:{
  #   nrow(.) - 1
  # }) %>%
  # rename(label = location) %>%
  # select(id, everything())

write_csv(nodes, "data/nodes.csv")

##### ============= Edges

edges <- transport_data %>%
  mutate(send.location = paste(sender.country, sender.city, sender.state)) %>%
  mutate(receive.location = paste(receiver.country, receiver.city, receiver.state)) %>%
  select(send.location, receive.location, date, number.of.items) %>%
  # mutate(from = plyr::mapvalues(send.location, from = nodes$label, to = nodes$id)) %>%
  # mutate(to = plyr::mapvalues(receive.location, from = nodes$label, to = nodes$id)) %>%
  select(send.location, receive.location, date, number.of.items)

edges <- edges %>%
  group_by(send.location, receive.location) %>%
  mutate(total.items = sum(number.of.items)) %>%
  mutate(weight = n()) %>%
  select(total.items, weight) %>%
  ungroup() %>%
  unique()

write_csv(edges, "data/edges.csv")
