

library(rgeos)
library(rgdal)
library(maptools)
#library(base)

glims <- readOGR(dsn="data/GLIMS/glims_polygons.shp", layer="glims_polygons")

rhone <- subset(glims, glims$anlys_id==166719)
writeOGR(rhone, "output", layer="glimsRhone", driver="ESRI Shapefile")
rhone
plot(rhone)


LT2009 <- readShapeSpatial(list.files("output", pattern="NDSI_shp_LT519402820092[456]*.shp", full.names=T))

#rhone_glims2009 <- readreadShapeSpatial(list.files("output", pattern="glimsRhone.shp", full.names=T))
plot(rhone)
plot(LT2009, add=T)
plot(LT2009)
LT2009proj <- project(LT2009, proj="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

