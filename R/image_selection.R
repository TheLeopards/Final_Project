## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Function to select an image based on the calculated percentaege of cloud cover. 
## If it is below 50% the images are cropped and saved to disk. 
## Otherwise they are removed.

library(sp)
library(raster)
library(rgdal)


image_selection <- function(list, extent, tempfolder, outfolder, substart, substop) {
	for (file in list) {
		tarlist <- untar(file, exdir=tempfolder, list=T)
		untar(file, exdir=tempfolder,files=paste(substr(tarlist[[1]], 1, 22), "cfmask.tif", sep=""))
		## extract and crop cloud cover
		CFmask <- raster(list.files(tempfolder, pattern = glob2rx("*cfmask.tif"), full.names = TRUE))
		CFmask_crop <- crop(CFmask, extent)
		## calculating cloud cover area
		cloudPix <-freq(CFmask_crop, digits=0, value=4, useNA='no', progress="text")
		totPix <- CFmask_crop@ncols*CFmask_crop@nrows
		Cloud_area <- (cloudPix/totPix)*100
		## keeping only images with low cloud cover in cropped area.
		## Cropping all bands that will be used in analysis and saving them to disk.
		if (Cloud_area < 50) {
			untar(file, exdir = tempfolder)
			print("Cloud cover is below 50% and the files will be pre-processed and saved in output folder")
			list_bands <- list.files(tempfolder, pattern = 'LT.*sr_band[1235].tif', full.names = TRUE)
			list_cloud <- list.files(tempfolder, pattern = 'LT.*cfmask.tif', full.names = TRUE)
			stack_bands <- stack(list_bands)
			stack_bandsCF <- addLayer(stack_bands, list_cloud)
			outputFilename <- paste(substr(file, substart, substop), sep = "_")
			crop(stack_bandsCF, extent, filename=paste(outfolder, outputFilename, sep=""), datatype='INT2S', overwrite=TRUE)
		}
		else {
			print("Cloud cover is above 50% and the image will not be used for further analysis")
		}
		## deleting temporary files
		list_del <- list.files(tempfolder, full.names = TRUE)
		unlink(list_del)
	}
}
