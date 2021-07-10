observeEvent(input$add_dummy_row,
             {
               new_row <- transport_data[1,]
               new_row[1, ] <-
                 append(c(input$new_sender_country, input$new_sender_city),
                        rep(NA, 11))
               
               dataTableProxy('transport_table') %>%
                 addRow(new_row)
             })