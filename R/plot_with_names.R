## Author: The Leopards (Samantha Krawczyk, Georgios Anastasiou)
## 28 January 2016
## Function to plot rasters with names derived from their filename

library(raster)

plot_with_names <- function(list, substart, substop){
	## adding file names to a list to be used as plot titles
	i <- 1
	titles <- vector()
	for (layer in list) {
		titles[i] <- substr(layer,substart,substop)
		i <- i + 1
	}
	## plotting
	listStack <- stack(list)
	opar <- par(mfrow = c(2,2))
	names(listStack) <- titles
	plot(listStack, legend=F)
	par(opar)
}
