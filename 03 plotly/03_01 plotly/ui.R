library("plotly")

shinyUI(
  fluidPage(
    # uiOutput("highlight_countries_UI"),
    uiOutput("clicked_marker"),
    plotlyOutput("british_weather_facet_wrap")
  )
)