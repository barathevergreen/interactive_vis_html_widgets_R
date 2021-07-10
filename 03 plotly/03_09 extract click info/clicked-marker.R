output$clicked_marker <- renderUI({
  
  clicked_marker <- event_data("plotly_click",
                               source = "british_weather_facet")
  
  if (is.null(clicked_marker)) {
    fluidRow(column("No data selected yet", width = 12))
  } else {
    fluidRow(column(
      paste("Selected curve:", clicked_marker$curveNumber),
      width = 12
    ),
    column(
      paste("Coordinates:", clicked_marker$x, ",", clicked_marker$y),
      width = 12
    ))
  }
  
})
