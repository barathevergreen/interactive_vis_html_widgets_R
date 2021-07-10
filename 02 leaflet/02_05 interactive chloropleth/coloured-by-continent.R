 continent_palette <- colorFactor("Dark2",
             unique(gapminder_world$continent))
 
 #Improvising with weight, Labels, popups:
 #Let us pipe to leaflet
 gapminder_world %>%
   leaflet() %>%
   addPolygons(weight = 1,
               label = ~name,
               color = ~continent_palette(continent),
               popup = ~paste("Country:",name,
                              "<br/>",
                              "Population:",pop))
 