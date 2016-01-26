
folder_untar <- function(folder_path, LSyear) {
	## untaring folders into the 'data' folder

	untar(folder_path, exdir = paste("data/", LSyear))
	#list_ls <- list.files('data/', pattern = '*.tif', full.names = TRUE)
}


#folder_untar("data/LE70100112004252-SC20160124084328.tar.gz")

#untar("data/LT51940282001212-SC20160125050334.tar.gz", exdir = "data", files = past(folder path"sr_band3.tif")




#list_ls <- list.files('data/', full.names = TRUE)


#fn <- "foo.txt"
#if (file.exists(fn)) file.remove(fn)


#pattern = glob2rx('*.tif')
#junk <- dir(path="data/", pattern=glob2rx('*band1.tif')) # ?dir
#file.remove(junk) # ?file.remove

