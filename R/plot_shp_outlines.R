## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## creating shapefiles from raster and saving it with a name derived from the file name
## plotting shapefile outlines on top of each other

library(rgdal)
library(rgeos)
library(maptools)

plot_shp_outlines <- function(list, dsn, name, substart, substop, pattern, colourNum, main, lsubstart, lsubstop) {
	## creating shapefiles from rasters
	for (layer in list) {
		layRas <- raster(layer)
		layShp <- rasterToPolygons(layRas, na.rm=T, dissolve=T)
		writeOGR(layShp, driver="ESRI Shapefile", dsn=dsn, layer=paste(name, substr(layer,substart,substop), sep = ""), overwrite_layer = T)
	}
	## plotting the shapefiles
	shp_list <- list.files(dsn, pattern=pattern, full.names=T)
	
	colour <- rgb(runif(colourNum),runif(colourNum),runif(colourNum))
	i <- 2
	
	for (file in shp_list) {
		if (file == shp_list[[1]]) {
			plot(readShapeSpatial(file), border=colour[1], lwd=1.5, main=main)
		} else {
			plot(readShapeSpatial(file), border=colour[i], add=T, lwd=1.5)
			i <- i + 1
		}
	}
	legend("bottomright", legend=substr(shp_list,lsubstart,lsubstop), fill=colour, bg="white", cex=0.75)
	box()
}



