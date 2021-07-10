library("leaflet")

## Traditional syntax
addCircleMarkers(map = addTiles(map = leaflet()),
                 data = quakes)

## Pipe Syntax