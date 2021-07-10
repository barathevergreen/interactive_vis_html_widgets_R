library("tidyverse")
library("oidnChaRts")
library("sf")
library("leaflet")


shinyServer(function(input, output, session) {
  output$highlight_countries_UI <- renderUI({
    selectInput(
      "countries_to_remove",
      "Remove countries",
      choices = unique(data_world_shapefiles$name),
      multiple = TRUE,
      width = "100%"
    )
    
  })
  
  output$clicked_country <- renderUI({
    if (is.null(input$leaflet_map_shape_click)) {
      fluidRow(column("Map not clicked yet",
                      width = 12))
    } else {
      fluidRow(column(
        paste0("Selected Country: ", input$leaflet_map_shape_click$id),
        width = 12
      ),
      column(
        paste0(
          "Click coordinates: ",
          input$leaflet_map_shape_click$lat,
          ",",
          input$leaflet_map_shape_click$lng
        ),
        width = 12
      ))
    }
    
  })
  
  output$leaflet_map <- renderLeaflet({
    data_world_shapefiles %>%
      leaflet() %>%
      addTiles() %>%
      addPolygons(label = ~ name,
                  weight = 1,
                  layerId = ~ name)
    
  })
  
  observeEvent(input$countries_to_remove, {
    
    leafletProxy("leaflet_map", session) %>%
      removeShape(input$countries_to_remove)
    
    
  })
  
})