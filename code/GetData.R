library(tidyverse)
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


# polling_clnd <- polling_clnd %>% 
#   mutate(dagi_ID = dagi_id) %>% 
#   select(-dagi_id)
# 
# polling_clnd <- polling_clnd %>% 
#   select(c(dagi_ID,
#            setdiff(names(polling_clnd),
#                    "dagi_ID")
#            )
#          )


st_write(polling_clnd,
         dsn = "data",
         layer = "polling_stations",
         #factorsAsCharacter = FALSE,
         delete_layer = TRUE,
         overwrite = TRUE,
         layer_options = "ENCODING=UTF-8",
         driver = "ESRI Shapefile")

