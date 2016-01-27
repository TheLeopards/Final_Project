## Function to remove clouded pixels from images before further analysis
## and save them in the output folder.

library(sp)
library(raster)

## setting variables
ImageList <- (list.files("data", pattern = "*.grd", full.names = TRUE))

CloudMask <- function() {
	cloud2NA <- function(x, y){
		x[y == 4 | y == 1] <- NA
		return(x)
	}
	## applying the cloud2NA function
	for (stack in ImageList[]) {
		Image_brick5 <- brick(stack)
		CFmask <- Image_brick5[[5]]
		Image_brick4 <- dropLayer(Image_brick5, 5)
		# Apply the function on the two raster objects using overlay
		overlay(x = Image_brick4, y = CFmask, fun = cloud2NA, filename = paste("output/cloudfree",substr(stack,6,22), sep = "_"), overwrite=TRUE)
	} 
}

