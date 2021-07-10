library("oidnChaRts")
library("plotly")
library("highcharter")

data_stacked_bar_chart %>%
  group_by(country_group, occupation) %>%
  summarise(total = sum(count)) %>%
  ungroup() %>%
  stacked_bar_chart(library = "highcharter",
                    categories.column = ~country_group,
                    subcategories.column = ~occupation,
                    value.column = ~total)

data_stacked_bar_chart %>%
  group_by(country_group, occupation) %>%
  summarise(total = sum(count)) %>%
  ungroup() %>%
  stacked_bar_chart(library = "plotly",
                    categories.column = ~country_group,
                    subcategories.column = ~occupation,
                    value.column = ~total)

data_stacked_bar_chart %>%
  group_by(country_group, occupation) %>%
  summarise(total = sum(count)) %>%
  ungroup() %>%
  stacked_bar_chart(library = "plotly",
                    categories.column = ~country_group,
                    subcategories.column = ~occupation,
                    value.column = ~total) %>%
  layout(margin = list(l = 180))
