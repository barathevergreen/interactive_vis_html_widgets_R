library("highcharter")

shinyUI(fluidPage(
  wellPanel("mouseOver and click points for additional information"),
  uiOutput("click_ui"),
  uiOutput("mouseOver_ui"),
  highchartOutput("plot_hc")
))