## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Comparing and visualising change in Landsat images of the Rhone Glacier, Switzerland
## Glacier extent estimated using NDSI (Normalised Differentiated Snow Index)
## The method is validated through comparison with GLIMS dataset

## loading functions
source("R/image_selection.R")
source("R/cloud_water_mask.R")
source("R/calc_NDSI.R")
source("R/plot_with_names.R")
source("R/plot_shp_outlines.R")


## checking cloud cover for area of interest; if cloud cover is less than 50% the file is untared
## setting variables for image_selection function
tarList <- list("data/LT51940281984246-SC20160127034926.tar.gz","data/LT51940281990214-SC20160127034923.tar.gz", "data/LT51940282001212-SC20160125050334.tar.gz", "data/LT51940282003218-SC20160127034612.tar.gz", "data/LT51940282003234-SC20160126032814.tar.gz", "data/LT51940282009218-SC20160127034452.tar.gz", "data/LT51940282009250-SC20160127034608.tar.gz","data/LT51940282010221-SC20160125050415.tar.gz", "data/LT51940282010237-SC20160127034442.tar.gz", "data/LT51940282011240-SC20160126032704.tar.gz")
extentArea <- extent(451000, 456500, 5158000, 5167000)
tempFolder <-"data/CloudTemp"
outputFolder <- "output/"
outputNameSubStart <- 6
outputNameSubStop <- 21

image_selection(tarList, extentArea, tempFolder, outputFolder, outputNameSubStart, outputNameSubStop)


## masking the images for water and cloud areas derived from Landsat layer CFmask
## setting variables for cloud_water_mask function
ImageList <- list.files("output", pattern = "*.grd", full.names = TRUE)
cfmaskLayer <- 5
outputName <- "cloudfree"
outputNameSubStart <- 8
outputNameSubStop <- 24

cloud_water_mask(ImageList, cfmaskLayer, outputFolder, outputName, outputNameSubStart, outputNameSubStop)


## calculating NDSI
## setting variables for calc_NDSI function
ImageList <- list.files("output", pattern = glob2rx("cloud*.grd"), full.names = TRUE)
layerX <- 3
layerY <- 4
outputName <- "NDSI"
outputNameSubStart <- 17
outputNameSubStop <- 33

calc_NDSI(ImageList, layerX, layerY, outputFolder, outputName, outputNameSubStart, outputNameSubStop)


## plotting all glacier areas derived from NDSI
## setting variables for plot_with_names function
NDSIlist <- list.files("output", pattern=glob2rx("NDSI*.grd"), full.names=T)
outputNameSubStart <- 14
outputNameSubStop <- 29

plot_with_names(NDSIlist, outputNameSubStart, outputNameSubStop)


## plotting glacier outlines on top of each other
## setting variables for plot_shp_outlines function
dsn="output"
outputName = "NDSI_shp_"
outputNameSubStart <- 14
outputNameSubStop <- 29
pattern <- glob2rx("NDSI*.shp")
colNum <- 50
main <- "Change in Rhone Glacier"
legendSubStart <-17
legendSubStop <- 32

plot_shp_outlines(NDSIlist, dsn, outputName, outputNameSubStart, outputNameSubStop, pattern, colNum, main, legendSubStart, legendSubStop)


## validating the use of NDSI as a proxy for glacier extent by comparing it with the GLIMS dataset
source("R/NDSI_validation.R")
