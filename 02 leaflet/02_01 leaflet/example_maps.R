library("oidnChaRts")
library("leaflet")
library("sf")
library("tidyverse")

## Scatter Geo Markers - load sample dataset from data_geo_marker_plot {oidnChaRts}
head(data_geo_marker_plot)
data_geo_marker_plot %>%
  view()

##Apply vis
data_geo_marker_plot %>%
  leaflet() %>% #create empty leaflet plot
  addTiles() %>%#Add world tiles on top of it
  addMarkers(label = ~city)#Add city indicators



## Scatter Geo Plots
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  #Great to add ind based on a value. eg. Most impacted
  addCircleMarkers(radius = ~count/8,
                   label = ~city)

## Clustered Scatter Geo Plots
#Great option to see overall distribution
#Zoom for individual count
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = ~count/8,
                   label = ~city,
                   clusterOptions = markerClusterOptions())

## Choropleth
#Setting a palette colur - Set2 to each continent:
choropleth_colorPal <- colorFactor("Set2", unique(data_world_shapefiles$continent))

data_world_shapefiles %>%
  view()

#apply palette colours:
data_world_shapefiles %>%
  leaflet() %>%
  addTiles() %>%
  #area indicators - addPolygons
  addPolygons(color = ~choropleth_colorPal(continent),
              label = ~name,
              weight = 1) %>%
  #addLegend
  #add palette colurs using: 
  #brewer.pal(n, name) Here n = length from continents:
  addLegend(colors = RColorBrewer::brewer.pal(length(unique(data_world_shapefiles$continent)), "Set2"),
            labels = unique(data_world_shapefiles$continent))

