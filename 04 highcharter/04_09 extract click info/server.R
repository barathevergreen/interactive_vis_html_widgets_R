library("highcharter")
library("shiny")

if (!"hc_add_event_point" %in% getNamespaceExports("highcharter")) {
  source("hc_events.R")
}

shinyServer(function(input, output, session) {
  scatter_data <-
    data.frame(x = 1:5,
               y = 1:5,
               otherInfo = letters[11:15])
  lines_data <-
    data.frame(x = 1:5,
               y = 11:15,
               otherInfo = letters[11:15])

  output$scatter_plot <- renderHighchart({
    highchart() %>%
      hc_add_series(scatter_data,
                    type = "scatter",
                    name = "uk-data") %>%
      hc_add_series(lines_data,
                    type = "line",
                    name = "us-data") %>%
      hc_add_event_point(event = "click") %>%
      hc_add_event_point(event = "mouseOver")
  })


  
  #if scatterplot click is empty it returns nothing
  #else displays the coordinates
  output$click_ui <- renderUI({
    if (is.null(input$scatter_plot_click)) {
      return()
    }
    print(input$scatter_plot_click)
    wellPanel(
      "Coordinates of clicked point: ",
      input$scatter_plot_click$x,
      input$scatter_plot_click$y,
      "from series:",
      input$scatter_plot_click$series
    )
    
  })
  
  #if scatterplot mouse over is empty it returns nothing
  #else displays the coordinates
  output$mouseOver_ui <- renderUI({
    if (is.null(input$scatter_plot_mouseOver)) {
      return()
    }
    print(input$scatter_plot_mouseOver)
    wellPanel(
      "Coordinates of mouseOvered point: ",
      input$scatter_plot_mouseOver$x,
      input$scatter_plot_mouseOver$y,
      "from series:",
      input$scatter_plot_mouseOver$series
    )
    
  })

})