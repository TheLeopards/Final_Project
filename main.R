## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Comparing and visualising change in 2 Landsat images of the Rhone Glacier, CH

## libraries
library(sp)
library(raster)


#setwd("..../")
getwd()

## untar the datasets
source("R/folder_untar.R")

folder_untar("data/LT51940282001212-SC20160125050334.tar.gz", "LS2001")
folder_untar("data/LT51940282010221-SC20160125050415.tar.gz", "LS2010")

## stacking bands 3 and 5, and cloud mask

file_list <- function(folder_path) {

list_2001 <- list.files('data/', pattern = 'LT.*sr_band[1235].tif', full.names = TRUE)
stack_2001 <- stack(list_2001)
stack_2001CM <- addLayer(stack_2001, "data/LT51940282010221MOR00_cfmask.tif")
#brick_2001CM <- brick(stack_2001CM, filname = "data/brick_2001CM.grd", datatype='INT2S')

## cropping to extent of Rhone Glacier
extentArea <- extent(447315, 458985, 5156955, 5169255)
RhoneG <- crop(stack_2001CM, extentArea)


#RhoneG_br <- brick(RhoneG)
#RhoneG_toFile <- writeRaster(x=RhoneG, filename='data/RhoneG_toFile', datatype='INT2S', overwrite=TRUE)
#plot(RhoneG_toFile)

## Delete unwanted images


# Extract cloud Mask rasterLayer
fmask <- RhoneG[[5]]
plot(fmask)

# Let's create a new 6 layers object since tahiti6 has been masked already
RhoneG4 <- dropLayer(RhoneG, 5)

# Plot the stack and the cloud mask on top of each other
#plotRGB(RhoneG, 1,2,3)
#plot(cloud, add = TRUE, legend = FALSE)
#plot(RhoneG, 5, add = TRUE, legend = TRUE)

 
# Perform value replacement (water, cloud shadow and cloud cover become NA)
RhoneG4[fmask == 1 | fmask == 3 | fmask == 4] <- NA
#plot(RhoneG4)

# First define a value replacement function
cloud2NA <- function(x, y){
	x[y != 0] <- NA
	return(x)
}

# Apply the function on the two raster objects using overlay
RhoneCloudFree <- overlay(x = RhoneG4, y = fmask, fun = cloud2NA)

#trying to get rid of values<0 to be able to do plotRGB
#RhoneG4["LT51940282010221MOR00_sr_band5" < 0] <- NA

# Visualize the output
#plotRGB(RhoneG4, 1,2,3)

# Calculating NDSI
lt3 <- RhoneG4[[3]]
lt5 <- RhoneG4[[4]]

ndsi <- overlay(lt3, lt5, fun=function(x,y){(x-y)/(x+y)})
plot(ndsi)

