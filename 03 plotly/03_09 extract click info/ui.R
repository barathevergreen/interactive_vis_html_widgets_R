library("plotly")

shinyUI(
  fluidPage(
    "Clicked marker coordinates:",
    uiOutput("clicked_marker"),
    plotlyOutput("british_weather_facet_wrap")
  )
)