# Yellowstone's Polygon of Death

### Background - What is the "Zone of Death"?

I first learned about the so-called Zone of Death in Yellowstone while reading C.J. Box's novel *Free Fire*. This small area, where the National Park overlaps with the state of Idaho was first written about by Michigan State law professor Brian Kalt in a 2005 Georgetown Law Journal article, "The Perfect Crime." 

Succinctly, in my understanding, if a crime where committed in this area of the park the court would not be about to form a jury of the accused's peers and therefore the crime could not be tried. 

The 6th Amendment states: 

> In all criminal prosecutions, the accused shall enjoy the right to a speedy and public trial, **by an impartial jury of the State and district wherein the crime shall have been committed**, which district shall have been previously ascertained by law, and to be informed of the nature and cause of the accusation; to be confronted with the witnesses against him; to have compulsory process for obtaining witnesses in his favor, and to have the Assistance of Counsel for his defence.

However, the district of the entirety of Yellowstone National Park is Wyoming. This means that a jury would have to be drawn from the area where the park overlaps with the boundary of the state of Idaho, and no one lives there. 

The [Vox story](https://www.vox.com/2014/5/22/5738756/you-can-kill-someone-in-a-section-of-yellowstone-and-get-away-scot) on this topic offers a good explanation.

### Introduction - What is this repo? 

This repo is a project designed for [DataCamp](www.datacamp.com) to help students develop their basic spatial data analysis skills and their familiarity with the package `leaflet`. The "Zone of Death" or "Yellowstone's Polygon of Death" as I have taken to calling it seemed like a memorable and novel spatial subject for students. 

This topic poses several interesting questions for students to explore spatially using `leaflet`:
* Where is "Yellowstone's Polygon of Death"?
* How big is "Yellowstone's Polygon of Death"? 
* Why is part of the National Park in Idaho?

These questions lend themselves to the introduction and review of several aspects of working with spatial data in R and `leaflet`. 

* Working with spatial polygons dataframes 
* Reviewing several functions in the `leaflet` R package  
    * `addPolgygons`    
    * `addLayersControl`
    * `addMeasure`
    * `addLabelOnlyMarkers`
* Performing calculations using polygons
    * Finding the centroid of a polygon 
    * Calculating the area of a polygon
    * Plotting the intersection of two polygons

### Files 

- **dc_project_development.R**  - draft exercises for DataCamp project
- **mt_west.rds** - boundary data for Wyoming, Montana, and Idaho (subset of [cb_2017_us_state_5m.shp](https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html))
- **yellowstone_boundary.rds** - boundary data for Yellowstone National Park (subset of [nps_boundary.shp](https://catalog.data.gov/dataset/national-park-boundariesf0a4c))
- **yellowston_zone_of_death_map.html** - map from final exercise in dc_project_development.R.

