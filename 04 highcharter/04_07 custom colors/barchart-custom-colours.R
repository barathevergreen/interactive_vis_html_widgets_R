library("tidyverse")
library("highcharter")
library("RColorBrewer")

gig_economy_data <- read_csv("data/gig-economy-data.csv")

## Use tidyverse to add colours
gig_economy_data <- gig_economy_data %>%
  mutate(
    country.group.color = plyr::mapvalues(
      country_group,
      from = c(
        "all Africa",
        "Australia",
        "Canada",
        "India",
        "other Americas",
        "other Asia and Oceania",
        "other Europe",
        "United Kingdom",
        "United States"
      ),
      to = brewer.pal(9, "Paired")
    ),
    occupation.color = plyr::mapvalues(
      occupation,
      from = unique(gig_economy_data$occupation),
      to = brewer.pal(length(unique(
        gig_economy_data$occupation
      )), "Paired")
    )
  )

gig_economy_data #%>% view()

  ## Bar chart
gig_economy_data %>%
  group_by(country_group) %>%
  summarise(jobs.in.country = n()) %>%
  hchart(type = "bar",
         hcaes(
           x = country_group,
           y = jobs.in.country
         ))

#Bar Chart with colors generated:
#we need to ensure colour column is available as we use summarise. If needed need to add in group by
gig_economy_data %>%
  group_by(country_group, country.group.color) %>%
  summarise(jobs.in.country = n()) %>%
  hchart(type = "bar",
         hcaes(
           x = country_group,
           y = jobs.in.country,
           color = country.group.color
         ))

## Grouped bar chart
#when color aesthetic of entire series is not mentioned
#hcaes only applies inside its scope and not the color brewer palette
gig_economy_data %>%
  group_by(country_group, occupation,occupation.color) %>%
  summarise(jobs.in.occupation = n()) %>%
  hchart(type = "bar",
         hcaes(
           x = country_group,
           y = jobs.in.occupation,
           group = occupation,
           color = occupation.color
         ))

#applying color attribute to entire scope
#getting unique values of occupation.color
gig_economy_data %>%
  group_by(country_group, occupation,occupation.color) %>%
  summarise(jobs.in.occupation = n()) %>%
  hchart(type = "bar",
         hcaes(
           x = country_group,
           y = jobs.in.occupation,
           group = occupation,
           #color = occupation.color
         ),
         color = unique(gig_economy_data$occupation.color))



