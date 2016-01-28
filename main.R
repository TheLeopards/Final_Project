## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Comparing and visualising change in Landsat images of the Rhone Glacier, Switzerland
## Glacier extent estimated using NDSI (Normalised Differentiated Snow Index)
## The method is validated through comparison with GLIMS dataset

## checking cloud cover for area of interest; if cloud cover is less than 50% the file is untared
tarList <- list("data/LT51940282009218-SC20160127034452.tar.gz", "data/LT51940282009250-SC20160127034608.tar.gz", "data/LT51940282001212-SC20160125050334.tar.gz", "data/LT51940282003234-SC20160126032814.tar.gz", "data/LT51940282010221-SC20160125050415.tar.gz", "data/LT51940282011240-SC20160126032704.tar.gz")
source("R/image_selection.R")
ImageSelection()

## masking the images for water and cloud areas derived from Landsat layer CFmask
source("R/cloud_water_mask.R")
cloud_water_mask()

## calculating NDSI
source("R/calc_NDSI.R")
Calc_NDSI()

## plotting all glacier areas derived from NDSI
source("R/glacier_area_plot.R")

## plotting glacier outlines on top of each other
source("R/NDSI_outline_overlay.R")

## validating the use of NDSI as a proxy for glacier extent by comparing it with the GLIMS dataset
source("R/NDSI_validation.R")