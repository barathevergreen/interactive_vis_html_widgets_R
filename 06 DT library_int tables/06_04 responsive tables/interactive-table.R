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
    options = list(language = list(sSearch = "Filter:"))
  )

#Add Responsive nature - Shrinking columns
transport_data %>%
  datatable(
    rownames = FALSE,
    colnames = pretty_headers,
    extensions = "Responsive",
    filter = list(position = "top"),
    options = list(language = list(sSearch = "Filter:"))
  )

#Giving user - customize option to add or remove columns
#add buttons along with responsive
#mention buttons argument with column visible function
#specify which dom elements should be included
transport_data %>%
  datatable(
    rownames = FALSE,
    colnames = pretty_headers,
    extensions = c("Responsive","Buttons"),
    filter = list(position = "top"),
    options = list(language = list(sSearch = "Filter:"),
                   buttons = I("colvis"),
                   dom = "Bfrtip") #various combinations of table control alignment
  )

