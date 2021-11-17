library(tidyverse)
library(magrittr)
library(sf)
library(rgdal)
library(janitor)
library(labelled)
library(tmap)
library(lubridate)


# ----- Get data -----
url <- "https://api.dataforsyningen.dk/afstemningsomraader?format=geojson"

polling <- read_sf(url)


# ----- Clean data -----
var_label(polling) <- colnames(polling)

polling <- polling %>% 
  tibble() %>%
  clean_names() %>% 
  dplyr::rename(dagi_ID = dagi_id,
                station = afstemningsstednavn,
                st_id = afstemningsstedadresseid,
                st_add = afstemningsstedadressebetegnelse,
                st_lon = afstemningssted_adgangspunkt_x,
                st_lat = afstemningssted_adgangspunkt_y,
                muni_code = kommunekode,
                muni = kommunenavn,
                regi_code = regionskode,
                regi = regionsnavn,
                kreds_id = opstillingskredsnummer,
                kreds = opstillingskredsnavn,
                stkreds_id = storkredsnummer,
                stkreds = storkredsnavn,
                valg_ld_l = valglandsdelsbogstav,
                valg_ld = valglandsdelsnavn,
                edit = aendret,
                geo_edit = geo_aendret,
                geo_v = geo_version,
                vcent_lon = visueltcenter_x,
                vcent_lat = visueltcenter_y) %>% 
  st_as_sf() %>% 
  st_cast("MULTIPOLYGON")


polling <- polling %>% 
  mutate(edit = lubridate::ymd_hms(edit),
         geo_edit = lubridate::ymd_hms(geo_edit)) %>% 
  mutate(edit = as.character(edit),
         geo_edit = as.character(geo_edit))



# ----- Export data -----
getwd()

st_write(polling,
         dsn = "data",
         layer = "polling_stations",
         #factorsAsCharacter = FALSE,
         delete_layer = TRUE,
         append = FALSE,
         layer_options = "ENCODING=UTF-8",
         driver = "ESRI Shapefile")



