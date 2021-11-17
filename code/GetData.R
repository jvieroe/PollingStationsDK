library(sf)
library(tmap)

url <- "https://api.dataforsyningen.dk/afstemningsomraader?format=geojson" 

polling <- read_sf(url)


tmap_mode("view")
tm_shape(polling) +
  tm_polygons(col = "blue", alpha = .3)
