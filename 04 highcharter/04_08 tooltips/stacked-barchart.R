library("tidyverse")
library("highcharter")

gig_economy_data <- read_csv("data/gig-economy-data.csv")

#display only one category:
gig_economy_data %>%
  group_by(country_group, occupation) %>%
  summarise(jobs.in.occupation = n()) %>%
  mutate(percentage.of.jobs = 100 * jobs.in.occupation / sum(jobs.in.occupation)) %>%
  hchart(type = "bar",
         hcaes(
           x = country_group,
           y = percentage.of.jobs,
           group = occupation
         )) %>%
  hc_plotOptions(series = list(stacking = "stack"))

#display all categories:
gig_economy_data %>%
  group_by(country_group, occupation) %>%
  summarise(jobs.in.occupation = n()) %>%
  mutate(percentage.of.jobs = 100 * jobs.in.occupation / sum(jobs.in.occupation)) %>%
  hchart(type = "bar",
         hcaes(
           x = country_group,
           y = percentage.of.jobs,
           group = occupation
         )) %>%
  hc_plotOptions(series = list(stacking = "stack"))%>%
  hc_tooltip(shared = TRUE,
             ValueDecimals = 2)
