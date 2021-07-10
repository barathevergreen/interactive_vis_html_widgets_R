observeEvent(input$remove_superculture,
             {
               print(
                 got_nodes %>%
                   filter(superculture %in% input$remove_superculture) %>%
                   select(id) %>%
                   .[[1]]
               )
               
               # nodes_to_remove <- got_nodes %>%
               #   filter(superculture %in% input$remove_superculture) %>%
               #   select(id) %>%
               #   .[[1]]
               # 
               # visNetworkProxy("got_network") %>%
               #   visRemoveNodes(nodes_to_remove)
               
             })