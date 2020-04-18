answer = 0;                             %variable used for the colormap button 
f = figure;                             %creating figure 
colorbar                                %displaying vertical colorbar in order to show the color scale 
set(gcf, 'Position',  [150, 100, 500, 500], 'Color', 'White') %setting position of figure window, along with the background colour 

%------------UICONTROL components----------
%it makes up the user interface with which the user can interact with 

slider_control = uicontrol('Parent',f,'Style','slider','Position',[43,20,419,23],...
              'value', 0.5, 'min',0.001, 'max',4, 'BackgroundColor', 'Black'); %slider for the width of the coastline
          
slider_text = uicontrol('Parent',f,'Style','text','Position',[50,53,140,13],...
                'String','Europe outline thickness:','BackgroundColor', f.Color); %adding text for the slider
           
change_button = uicontrol('Parent', f, 'Style', 'togglebutton', 'String', 'Change Colormap', ...
                'Position', [43,430,100,30], 'BackgroundColor', 'Black', 'ForegroundColor', 'White'); %button to change the current colormap 
         
river_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Add Rivers', ...
                'Position', [43,465,100,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White'); %checkbox for displaying rivers
            
city_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Add Cities', ...
                'Position', [130,465,100,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White'); %checkbox for displaying cities
          
lake_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Add Lakes', ...
                'Position', [210,465,90,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White'); %checkbox for displaying lakes
            
time_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Display time', ...
                'Position', [290,465,90,20], 'BackgroundColor', 'Black', 'ForegroundColor', 'White'); %chckbox for displaying the time above the map
            
%-----------START OF THE FOR LOOP--------------
            
            
for i = 1:7                             %for loop iterating through al the nc files in the current directory
    ncfile = strcat(int2str(i),".nc");  %converting the number to string and then storing it in the ncfile variable
    lon = ncread(ncfile,'longitude');   %reading the data from the variable called "longitude" in the current nc file
    nx = length(lon);                   %getting the length of the object array
    lat = ncread(ncfile,'latitude');    %reading the data from the latitude
    ny = length(lat);                   %getting the length for the latitude array
    time = ncread(ncfile,'time');       %reading the data form the time variable 
    t = (time - 1038720);               %in order to get the hour in the time, since the 25 values have that nubmer added
   
 
    [X,Y] = meshgrid(lon, lat);         %creating 2D grid coordinates with lon and lat 
    X = double(X);                      %converting the values to double precision arrays
    Y = double(Y);

    for t = 1:length(time)              %from 1 to the length of time, which is 25
        unknown = ncread(ncfile,'unknown',[1 1 t],[nx ny 1]);
        worldmap('Europe')              %construct the map axes for Europe 
        load coastlines                 %load the coastlines of Europe
        plotm(coastlat, coastlon, 'k', 'LineWidth', slider_control.Value) %draw the coastlines with the given line width chosen  by the user
            
        if(change_button.Value == 1)    %button for changing the colour of the map 
            answer = 0;
        end
            
        if (answer == 0)                %if user wants to change, display widget with list of options 
            change_button.Value = 0;
            answer = listdlg('PromptString', {'Please select a colour mode.', ...
                'You can only select one.'}, ...
                'SelectionMode', 'Single', 'ListString', {'Colour blind', ...
                'Default', 'Blue & Green', 'Yellow & Pink High Contrast', 'Warm', 'Black & White' ...
                'Pink Weak Contrast', 'Warm High Contrast', 'Negative Effect'},...  
                'ListSize', [160, 150], 'Name', 'Colour'); %options plus the size of the window
            switch answer               %switch case for the option submitted by the user
                case 1
                    colormap summer;    %different colormaps 
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
            end                         %end of switch case
        end                             %end of if statement

 
%-----------Checking for the values of the checkboxes-----        
        
        if(river_checkbox.Value == 1)   %if statement to check the value of the checkbox 
            rivers = shaperead('worldrivers', 'UseGeoCoords', true); %read the shapefile of world rivers, returns geostruct 
            geoshow(rivers, 'Color', 'blue') %display the rivers on the map 
        end                             %end 
        
        if(city_checkbox.Value == 1)    %only display if the user ticked the checkbox 
            cities = shaperead('worldcities', 'UseGeoCoords', true); %read the shapefile of world cities
            geoshow(cities, 'Marker', '.', 'Color', 'black') %display cities on the map 
        end
        
        if(lake_checkbox.Value == 1)    %if statement for the lakes 
            lakes = shaperead('worldlakes', 'UseGeoCoords', true);
            geoshow(lakes, 'FaceColor', 'blue')
        end  
            
        if(time_checkbox.Value == 1)    %checking if box is ticked for displaying time 
            title(sprintf('time: %i:00', (t-1))) %display the time above the map 
        else
            title(sprintf(''))          %else display nothing 
        end 

%----------------------------------------------------------        

        surfm(Y, X, unknown','FaceAlpha', 0.85); %project the variables from the nc file on the map axis, using "FaceAlpha" for the transparency 
        load coastlines
        outline = plotm(coastlat,coastlon, 'k', 'LineWidth', slider_control.Value);

        drawnow                         %calling drawnow in order to update the figure 
        cla                             %clear plots from the axes after every iteration of the second for loop
    end
end