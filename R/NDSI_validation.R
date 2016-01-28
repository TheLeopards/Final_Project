## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Validating the use of NDSI as a proxy for glacier area by comparing it with the glacier extent obtained from the GLIMS dataset

library(rgeos)
library(rgdal)
library(maptools)


## preparing the datasets and extracting the feature corresponding to the Rhone Glacier from the GLIMS dataset
LT2009 <- readOGR("output/NDSI_shp_LT51940282009250.shp", "NDSI_shp_LT51940282009250")
untar("data/glims_download_18271.tar.gz", exdir = "data/")
glims <- readOGR(dsn="data/glims_download_18271/glims_polygons.shp", layer="glims_polygons")
rhone <- subset(glims, glims$anlys_id==166719)
writeOGR(rhone, "output", layer="glimsRhone", driver="ESRI Shapefile", overwrite_layer=T)
rhoneTr <- spTransform(rhone, CRS=proj4string(LT2009))

## plotting the two shapefiles together for comparison
plot(rhoneTr, col="orange", main ="Validating NDSI as proxy for glacier extent")
plot(LT2009, add=T, col="light blue")
legend("bottomright", legend=c("NDSI for Sep 2009", "Glacier outline from GLIMS dataset"), fill=c("orange", "light blue"), bg="white", cex=0.75)
box()