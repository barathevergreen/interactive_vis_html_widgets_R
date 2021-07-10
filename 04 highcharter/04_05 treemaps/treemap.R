library("tidyverse")
library("highcharter")

## Data from https://doi.org/10.6084/m9.figshare.4707316
bbv_truth_table <- read_csv("data/bbv_truth_table.csv")

#hchart treemap from data
bbv_truth_table %>%
  hchart(type = "treemap",
         hcaes(name = label,
               value = n,
               colorValue = n)) 

#With colour difference based on value
bbv_truth_table %>%
  hchart(type = "treemap",
         hcaes(name = label,
               value = n,
               colorValue = n)) %>%
  hc_colorAxis(minColor = "#FFFFFF",
               maxColor = JS("Highcharts.getOptions().colors[2]"))
