library("tidyverse")
library("lubridate")
library("highcharter")
library("oidnChaRts")

##Create a prompt dataset for hc:
data_stacked_bar_chart_hcplot <- data_stacked_bar_chart %>%
  group_by(country_group, occupation) %>%
  summarise(total = sum(count)) %>%
  ungroup()

## =================== BarChart
data_stacked_bar_chart_hcplot%>% 
  hchart("bar",
         hcaes(y = total,
               x = country_group,
               group = occupation))

#stacked bar chart:
data_stacked_bar_chart_hcplot %>%
  hchart("bar",
         hcaes(y = total,
               x = country_group,
               group = occupation)) %>%
  hc_plotOptions(series = list(stacking = "stack"))

#stacked percentage bar chart
#tooltip not enabled - no simultaneous display
data_stacked_bar_chart_hcplot %>%
  hchart("bar",
         hcaes(y = total,
               x = country_group,
               group = occupation)) %>%
  hc_plotOptions(series = list(stacking = "percent")) %>%
  hc_tooltip(shared = TRUE)


## =================== Scatter
data_scatter_plot %>%
  hchart("scatter",
         hcaes(y = y,
               x = x,
               group = type))

## =================== Line Chart
highchart() %>% 
  hc_add_series(data = data_line_chart,
                type = "line",
                hcaes(y = y,
                      x = x,
                      group = trace))

## =================== Timeseries
online_labour_index <- read_csv("data/online_labour_index.csv") %>%
  mutate(date = dmy(date))

highchart(type = "stock") %>%
  hc_add_series(data = online_labour_index,
                type = "line",
                hcaes(
                  x = date,
                  y = count,
                  group = occupation
                ))

## =================== Choropleth
library("jsonlite")
library("gapminder")

world_shapefiles <- fromJSON("data/world_geoJSON.json", simplifyVector = FALSE)

gapminder_most_recent <- gapminder %>%
  filter(year == max(year))

#choropleth - Continuous
highchart() %>%
  hc_add_series_map(world_shapefiles,
                    gapminder_most_recent,
                    value = "pop",
                    joinBy = c("name", "country"),
                    name = paste("Population in", max(gapminder_most_recent$year))
  ) %>%
  hc_colorAxis(stops = color_stops()) %>%
  hc_legend(valueDecimals = 0) %>%
  hc_mapNavigation(enabled = TRUE)





