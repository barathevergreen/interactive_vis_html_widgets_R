library("leaflet")
library("shiny")

shinyUI(
  fluidPage(
    uiOutput("date_range_UI"),
    leafletOutput("leaflet_map")
  )
)