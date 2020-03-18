answer = 0;
f = figure;
colorbar
set(gcf, 'Position',  [150, 100, 500, 500], 'Color', 'White')

slider_control = uicontrol('Parent',f,'Style','slider','Position',[43,20,419,23],...
              'value', 0.5, 'min',0.001, 'max',4, 'BackgroundColor', 'Black');
          
slider_text = uicontrol('Parent',f,'Style','text','Position',[50,53,140,13],...
                'String','Europe outline thickness:','BackgroundColor', f.Color);
           
change_button = uicontrol('Parent', f, 'Style', 'togglebutton', 'String', 'Change Colormap', ...
                'Position', [43,430,100,30], 'BackgroundColor', 'Black', 'ForegroundColor', 'White');
         
river_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Add Rivers', ...
                'Position', [43,465,100,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White');
            
city_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Add Cities', ...
                'Position', [130,465,100,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White');
          
lake_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Add Lakes', ...
                'Position', [210,465,90,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White');
            
time_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Display time', ...
                'Position', [290,465,90,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White');
            

for i = 1:7
    ncfile = strcat(int2str(i),".nc");
    lon = ncread(ncfile,'longitude'); 
    nx = length(lon); 
    lat = ncread(ncfile,'latitude'); 
    ny = length(lat); 
    time = ncread(ncfile,'time');
    t = (time - 1038720);
   

    %axesm 
    [X,Y] = meshgrid(lon, lat);
    X = double(X);
    Y = double(Y);

    for t = 1:length(time)
        unknown = ncread(ncfile,'unknown',[1 1 t],[nx ny 1]);
        worldmap('Europe')
        load coastlines
        plotm(coastlat, coastlon, 'k', 'LineWidth', slider_control.Value)
            
        if(change_button.Value == 1)
            answer = 0;
        end
            
        if (answer == 0)
            change_button.Value = 0;
            answer = listdlg('PromptString', {'Please select a colour mode.', ...
                'You can only select one.'}, ...
                'SelectionMode', 'Single', 'ListString', {'Colour blind', ...
                'Default', 'Blue & Green', 'Yellow & Pink High Contrast', 'Warm', 'Black & White' ...
                'Pink Weak Contrast', 'Warm High Contrast', 'Negative Effect'},...  
                'ListSize', [160, 150], 'Name', 'Colour');
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
        outline = plotm(coastlat,coastlon, 'k', 'LineWidth', slider_control.Value);
        
        if(river_checkbox.Value == 1)
            rivers = shaperead('worldrivers', 'UseGeoCoords', true);
            geoshow(rivers, 'Color', 'blue')
        end
        
        if(city_checkbox.Value == 1)
            cities = shaperead('worldcities', 'UseGeoCoords', true);
            geoshow(cities, 'Marker', '.', 'Color', 'red')
        end
        
        if(lake_checkbox.Value == 1)
            lakes = shaperead('worldlakes', 'UseGeoCoords', true);
            geoshow(lakes, 'FaceColor', 'blue')
        end  
            
        if(time_checkbox.Value == 1)
            title(sprintf('time: %i:00', (t-1)))
        else
            title(sprintf(''))
        end 

        %size(unknown)
        %size(X)
        %pcolor(lon,lat,unknown'); 

        surfm(Y, X, unknown','FaceAlpha', 0.5); 
        %shading interp
        %xlabel('Longitude');
        %ylabel('Latitude');
        drawnow
        %delete(outline);
        cla
    end
end
clf
