for i in ['

ncfile = 'W_fr-meteofrance,MODEL,SILAM+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc';
lon = ncread(ncfile,'longitude'); 
nx = length(lon); 
lat = ncread(ncfile,'latitude'); 
ny = length(lat); 
time = ncread(ncfile,'time');


worldmap('Europe')
load coastlines
plotm(coastlat,coastlon)

[X,Y] = meshgrid(lon, lat);
X = double(X);
Y = double(Y);

for i = 1:length(time)
    unknown = ncread(ncfile,'unknown',[1 1 i],[nx ny 1]);
    load coastlines
    plotm(coastlat,coastlon)
    size(unknown)
    size(X)
    %pcolor(lon,lat,unknown'); 
    surfm(Y, X, unknown', 'EdgeColor', 'none','FaceAlpha', 0.5)
    shading interp
    title("Plotting the nc file variables")
    colorbar
    drawnow
end