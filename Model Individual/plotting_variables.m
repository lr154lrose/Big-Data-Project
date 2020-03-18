answer = 0;
f = figure;
colorbar
set(gcf, 'Position',  [150, 100, 500, 500], 'Color', 'White')

slider_control = uicontrol('Parent',f,'Style','slider','Position',[43,20,419,23],...
              'value', 0.5, 'min',0.001, 'max',4, 'BackgroundColor', 'Black');
          
slider_text = uicontrol('Parent',f,'Style','text','Position',[50,53,140,13],...
                'String','Europe outline thickness:','BackgroundColor', f.Color);
           
change_button = uicontrol('Parent', f,'Style', 'togglebutton', 'String', 'Change colormap', ...
                'Position', [43,430,100,30]);
            

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
    plotm(coastlat, coastlon, 'k', 'LineWidth', slider_control.Value)

    %axesm 
    [X,Y] = meshgrid(lon, lat);
    X = double(X);
    Y = double(Y);

    for t = 1:length(time)
        unknown = ncread(ncfile,'unknown',[1 1 t],[nx ny 1]);
            
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

        %size(unknown)
        %size(X)
        %pcolor(lon,lat,unknown'); 

        surfm(Y, X, unknown','FaceAlpha', 0.5); 
        %shading interp
        %xlabel('Longitude');
        %ylabel('Latitude');
        title(sprintf('time: %i:00', (t-1)))
        drawnow
        delete(outline);
    end
end
