library("tidyverse")
library("leaflet")
library("sf") #importing shape files
library("geosphere") #Great Arcs


#read letters sent dataset
geolines_data <- read_csv("data/geolines-data.csv")

geolines_data #%>% view()

#create start and end locations:
#gcIntermediate is fussy
#expects longitude first!
start_locs <- geolines_data %>%
  select(start.longitude, start.latitude)

end_locs <- geolines_data %>%
  select(end.longitude, end.latitude)

#getting intermediate points:
#convert to spatial dataframe
#convert to sf dataframe
the_great_circles <- gcIntermediate(
  p1 = start_locs, #set of start locations
  p2 = end_locs, #set of end locations
  n = 50, #no of points
  addStartEnd = TRUE, #plot start and end locations
  sp = TRUE #output an SF object
) %>%
  SpatialLinesDataFrame(data=geolines_data) %>%
  st_as_sf()

# we need a sf dataframe object
class(the_great_circles)

#so we convert to spatial line data frame and then to sf data frame
library("sp") #for spatial lines
the_great_circles <- SpatialLinesDataFrame(the_great_circles, data=geolines_data)

#to sf df
the_great_circles <- st_as_sf(the_great_circles)

class(the_great_circles)

#apply sf - df to leaflet:
leaflet() %>% 
  addTiles() %>%
  addPolylines(data = the_great_circles,
               weight = 1.5,
               label = ~paste("Start:",start.location,"End:",end.location)) %>%
  addCircleMarkers(data = the_great_circles,
                   lat = ~start.latitude,
                   lng = ~start.longitude,
                   radius = 2,
                   color = "red")

#using a preset visualization
library("oidnChaRts")

geo_lines_plot(data = geolines_data)
