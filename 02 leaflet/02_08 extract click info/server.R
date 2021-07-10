library("tidyverse")
#import from oidncharts{data_world_shapefiles}
library("oidnChaRts")
library("sf")
library("leaflet")

#create std shiny server
#output$outputId <- renderUI(relationship with inputID)
shinyServer(function(input, output, session) {
  
  #track clicking using shiny input variable:
  output$clicked_country <- renderUI({
    #to handle Map not clicked scenario
    if (is.null(input$leaflet_map_shape_click)) {
      fluidRow(column("Map not clicked yet",
                      width = 12))
    } else {
      print(input$leaflet_map_shape_click)
      fluidRow(column("Country:", input$leaflet_map_shape_click$id,
                      "| Latitude:",input$leaflet_map_shape_click$lat,
                      "| Longitude:",input$leaflet_map_shape_click$lng,
                      width = 12))
    }
    
  })
  
  #Remove country when selected:
  #observeEvent() - event handler - similar to reactive
  observeEvent(input$countries_to_remove, {
    #when instance is already executed, proxy brings back the live instance to be used again
    leafletProxy("leaflet_map", session) %>%
      #remove expression selected from observe event
      removeShape(input$countries_to_remove)
    
  })
  
  
  output$highlight_countries_UI <- renderUI({
    selectInput(
      "countries_to_remove",
      "Remove countries",
      choices = unique(data_world_shapefiles$name),
      multiple = TRUE, #for selecting multiple items
      width = "100%"
    )
    
    
  })
  
  #create a border using polygon of weight1
  #hover - name
  output$leaflet_map <- renderLeaflet({
    data_world_shapefiles %>%
      leaflet() %>%
      addTiles() %>%
      addPolygons(label = ~ name,
                  weight = 1,
                  layerId = ~ name)
    
  })
  
})