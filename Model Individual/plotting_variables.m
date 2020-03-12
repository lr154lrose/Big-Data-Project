switch_menu = true;

for i = 1:7
    ncfile = strcat(int2str(i),".nc")
    lon = ncread(ncfile,'longitude'); 
    nx = length(lon); 
    lat = ncread(ncfile,'latitude'); 
    ny = length(lat); 
    time = ncread(ncfile,'time');
    t = (time - 1038720);

    worldmap('Europe')
    load coastlines
    plotm(coastlat,coastlon)

    %axesm 
    [X,Y] = meshgrid(lon, lat);
    X = double(X);
    Y = double(Y);

    for t = 1:length(time)
        unknown = ncread(ncfile,'unknown',[1 1 t],[nx ny 1]);
        
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

        %size(unknown)
        %size(X)
        %pcolor(lon,lat,unknown'); 

        surfm(Y, X, unknown', 'EdgeColor', 'none','FaceAlpha', 0.5)
        shading interp
        %xlabel('Longitude');
        %ylabel('Latitude');
        title(sprintf('time: %i:00', (t)))
        colorbar
        drawnow
    end
end
