#install oidncharts:
#devtools::install_github("ox-it/oidnChaRts", force = TRUE)
library("tidyverse")
library("oidnChaRts")

#preview dataset:
data_stacked_bar_chart %>%
  view()

head(data_stacked_bar_chart)

#create a data to plot
data_to_plot <- data_stacked_bar_chart %>%
  group_by(country_group, occupation) %>%
  summarise(total = sum(count)) %>%
  ungroup()

#use stacked barchart(flipped) with hc:
library("highcharter")
data_to_plot %>%
  stacked_bar_chart(
    library = "highcharter",
    categories.column = ~ country_group,
    subcategories.column = ~ occupation,
    value.column = ~ total
  )

#use with plotly
library("plotly")
data_to_plot %>%
  stacked_bar_chart(
    library = "plotly",
    categories.column = ~ country_group,
    subcategories.column = ~ occupation,
    value.column = ~ total
  ) %>%
  #adjust layout to fit axes indicators
  layout(margin = list(l = 150),
         yaxis = list(title = ""))
