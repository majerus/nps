# Yellowstone Zone of Death mapping exercises 

# For more information on Zone of Death see 
  # https://www.vox.com/2014/5/22/5738756/you-can-kill-someone-in-a-section-of-yellowstone-and-get-away-scot 

## load packages----
library(leaflet)
library(tidyverse)
library(raster)
library(htmlwidgets)
library(rgeos)

## only needed for project setup: create subset of nation parks boundary data for yellowstone ----

# load extra packages for data prep
# library(sp)
# library(rgdal)


# NPS

# read in national park boundaries
# data from https://catalog.data.gov/dataset/national-park-boundariesf0a4c
# nps <- readOGR("nps_boundary/nps_boundary.shp")

# subset nps from 510 polygons to 1 (yellowstone)
# yellowstone <- nps[nps$UNIT_NAME == "Yellowstone", ]

# save yellowstone subset so we don't have to read in the ~27MB data on all parks
# saveRDS(yellowstone, "yellowstone_boundary.rds")

# US States

# read in us state boundaries
# data from https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html
# st_boundaries <- readOGR("cb_2017_us_state_5m/cb_2017_us_state_5m.shp")

# subset st_boundaries to only include states that have part of yellowstone
# mt_west <- st_boundaries[st_boundaries$NAME %in% c("Wyoming", "Montana", "Idaho"), ]

# save st_boundaries subset 
# saveRDS(mt_west, "mt_west.rds")





## Exercise 1: load yellowstone boundary data ----
yellowstone <- readRDS("yellowstone_boundary.rds")

## Exercise 2: explore yellowstone data ----
summary(yellowstone)
str(yellowstone)
glimpse(yellowstone@data)

## Exercise 3: map yellowstone polygon ----
yellowstone %>% 
  leaflet() %>% 
  addPolygons()

## Exercise 4: load state boundary data and find center of each state ----
st_boundaries <- readRDS("mt_west.rds")

# create spatial points data frame with centroid of each state and data slot from st_boundaries
state_centers <- SpatialPointsDataFrame(gCentroid(st_boundaries, byid=TRUE), 
                                        st_boundaries@data, 
                                        match.ID=FALSE)

## Exercise 5: map state boundaries of states that include part of yellowstone  ----

m <-
  st_boundaries %>% 
    leaflet() %>% 
    addPolygons(color = "grey", 
                weight = 1,
                group = "States") 

print(m)

# add state name labels
m <- 
  m %>% 
  addLabelOnlyMarkers(lng = state_centers@coords[,1],
                      lat = state_centers@coords[,2],
                      label = state_centers$NAME,
                      labelOptions = labelOptions(
                        noHide = T,
                        direction = 'top',
                        textOnly = T))

print(m)

## Exercise 6: add park boundary to map stored in m object  ----

# explore structure to find coordinates
# use image yellowstone_object_viewer.png to demonstrate how to access coords

str(yellowstone)
str(state_boundaries)
yellowstone@polygons[[1]]@Polygons[[1]]@coords

m2 <- 
  m %>% 
    addPolygons(color = "yellow",
                weight = 1,
                lng = yellowstone@polygons[[1]]@Polygons[[1]]@coords[,1],
                lat = yellowstone@polygons[[1]]@Polygons[[1]]@coords[,2],
                popup = "Yellowstone",
                group = "Yellowstone")

print(m2)

# Exercise 7: intersect Idaho and Yellowstone boundaries  ----
  # projection(id_boundary)
  # projection(yellowstone)

# create spatial polygon data frame with only Idaho boundary to intersect with Yellowstone boundary
id_boundary <- st_boundaries[st_boundaries$NAME %in% c("Idaho"), ]

# intersect Idaho and Yellowstone boundaries to find are of overlap that is known as zone of death
zone_of_death <- intersect(id_boundary, yellowstone)

# Exercise 8: add zone of death to map   ----
m3 <- 
  m2 %>% 
  addPolygons(color = "red",
              weight = 1,
              lng = zone_of_death@polygons[[1]]@Polygons[[1]]@coords[,1],
              lat = zone_of_death@polygons[[1]]@Polygons[[1]]@coords[,2],
              group = "Zone of Death",
              popup = "Zone of Death") %>% 
  addLayersControl(overlayGroups = c("States", "Yellowstone", "Zone of Death"))

print(m3)

# Exercise 9: calculate area of the zone of death   ----

# find with addMeasure tool (~57.6 Sq Miles)
m3 <- 
  m3 %>% 
    addMeasure(
      primaryLengthUnit = "miles",
      primaryAreaUnit = "sqmiles",
      activeColor = "#3D535D",
      completedColor = "#7D4479")

print(m3)

# calculate area of polygon (~57.2 Sq Miles)
# library(raster)
area(zone_of_death) / 2589988.11


# Exercise 10: save map ----
# library(htmlwidgets)

saveWidget(m3, "yellowstone_zone_of_death_map.html")

