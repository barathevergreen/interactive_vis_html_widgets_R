library("visNetwork")

shinyUI(fluidPage(
  uiOutput("remove_superculture_UI"),
  uiOutput("click_ui"),
  "Below is information about the last selected node:",
  visNetworkOutput("got_network")
))