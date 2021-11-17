library(sf)
library(tmap)
library(janitor)

url <- "https://api.dataforsyningen.dk/afstemningsomraader?format=geojson" 

polling <- read_sf(url)

polling_clnd <- polling %>% 
  clean_names()



tmap_mode("view")
tm_shape(polling) +
  tm_polygons(col = "blue", alpha = .3)



getwd()
st_write(polling_clnd,
         dsn = "data",
         layer = "polling_stations",
         factorsAsCharacter = FALSE,
         delete_layer = TRUE,
         layer_options = "ENCODING=UTF-8",
         driver = "ESRI Shapefile")
