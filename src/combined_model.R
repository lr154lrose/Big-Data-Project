library(chron)
library(RColorBrewer)
library(lattice)
library(ncdf4)

getwd()
workdir <- "//h//Big-Data-Project"
setwd(workdir)

#use method "file.choose()" if the program can't find the file

#mycdf <- nc_open("//Model Individual//W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", verbose = TRUE, write = FALSE)
timedata <- ncvar_get(mycdf,'time')
lat <- ncvar_get(mycdf,'latitude')
long <- ncvar_get(mycdf,'longitude')
harvestdata <- ncvar_get(mycdf,'harvest')

mycdf <- ncatt_get("W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc")

#USE OF NCVAR_GET-------------------

nc <- nc_open("W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", verbose = TRUE)
data <- ncvar_get(nc)
print(nc$nvars)
print(nc)

#print(mycdf)
#print(mycdf2)