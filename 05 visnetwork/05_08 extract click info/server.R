library("visNetwork")
library("tidyverse")
library("shiny")

## Data sources from https://www.kaggle.com/mylesoneill/game-of-thrones and manipulated by hand by https://shiring.github.io/

got_nodes <- read_csv("data/GoT_nodes.csv")
got_edges <- read_csv("data/GoT_edges.csv")


shinyServer(function(input, output, session) {
  output$remove_superculture_UI <- renderUI({
    selectInput(
      "remove_superculture",
      "Remove supercultures",
      choices = unique(got_nodes$superculture),
      multiple = TRUE,
      width = "100%"
    )
  })
  
  output$got_network <- renderVisNetwork({
    visNetwork(got_nodes, got_edges) %>%
      visIgraphLayout() %>%
      visEvents(click = "function(nodes){
                Shiny.onInputChange('got_network_current_node_id',nodes);
                }")
    
  })
  
  #1 clicked node Handling
  output$click_ui <- renderUI({
    if (is.null(input$got_network_current_node_id)) {
      "No node has been clicked, yet"
    } else {
      if (length(input$got_network_current_node_id$node) == 0) {
        "You have clicked within the visNetwork but not on a node"
      } else {
        #printing input object - lots of info
        print(input$got_network_current_node_id)
        paste("Selected node:",
              input$got_network_current_node_id$nodes[[1]])
      }
    }
  })
  
  
  #2 Remove using filter - Observe event
  
  #print all the ids of the selected group
  observeEvent(input$remove_superculture,
               {
                 print(
                   got_nodes %>%
                     filter(superculture %in% input$remove_superculture) %>%
                     select(id) %>%
                     .[[1]]
                 )
  
  #update visNetwork accordingly               
                 nodes_to_remove <- got_nodes %>%
                   filter(superculture %in% input$remove_superculture) %>%
                   select(id) %>%
                   .[[1]]

                 visNetworkProxy("got_network") %>%
                   visRemoveNodes(nodes_to_remove)
                 
               })
  
  
})