## Function to establish cloud cover area. 
## If it is below 50% the images are cropped and saved to disk. 
## Otherwise they are removed.

library(sp)
library(raster)
library(rgdal)


## setting variables
extentArea <- extent(447315, 458985, 5156955, 5169255)
extent_raster <- raster(nrows=410, ncols=389,ext=extentArea)
FreqEA <- freq(extent_raster, value=NA, useNA="always", progress="text")

ImageSelection <- function() {
	for (folder in tarList[]) {
		## untaring CFmask into a new folder
		untar(folder, exdir = "data/CloudTemp")
		## extract cloud cover
		CFmask <- raster(list.files("data/CloudTemp", pattern = glob2rx("*cfmask.tif"), full.names = TRUE))
		## crop CFmask
		CFmask_crop <- crop(CFmask, extentArea)
		## calculating cloud cover area
		FreqCM <-freq(CFmask_crop, digits=0, value=4, useNA='no', progress="text")
		Cloud_area <- (FreqCM/FreqEA)*100
		## keeping only images with low cloud cover in cropped area.
		## Cropping all bands that will be used in analysis and saving them to disk.
		if (Cloud_area < 50) {
			untar(folder, exdir = "data/CloudTemp")
			print("Cloud cover is below 50% and the files will be pre-processed and saved in data folder")
			list_bands <- list.files('data/CloudTemp', pattern = 'LT.*sr_band[1235].tif', full.names = TRUE)
			list_cloud <- list.files('data/CloudTemp', pattern = 'LT.*cfmask.tif', full.names = TRUE)
			stack_bands <- stack(list_bands)
			stack_bandsCF <- addLayer(stack_bands, list_cloud)
			
			## cropping to extent of Rhone Glacier
			crop(stack_bandsCF, extentArea, filename=paste("data/",substr(folder, 6, 18), sep = ""), datatype='INT2S', overwrite=TRUE)
			
		}
		else {
			print("Cloud cover is above 50% and the files will be removed")
		}
		## deleting temporary files
		list_del <- list.files("data/CloudTemp", full.names = TRUE)
		unlink(list_del)
	}
}
