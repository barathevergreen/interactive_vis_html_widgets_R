library("visNetwork")

shinyUI(fluidPage(
  uiOutput("remove_superculture_UI"),
  uiOutput("click_ui"),
  visNetworkOutput("got_network")
))