library("tidyverse")
library("highcharter")

bbv_truth_table <- read_csv("data/bbv_truth_table.csv")

bbv_truth_table %>%
  hchart("treemap",
         hcaes(
           value = n,
           colorValue = n,
           name = label
         )) %>%
  hc_colorAxis(minColor = '#FFFFFF',
               maxColor = JS("Highcharts.getOptions().colors[0]")) %>%
  hc_tooltip(
    formatter = JS(
      "function(){
      console.log(this);
      return this.point.label + 
      '<br/>' + 
      'Number of individuals: ' + this.point.value;
      }"
        
    ))
