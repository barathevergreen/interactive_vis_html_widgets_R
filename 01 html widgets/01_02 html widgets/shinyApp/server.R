library("shiny")
library("tidyverse")
library("geosphere")
library("statesRcontiguous")
library("leaflet")

sample_geo_lines <- read_csv("data/sample_geo_lines.csv")

shinyServer(function(input, output) {
  output$date_range_UI <- renderUI({
    dateRangeInput(
      "date_range",
      label = "Dates to include:",
      start = min(sample_geo_lines$date, na.rm = TRUE),
      end = max(sample_geo_lines$date, na.rm = TRUE),
      startview = "decade"
    )
    
  })
  
  geo_lines_df <- eventReactive(input$date_range,
                                {
                                  sample_geo_lines %>%
                                    filter(date >= input$date_range[1] & date <= input$date_range[2])
                                })
  
  geo_lines_spl <- eventReactive(input$date_range,
                                      {
                                        
                                        geo_lines_df <- geo_lines_df()
                                        
                                        geo_lines <- gcIntermediate(
                                          geo_lines_df %>%
                                            select(start.longitude, start.latitude),
                                          geo_lines_df %>%
                                            select(end.longitude, end.latitude),
                                          sp = TRUE, # SpatialLines are what Leaflet wants
                                          addStartEnd = TRUE, # By default this is FALSE, and would be inaccurate
                                          n = 50 # number of intermediate points
                                        )
                                        geo_lines
                                      })
  
  output$leaflet_map <- renderLeaflet(
    leaflet() %>%
      addTiles() %>%
      addPolylines(
        data = geo_lines_spl(),
        color = "#2c7bb6",
        opacity = 0.2
      ) %>%
      addPolygons(
        data = shp_all_us_states,
        weight = 1,
        color = "#000000",
        popup = ~ paste("State:", state.name)
      ) %>%
      addCircleMarkers(
        data = geo_lines_df(),
        lat = ~ end.latitude,
        lng = ~ end.longitude,
        radius = 3,
        color = "#1b9e77",
        popup = ~ paste(
          "Location:",
          end.location,
          "<p>Total Items Received:",
          items.received
        )
      ) %>%
      addCircleMarkers(
        data = geo_lines_df(),
        lat = ~ start.latitude,
        lng = ~ start.longitude,
        radius = 3,
        color = "#d95f02",
        popup = ~ paste(
          "Location:",
          start.location,
          "<p>Total Items Sent:",
          items.send
        )
      )
    
  )
  
})