library("tidyverse")
library("DT")
library("stringr")

transport_data <- read_csv("data/transport_data.csv")

#create basic table
transport_data %>%
  datatable()

#create basic table - without Row numbers
transport_data %>%
  datatable(rownames = FALSE)


##adjust formatted column names
#print all coumn names 
colnames(transport_data)

#substitute with regex 
#sub() for replace next, gsub() for replace all
gsub("[.]", " ", colnames(transport_data))



#For String manipulation - stringr - Capitalize First Letter of each word
gsub("[.]", " ", colnames(transport_data)) %>%
  str_to_title()

#Assign it to a var and use it in colnames argument in datatable()
pretty_headers <- gsub("[.]", " ", colnames(transport_data)) %>%
  str_to_title()

transport_data %>%
  datatable(rownames = FALSE,
            colnames = pretty_headers)

#Add filters to each column
#Show 50 entries in each page
#Label of the global filter> Search: 

transport_data %>%
  datatable(rownames = FALSE,
            colnames = pretty_headers,
            filter = list(position = "top"),
            options = list(pageLength = 50,
                           language = list(sSearch = "Filter:")))

