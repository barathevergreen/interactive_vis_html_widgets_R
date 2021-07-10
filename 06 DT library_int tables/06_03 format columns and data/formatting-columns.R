library("tidyverse")
library("DT")
library("lubridate")
library("stringr")

#generate a vector of dates and apply to df 
my_dates <- ymd(c("2010-01-01",
                  "2011-02-05",
                  "2012-04-20",
                  "2014-05-10"))

#create a tibble- dataframe 
my_data <- tibble(
  transaction.date = my_dates,
  amount.in.dollars = 100:103,
  amount.in.pounds = rnorm(4, mean = 100, sd = 15)
)

#generate new column for conversion rate
my_data <- my_data %>%
  mutate(conversion = amount.in.dollars / amount.in.pounds)
  #mutate(conversion = 100 * amount.in.dollars / amount.in.pounds)

#format spaces and Heading Capitalization
pretty_headers <- gsub("[.]", " ", colnames(my_data)) %>%
  str_to_title()

#create a table without row number, with column filter and a serach label Filter:
my_data %>%
  datatable(
    rownames = FALSE,
    colnames = pretty_headers,
    filter = list(position = "top"),
    options = list(language = list(sSearch = "Filter:"))
  )

#Format Date column - with Day and Custom format
#Currency with currency symbol and European denomination indicator
#Conversion in % to understand better
my_data %>%
  datatable(
    rownames = FALSE,
    colnames = pretty_headers,
    filter = list(position = "top"),
    options = list(language = list(sSearch = "Filter:"))
  ) %>%
  formatCurrency("amount.in.dollars",
                 currency = "$") %>%
  formatCurrency("amount.in.pounds",
                 currency = "£") %>%
  formatDate("transaction.date", 
             method = "toDateString") %>%
  formatPercentage("conversion", 
                   digits = 2, 
                   dec.mark = ",")
