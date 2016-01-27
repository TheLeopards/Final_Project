library(rgdal)
library(rgeos)
library(maptools)


NDSIlist <- list.files("output", pattern=glob2rx("NDSI*.grd"), full.names=T)
#NDSIstack <- stack(NDSIlist)
#plot(NDSIstack[[1]], col="red")
#plot(NDSIstack[[2]], col="blue", add=T)
#plot(NDSIstack[[3]], col="green", add=T)


for (layer in NDSIlist) {
	NDSI_ras <- raster(layer)
	NDSI_shp <- rasterToPolygons(NDSI_ras, na.rm=T, dissolve=T)
	writeOGR(NDSI_shp, driver="ESRI Shapefile", dsn="output", layer=paste("NDSI_shp_",substr(layer,14,29), sep = ""), overwrite_layer = T)

	
}


shp_list <- list.files("output", pattern=glob2rx("NDSI*.shp"), full.names=T)


#a <- rgb(runif(4),runif(4),runif(4))
#plot(readShapeSpatial(shp_list[[1]]), border=a, lwd=10)
#for (file in shp_list) {
#	plot(readShapeSpatial(file), border=a, add=T)

#}
#legend("bottomright", legend=substr(shp_list,17,33), fill=a, bg="white")

#legend("topright", legend=c(list.files("output", pattern=glob2rx("NDSI*.shp"), full.names=T)), fill=cols, bg="white")

a <- rgb(runif(4),runif(4),runif(4))
i <- 2
for (file in shp_list) {
	if (file == shp_list[[1]]) {
		plot(readShapeSpatial(file), border=a[1], lwd=2, main="Change in Rhone Glacier")
	} else {
		plot(readShapeSpatial(file), border=a[i], add=T)
		i <- i + 1
	}

}

legend("bottomright", legend=substr(shp_list,17,33), fill=a, bg="white")


