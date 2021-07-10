output$selected_rows_UI = renderUI({
  if (is.null(input$transport_table_rows_selected)) {
    "No rows selected yet"
  } else {
    print(input$transport_table_rows_selected)
    
    paste("Selected rows",
          paste(input$transport_table_rows_selected, collapse = ", "))
    
  }
})