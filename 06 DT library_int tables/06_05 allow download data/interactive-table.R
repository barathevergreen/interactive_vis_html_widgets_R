library("tidyverse")
library("DT")
library("stringr")

transport_data <- read_csv("data/transport_data.csv")

pretty_headers <- gsub("[.]", " ", colnames(transport_data)) %>%
  str_to_title()


transport_data %>%
  datatable(
    rownames = FALSE,
    colnames = pretty_headers,
    filter = list(position = "top"),
    options = list(
      dom = "Bfrtip",
      buttons = I("colvis"),
      language = list(sSearch = "Filter:")
    ),
    extensions = c("Buttons", "Responsive")
  )

#add option to enable CSV and Excel buttons
#they are already part of buttons extension
#so we just add them
transport_data %>%
  datatable(
    rownames = FALSE,
    colnames = pretty_headers,
    filter = list(position = "top"),
    options = list(
      dom = "Bfrtip",
      buttons = c("colvis","csv","excel"),
      language = list(sSearch = "Filter:")
    ),
    extensions = c("Buttons", "Responsive")
  )
