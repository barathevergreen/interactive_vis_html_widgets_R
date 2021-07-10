library("visNetwork")

shinyUI(fluidPage(
  fluidRow(column(
    textInput("new_sender_country",
              "Sender Country"), width = 6
  ),
  column(
    textInput("new_sender_city",
              "Sender City"), width = 6
  )),
  actionButton("add_dummy_row","Add new dummy row"),
  p(),
  "Show selected row info here",
  uiOutput("selected_rows_UI"),
  p(),
  DT::dataTableOutput("transport_table")
))