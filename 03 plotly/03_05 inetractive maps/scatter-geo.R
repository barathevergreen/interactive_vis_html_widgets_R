library("tidyverse")
library("oidnChaRts")
library("plotly")

#seperate dataset into two columns based on delimiter:
data_scatter_geo <- data_scatter_geo %>% 
  separate(location.name, sep = ",", into = c("country", "city"), 
           extra = "merge") 

#create a scatter geo plot:
data_scatter_geo %>%
  plot_geo() %>%
  add_trace(x = ~longitude,
            y = ~latitude,
            size = ~count,
            color = ~country,
            opacity = 0.8) %>%
  layout(
    geo = list(
      showlakes = TRUE,
      showrivers = TRUE,
      showcountries = TRUE
    )
  )