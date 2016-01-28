## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Calculating NDSI to be used as a proxy of glacier area

library(sp)
library(raster)

calc_NDSI <- function(list, layerX, layerY, folder, name, substart, substop) {
	for (stack in list) {
		Image_brick <- brick(stack)
		LT3 <- Image_brick[[layerX]]
		LT5 <- Image_brick[[layerY]]
		ndsi <- overlay(LT3, LT5, fun = function(x,y){(x-y)/(x+y)})
		## assigning NA to areas which are not snow (threshold for snow is NDSI>0.4)
		ndsi[ndsi <= 0.4] <- NA
		ndsi[ndsi > 0.4] <- 1
		outputFilename <- paste(name, substr(stack,substart,substop), sep = "_")
		writeRaster(ndsi, filename = paste(folder, outputFilename, sep = ""), overwrite=TRUE)
	}
}

