library("tidyverse")
library("highcharter")

gig_economy_data <- read_csv("data/gig-economy-data.csv")

## Bar chart
#datset using dplyr verbs:
#here we pipe directly into hchart rather than seperately with dataset:
gig_economy_data %>%
  group_by(country_group) %>%
  summarise(jobs.in.country = n()) %>%
  hchart(type = "bar",
         hcaes(x = country_group,
               y = jobs.in.country))
  

## Grouped bar chart
stacked_bar_data <- gig_economy_data %>%
  group_by(country_group, occupation) %>%
  summarise(jobs.in.occupation = n())

stacked_bar_data %>%
  hchart(type = "bar",
         hcaes(y = jobs.in.occupation,
               x = country_group,
               group = occupation))


## Stacked bar chart
stacked_bar_data %>%
  hchart(type = "bar",
         hcaes(y = jobs.in.occupation,
               x = country_group,
               group = occupation)) %>%
  hc_plotOptions(bar = list(stacking = "stack"))

#Stacked Percent:
stacked_bar_data %>%
  hchart(type = "bar",
         hcaes(y = jobs.in.occupation,
               x = country_group,
               group = occupation)) %>%
  hc_plotOptions(bar = list(stacking = "percent"))

#stacked Percentage - sharing all details of the stack
stacked_bar_data %>%
  hchart(type = "bar",
         hcaes(y = jobs.in.occupation,
               x = country_group,
               group = occupation)) %>%
  hc_plotOptions(bar = list(stacking = "percent")) %>%
  hc_tooltip(shared = TRUE)
