lifeExp_quantile_palette <- colorQuantile("YlOrRd",
                                          gapminder_world$lifeExp)

#Improvising with weight, Labels, popups:
#Let us pipe to leaflet
gapminder_world %>%
  leaflet() %>%
  addPolygons(weight = 1,
              label = ~name,
              color = ~lifeExp_quantile_palette(lifeExp),
              popup = ~paste("Country:",name,
                             "<br/>",
                             "Population:",pop))