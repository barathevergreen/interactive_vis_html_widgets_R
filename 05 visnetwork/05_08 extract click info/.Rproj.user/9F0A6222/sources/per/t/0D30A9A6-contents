output$click_ui <- renderUI({
  if (is.null(input$got_network_current_node_id)) {
    "No node has been clicked, yet"
  } else {
    if (length(input$got_network_current_node_id$node) == 0) {
      "You have clicked within the visNetwork but not on a node"
    } else {
      print(input$got_network_current_node_id)
      paste("Selected node:",
            input$got_network_current_node_id$nodes[[1]])
    }
  }
})