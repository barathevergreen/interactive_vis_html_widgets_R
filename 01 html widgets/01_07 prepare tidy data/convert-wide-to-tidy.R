library("tidyverse")
library("readxl")

wide_data <- read_xlsx("data-raw/wide-format.xlsx")

wide_data %>%
  gather(year, horses, contains("horses"))

wide_data %>%
  gather(year, horses, contains("horses")) %>%
  mutate(year = as.integer(gsub(".*in ","", year)))

library("highcharter")
wide_data %>%
  gather(year, horses, contains("horses")) %>%
  mutate(year = as.integer(gsub(".*in ","", year))) %>%
  group_by(Country) %>%
  hchart(type = "column",
         hcaes(
           x = year,
           y = horses,
           group = Country
         ))