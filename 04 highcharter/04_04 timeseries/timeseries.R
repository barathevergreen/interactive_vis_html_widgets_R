library("tidyverse")
library("lubridate")
library("highcharter")

online_labour_index <- read_csv("data/online_labour_index.csv")

#convert to ISO -> date type with lubridate:
online_labour_index <- online_labour_index %>%
  mutate(date = dmy(date))

online_labour_index

#timeseries:
#Different from other charts
#we use highchart(type) and pipe it to hc_add_series
  highchart(type = "stock") %>%
  hc_add_series(data = online_labour_index,
                type = "line",
                hcaes(x = date,
                      y = count,
                      group = occupation))
  
#with legend
highchart(type = "stock") %>%
    hc_add_series(data = online_labour_index,
                  type = "line",
                  hcaes(x = date,
                        y = count,
                        group = occupation)) %>%
  hc_legend(enabled = TRUE)

#we can load without animation from left to right
highchart(type = "stock") %>%
  hc_add_series(data = online_labour_index,
                type = "line",
                hcaes(x = date,
                      y = count,
                      group = occupation)) %>%
  hc_legend(enabled = TRUE) %>%
  hc_plotOptions(series = list(animation = FALSE))
  