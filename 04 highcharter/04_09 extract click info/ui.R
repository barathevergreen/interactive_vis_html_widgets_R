library("highcharter")

shinyUI(fluidPage(
  wellPanel("mouseOver and click the scatter plot for additional information"),
  uiOutput("click_ui"),
  uiOutput("mouseOver_ui"),
  highchartOutput("scatter_plot")
))