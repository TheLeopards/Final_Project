
library(sp)
library(raster)
library(rgdal)



## setting variables
tarList <- list("data/LT51940282001212-SC20160125050334.tar.gz")
extentArea <- extent(447315, 458985, 5156955, 5169255)
extent_raster <- raster(nrows=410, ncols=389,ext=extentArea)
FreqEA <- freq(extent_raster, value=NA, useNA="always", progress="text")



#CloudCheck <- function(LSyear) {
	for (folder in tarList[]) {
		## untaring CFmask into a new folder
		untar(folder, files="LT51940282001212MTI00_cfmask.tif", exdir = "data/CloudTemp")
		## extract cloud cover
		CFmask <- raster(list.files("data/CloudTemp", pattern = glob2rx("*cfmask.tif"), full.names = TRUE))
		## crop CFmask
		CFmask_crop <- crop(CFmask, extentArea)
		## calculating cloud cover area
		FreqCM <-freq(CFmask_crop, digits=0, value=4, useNA='no', progress="text")
		Cloud_area <- (FreqCM/FreqEA)*100
		## keeping only images with low cloud cover in cropped area
		if (Cloud_area < 20) {
			untar(folder, exdir = "data")
			print("Cloud cover is below 20% and the files will be removed")
		}
		else {
			print("Cloud cover is above 20% and the files will be removed")
		}
		list_del <- list.files("data/CloudTemp", full.names = TRUE)
		unlink(list_del)
}