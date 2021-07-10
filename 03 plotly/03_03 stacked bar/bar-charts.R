library("tidyverse")
library("plotly")

gig_economy_data <- read_csv("data/gig-economy-data.csv")

## Bar chart - We use numbers in X to make it interesting:
gig_economy_data %>% 
  group_by(country_group) %>% 
  summarise(jobs.in.country = n()) %>% 
  plot_ly() %>% #define x,y in add_trace
  add_trace(x = ~jobs.in.country,
            y = ~country_group)
  

## Grouped/Stacked bar chart - In the same plot we use additional grouping - for more clear explanation
stacked_bar_data <- gig_economy_data %>%
  group_by(country_group, occupation) %>%
  summarise(jobs.in.occupation = n())

stacked_bar_data 


## Stacked bar chart
stacked_bar_data %>%
  plot_ly() %>%
  add_trace(x = ~jobs.in.occupation,
            y = ~country_group,
            color = ~occupation, #subgroup
            type = "bar") %>%
  layout(barmode = "stack") # Set clear stacks instead of small bars


#with percentage - Equal Bars of varying percentage
## Stacked bar chart
stacked_bar_data %>%
  plot_ly() %>%
  add_trace(x = ~jobs.in.occupation,
            y = ~country_group,
            color = ~occupation,
            type = "bar") %>%
  layout(barmode = "stack",
         barnorm = "percent")

#fix Axes labels(For older versions)
stacked_bar_data %>%
  plot_ly() %>%
  add_trace(x = ~jobs.in.occupation,
            y = ~country_group,
            color = ~occupation,
            type = "bar") %>%
  layout(barmode = "stack",
         barnorm = "percent",
         margin = list(l=150))

