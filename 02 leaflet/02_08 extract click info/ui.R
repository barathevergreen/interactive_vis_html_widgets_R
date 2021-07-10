library("leaflet")

#creating std -> shiny ui(fluidPage(leafletOutput()))
shinyUI(
  fluidPage(
    uiOutput("highlight_countries_UI"), #outputID
    uiOutput("clicked_country"),
    leafletOutput("leaflet_map") #standard output
  )
)