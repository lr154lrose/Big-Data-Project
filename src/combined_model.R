library(ncdf4)
mycdf <- nc_open(file.choose(), verbose = TRUE, write = FALSE)
timedata <- ncvar_get(mycdf,'time')
lat <- ncvar_get(mycdf,'latitude')
long <- ncvar_get(mycdf,'longitude')
harvestdata <- ncvar_get(mycdf,'harvest')

print(harvestdata)