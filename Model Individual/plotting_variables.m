ncfile = 'sixth.nc';
lon = ncread(ncfile,'longitude'); 
nx = length(lon); 
lat = ncread(ncfile,'latitude'); 
ny = length(lat); 
time = ncread(ncfile,'time');
for i = 1:length(time)
    unknown = ncread(ncfile,'unknown',[1 1 i],[nx ny 1]);
    pcolor(lon,lat,unknown'); 
    shading interp
    title("Plotting the nc file variables")
    colorbar
    drawnow
end