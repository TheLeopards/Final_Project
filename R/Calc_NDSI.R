


library(sp)
library(raster)


ImageList <- (list.files("output", pattern = glob2rx("cloud*.grd"), full.names = TRUE))


Calc_NDSI <- function() {
	## applying the cloud2NA function
	for (stack in ImageList[]) {
		Image_brick <- brick(stack)
		LT3 <- Image_brick[[3]]
		LT5 <- Image_brick[[4]]
		# Calculating NDSI
		# Apply the function on the two raster objects using overlay
		ndsi <- overlay(LT3, LT5, fun = function(x,y){(x-y)/(x+y)})
		## assigning NA to areas which are not snow (threshold for snow is NDSI>0.4)
		ndsi[ndsi <= 0.4] <- NA
		ndsi[ndsi > 0.4] <- 1
		writeRaster(ndsi, filename = paste("output/NDSI",substr(stack,17,33), sep = "_"), overwrite=TRUE)
		
		plot(ndsi)
		
	} 
	
}



