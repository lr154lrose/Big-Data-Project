for i = 1:4
    ncfile = strcat(int2str(i),".nc")
    lon = ncread(ncfile,'longitude'); 
    nx = length(lon); 
    lat = ncread(ncfile,'latitude'); 
    ny = length(lat); 
    time = ncread(ncfile,'time');


    [X,Y] = meshgrid(lon, lat);
    X = double(X);
    Y = double(Y);

    for i = 1:length(time)
        unknown = ncread(ncfile,'unknown',[1 1 i],[nx ny 1]);
        size(unknown)
        size(X)
        pcolor(lon,lat,unknown'); 
        shading interp
        title("Plotting the nc file variables")
        colorbar
        drawnow
    end
end