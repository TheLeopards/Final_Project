
library(raster)


NDSIlist <- list.files("output", pattern=glob2rx("NDSI*.grd"), full.names=T)
NDSIstack <- stack(NDSIlist)
opar <- par(mfrow = c(3,2))



i <- 1
titles <- vector()

for (layer in NDSIlist) {
	titles[i] <- paste(substr(layer,14,29))
	i <- i + 1
}

names(NDSIstack) <- titles

plot(NDSIstack, legend=F)

opar <- par
