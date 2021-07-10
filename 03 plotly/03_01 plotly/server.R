library("tidyverse")
library("plotly")
library("shiny")

## See shiny::runApp(system.file("examples", "plotlyEvents", package = "plotly")) for more examples
load("data/british_weather.rdata")

shinyServer(function(input, output, session) {
  output$clicked_marker <- renderUI({
    clicked_marker <- event_data("plotly_click",
                                 source = "british_weather_facet_wrap")
    
    print(clicked_marker)
    
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
  
  output$british_weather_facet_wrap <- renderPlotly({
    gg_facet_weather <- british_weather %>%
      mutate(tdiff = tmax - tmin) %>%
      group_by(region, mm) %>%
      dplyr::summarise(average.tdiff = mean(tdiff, na.rm = TRUE)) %>%
      ggplot(aes(
        x = mm,
        y = average.tdiff,
        group = region,
        col = region
      )) +
      geom_line() +
      geom_point() +
      labs(x = "Month", y = "Mean daily temperature difference") +
      ggtitle("Mean daily temperature difference in the UK", subtitle = "Split by region") +
      facet_wrap( ~ region)
    
    ggplotly(gg_facet_weather,
             source = "british_weather_facet_wrap")
  })
  
})