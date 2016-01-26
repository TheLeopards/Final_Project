
library(sp)
library(raster)
library(rgdal)



## setting variables
tarList <- list("data/LT51940282001212-SC20160125050334.tar.gz")
extentArea <- extent(447315, 458985, 5156955, 5169255)

#CloudCheck <- function(LSyear) {
	for (folder in tarList[]) {
		## untaring CFmask into a new folder
		untar(folder, files="LT51940282001212MTI00_cfmask.tif", exdir = "data/CloudTemp")
		## extract cloud cover
		CFmask <- raster(list.files("data/CloudTemp", pattern = glob2rx("*cfmask.tif"), full.names = TRUE))
		## crop CFmask
		CFmask_crop <- crop(CFmask, extentArea)
		## calculating cloud cover area
		CFmask_crop[CFmask_crop != 4] <- NA
		plot(CFmask_crop)
		
	
		
		cell_size <- area(CFmask_crop, filename="data/CloudTemp/cell_size", na.rm=TRUE, weights=FALSE)
		cell_size <- cell_size[!is.na(cell_size)]
		cloud_area <- length(cell_size)*median(cell_size)
		print(paste("Area of cloud regions (0-999 m):",round(cloud_area, digits=1),"km2"))
		extent_raster <- raster(extentArea)
		plot(extent_raster)
		cell_size_ext <- area(extent_raster, filename="data/CloudTemp/cell_size_ext", na.rm=FALSE, weights=FALSE)
		cell_size_ext <- cell_size_ext[!is.na(cell_size_ext)]
		extent_area <- length(cell_size_ext)*median(cell_size_ext)
		
		a <- (cloud_area/extent_area)
		
		plot(CFmask_crop)
		
		
		
	}
cfmask_untar <- function(folder_path, LSyear) {
	



untar("data/LT51940282001212-SC20160125050334.tar.gz", files=glob2rx("LT5*cfmask.tif") ,exdir = paste("data/", "LSyear"))
untar("data/LT51940282001212-SC20160125050334.tar.gz", exdir = paste("data/CloudTemp"))
