## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Masking the images for water and cloud areas derived from Landsat layer CFmask
## before further analysis and save them in the output folder.

library(sp)
library(raster)

cloud_water_mask <- function(list, layer, folder, name, substart, substop) {
	cloudWater2NA <- function(x, y){
		x[y == 4 | y == 1] <- NA
		return(x)
	}
	## applying the cloud2NA function
	for (stack in list) {
		Image_brick5 <- brick(stack)
		CFmask <- Image_brick5[[layer]]
		Image_brick4 <- dropLayer(Image_brick5, layer)
		outputFilename <- paste(name, substr(stack, substart, substop), sep = "_")
		overlay(x = Image_brick4, y = CFmask, fun = cloudWater2NA, filename = paste(folder, outputFilename, sep = ""), overwrite=TRUE)
	} 
}

