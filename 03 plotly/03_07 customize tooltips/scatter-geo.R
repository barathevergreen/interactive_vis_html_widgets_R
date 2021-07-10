library("tidyverse")
library("oidnChaRts")
library("plotly")

#splitting the data into new column based on delimiter:
data_scatter_geo <- data_scatter_geo %>%
  separate(location.name, sep = ",", into = c("country", "city"), 
           extra = "merge")

#Scatter Geo:
#Consider below plot:
data_scatter_geo %>% 
  plot_geo() %>%
  add_trace(x = ~longitude,
            y = ~latitude,
            colors = "Paired",
            color = ~country,
            size = ~count,
            opacity = 0.9) %>%
  layout(geo = list(
    showlakes = TRUE,
    showrivers = TRUE,
    showcountries = TRUE,
    projection = list(type = 'Mercator')
  ))

#to display a city name when hover: 
#add text = ~city column
data_scatter_geo %>% 
  plot_geo() %>%
  add_trace(x = ~longitude,
            y = ~latitude,
            colors = "Paired",
            color = ~country,
            text = ~city,
            size = ~count,
            opacity = 0.9) %>%
  layout(geo = list(
    showlakes = TRUE,
    showrivers = TRUE,
    showcountries = TRUE,
    projection = list(type = 'Mercator')
  ))

#to show multiple values when hover
#city, count columns:

data_scatter_geo %>% 
  plot_geo() %>%
  add_trace(x = ~longitude,
            y = ~latitude,
            colors = "Paired",
            color = ~country,
            text = ~paste("City:", city, "\n", "Count:", count),
            size = ~count,
            opacity = 0.9) %>%
  layout(geo = list(
    showlakes = TRUE,
    showrivers = TRUE,
    showcountries = TRUE,
    projection = list(type = 'Mercator')
  ))

#to show only few values when hover using hoverinfo = argument
#Lets just see ONLY the count value when hovered
data_scatter_geo %>% 
  plot_geo() %>%
  add_trace(x = ~longitude,
            y = ~latitude,
            colors = "Paired",
            color = ~country,
            text = ~paste("Count:", count),
            size = ~count,
            opacity = 0.9,
            hoverinfo = c("text")) %>%
  layout(geo = list(
    showlakes = TRUE,
    showrivers = TRUE,
    showcountries = TRUE,
    projection = list(type = 'Mercator')
  ))
