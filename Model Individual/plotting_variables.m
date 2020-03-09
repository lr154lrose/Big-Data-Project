for i = 1:4
    ncfile = strcat(int2str(i),".nc")
    lon = ncread(ncfile,'longitude'); 
    nx = length(lon); 
    lat = ncread(ncfile,'latitude'); 
    ny = length(lat); 
    time = ncread(ncfile,'time');
    switch_menu = true;


    worldmap('Europe')
    load coastlines
    plotm(coastlat,coastlon)

    [X,Y] = meshgrid(lon, lat);
    X = double(X);
    Y = double(Y);

    for i = 1:length(time)
        unknown = ncread(ncfile,'unknown',[1 1 i],[nx ny 1]);
        
        if (switch_menu)
            answer = menu("color blind mode on or off?",...
                'on',...
                'off');
            if answer==1
                colormap summer;
            elseif answer == 2
                colormap default;
            end
            switch_menu = false;
        end 

        load coastlines
        plotm(coastlat,coastlon)

        land = shaperead('landareas', 'UseGeoCoords', true);
        geoshow(gca, land, 'FaceColor', [0.5 0.7 0.5])

        lakes = shaperead('worldlakes', 'UseGeoCoords', true);
        geoshow(lakes, 'FaceColor', 'blue')

        rivers = shaperead('worldrivers', 'UseGeoCoords', true);
        geoshow(rivers, 'Color', 'blue')

        cities = shaperead('worldcities', 'UseGeoCoords', true);
        geoshow(cities, 'Marker', '.', 'Color', 'red')

        size(unknown)
        size(X)
        %pcolor(lon,lat,unknown'); 

        surfm(Y, X, unknown', 'EdgeColor', 'none','FaceAlpha', 0.5)
        shading interp
        title("Plotting the nc file variables")
        colorbar
        drawnow
    end
end
