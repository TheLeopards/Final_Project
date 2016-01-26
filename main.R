## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Comparing and visualising change in 2 Landsat images of the Rhone Glacier, CH

## libraries
library(sp)
library(raster)


#setwd("..../")
getwd()

## checking cloud cover for area of interest, if cloud cover is less than 20%, it untars 
## list of downloaded tar files

 ## , "data/LT51940282003234-SC20160126032814.tar.gz", "data/LT51940282010221-SC20160125050415.tar.gz", "data/LT51940282011240-SC20160126032704.tar.gz"
tarList <- list("data/LT51940282001212-SC20160125050334.tar.gz")
source("R/ImageSelection.R")
ImageSelection()

#ImageList <- (list.files("data", pattern = "*.grd", full.names = TRUE))
source("R/CloudMask.R")
CloudMask()


source("R/Calc_NDSI.R")
Calc_NDSI()
# Plot the stack and the cloud mask on top of each other
#plotRGB(RhoneG, 1,2,3)
#plot(cloud, add = TRUE, legend = FALSE)
#plot(RhoneG, 5, add = TRUE, legend = TRUE)

 


#trying to get rid of values<0 to be able to do plotRGB
#RhoneG4["LT51940282010221MOR00_sr_band5" < 0] <- NA

# Visualize the output
#plotRGB(RhoneG4, 1,2,3)


#plot(ndsi)

