ncfile = 'W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc' ; % nc file name
% To get information about the nc file
ncinfo(ncfile)
% to display nc file
ncdisp(ncfile)
% to read a vriable 'var' exisiting in nc file
% myvar = ncread(ncfile,'var') ;