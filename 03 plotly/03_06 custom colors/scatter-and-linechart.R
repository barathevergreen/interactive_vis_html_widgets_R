library("tidyverse")
library("plotly")


## Scatter Plot
scatter_data %>% view() <- read_csv("data/scatter_data.csv") %>% 
  mutate(color = plyr::mapvalues(
    type,
    from = c("Concordant", "Discordant"),
    to = c("#1b9e77", "#fc8d62")
  ))

#colour checker from baseR:
plot(
  rep(1, 2),
  col = c("#1b9e77", "#fc8d62"),
  pch = 19,
  cex = 3
)

#plot scatterplot:
scatter_data %>%
  plot_ly() %>%
  add_trace(
    x = ~ x,
    y = ~ y,
    color = ~ type,
    colors = ~ c("#1b9e77", "#fc8d62"),
    type = 'scatter',
    mode = "markers",
    opacity = 0.8
  )

## Using factors for scatter plot

scatter_data %>%
  #recodes values in dummy column
  mutate(new.column = recode(type, "Concordant" = "Green", "Discordant" = "Orange")) %>%
  #change levels to change colours in the plot
  mutate(new.column = factor(new.column, levels = c("Green", "Orange"))) %>%
  plot_ly() %>%
  add_trace(
    x = ~ x,
    y = ~ y,
    color = ~ new.column,
    text = ~ type,
    colors = c("#1b9e77", "#fc8d62"),
    type = 'scatter',
    mode = "markers",
    opacity = 0.8
  )

## Line Charts

lines_data <- read_csv("data/lines_data.csv")

#without mutate levels:
lines_data %>%
  mutate(new.column = plyr::mapvalues(
    trace,
    from = c(
      "[MQ 16] Local",
      "[MQ 16] Thesaurus",
      "[MQ 1] Local",
      "[MQ 1] Thesaurus",
      "Mutect"
    ),
    to = c("light blue",
           "dark blue",
           "light green",
           "dark green",
           "pink")
  )) %>%
  plot_ly() %>%
  add_trace(
    x = ~ x,
    y = ~ y,
    color = ~ new.column,
    text = ~ trace,
    colors = c("#a6cee3", "#1f78b4", "#b2df8a", "#33a02c", "#fb9a99"),
    type = 'scatter',
    mode = "lines+markers",
    opacity = 0.8
  ) %>%
  layout(yaxis = list(type = "log"))

#With mutate level
lines_data %>%
  mutate(new.column = plyr::mapvalues(
    trace,
    from = c(
      "[MQ 16] Local",
      "[MQ 16] Thesaurus",
      "[MQ 1] Local",
      "[MQ 1] Thesaurus",
      "Mutect"
    ),
    to = c("light blue",
           "dark blue",
           "light green",
           "dark green",
           "pink")
  )) %>%
  mutate(new.column = factor(new.column, levels = c("light blue",
                                                    "dark blue",
                                                    "light green",
                                                    "dark green",
                                                    "pink")
                             )) %>%
  plot_ly() %>%
  add_trace(
    x = ~ x,
    y = ~ y,
    color = ~ new.column,
    text = ~ trace,
    colors = c("#a6cee3", "#1f78b4", "#b2df8a", "#33a02c", "#fb9a99"),
    type = 'scatter',
    mode = "lines+markers",
    opacity = 0.8
  ) %>%
  layout(yaxis = list(type = "log"))
