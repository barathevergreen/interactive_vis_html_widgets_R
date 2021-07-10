library("DT")
library("shiny")
library("tidyverse")

transport_data <- read_csv("data/transport_data.csv")

transport_sample_data <- transport_data %>%
  sample_n(8)

shinyServer(function(input, output, session) {
  output$transport_table <- DT::renderDataTable({
    transport_sample_data
  }, rownames = FALSE,
  server = FALSE, ## Required for addRow to work
  extensions = c("Responsive", "Buttons"),
  options = list(dom = 'Bfrtip', buttons = c('colvis', "csv")))
  

  output$selected_rows_UI = renderUI({

    if (is.null(input$transport_table_rows_selected)) {
      "No rows selected yet"
    } else {
      print(input$transport_table_rows_selected) 
      paste("Selected rows",
            paste(input$transport_table_rows_selected, collapse = ", "))
      
    }
  })
  
  
  observeEvent(input$add_dummy_row,
               {
                 new_row <- transport_data[1,]
                 new_row[1, ] <-
                   append(c(input$new_sender_country, input$new_sender_city),
                          rep(NA, 11))
                 
                 dataTableProxy('transport_table') %>%
                   addRow(new_row)
               })
  
})

