answer = 0;

for i = 1:7
    ncfile = strcat(int2str(i),".nc");
    lon = ncread(ncfile,'longitude'); 
    nx = length(lon); 
    lat = ncread(ncfile,'latitude'); 
    ny = length(lat); 
    time = ncread(ncfile,'time');
    t = (time - 1038720);

    worldmap('Europe')
    load coastlines
    plotm(coastlat, coastlon, 'k', 'LineWidth', 0.1)

    %axesm 
    [X,Y] = meshgrid(lon, lat);
    X = double(X);
    Y = double(Y);

    for t = 1:length(time)
        unknown = ncread(ncfile,'unknown',[1 1 t],[nx ny 1]);
        
        if (answer == 0)
            answer = listdlg('PromptString', {'Please select a colour mode.', ...
                'You can only select one.'}, ...
                'SelectionMode', 'Single', 'ListString', {'Colour blind', ...
                'Default', 'Blue & Green', 'Yellow & Pink High Contrast', 'Warm', 'Black & White' ...
                'Pink Weak Contrast', 'Warm High Contrast', 'Negative Effect'});
            switch answer
                case 1
                    colormap summer;
                case 2
                    colormap default;
                case 3
                    colormap winter;
                case 4
                    colormap spring;
                case 5
                    colormap autumn;
                case 6
                    colormap gray;
                case 7
                    colormap pink;
                case 8 
                    colormap hot;
                case 9
                    colormap cool;
            end
        end 

        load coastlines
        plotm(coastlat,coastlon, 'k', 'LineWidth', 0.1)

        %size(unknown)
        %size(X)
        %pcolor(lon,lat,unknown'); 

        surfm(Y, X, unknown', 'EdgeColor', 'none','FaceAlpha', 0.5)
        shading interp
        %xlabel('Longitude');
        %ylabel('Latitude');
        title(sprintf('time: %i:00', (t - 1)))
        colorbar
        drawnow
    end
end
