library("leaflet")

shinyUI(
  fluidPage(
    uiOutput("highlight_countries_UI"),
    uiOutput("clicked_country"),
    leafletOutput("leaflet_map")
  )
)