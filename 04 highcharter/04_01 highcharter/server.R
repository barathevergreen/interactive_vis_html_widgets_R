library("highcharter")
library("shiny")

if(!"hc_add_event_point" %in% getNamespaceExports("highcharter")){
  source("hc_events.R")
}

shinyServer(
  function(input, output, session){
    
    df <- data.frame(x = 1:5, y = 1:5, otherInfo = letters[11:15])
    
    output$plot_hc <- renderHighchart({
      
      highchart() %>%
        hc_add_series(df, "scatter") %>%
        hc_add_event_point(event = "click") %>%
        hc_add_event_point(event = "mouseOver")
      
    })
    
    output$click_ui <- renderUI({
      
      if(is.null(input$plot_hc_click)) return()
      
      wellPanel("Coordinates of clicked point: ",input$plot_hc_click$x, input$plot_hc_click$y)
      
    })
    
    output$mouseOver_ui <- renderUI({
      
      if(is.null(input$plot_hc_mouseOver)) return()
      
      wellPanel("Coordinates of mouseOvered point: ",input$plot_hc_mouseOver$x, input$plot_hc_mouseOver$y)
      
    })
    
    
  }
)