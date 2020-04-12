f = figure('Position', [150, 100, 500, 500]);

slider_control = uicontrol('Parent',f,'Style','slider','Position',[43,20,419,23],...
              'value', 0.35, 'min',0, 'max',0.7);
bgcolor = f.Color;
slider_text = uicontrol('Parent',f,'Style','text','Position',[185,53,140,13],...
                'String','Europe outline thickness','BackgroundColor',bgcolor);
            
change_button = uicontrol('Parent', f,'Style', 'checkbox', 'String', 'Change colormap', ...
                'Position', [43,430,100,30])         
            
disp(change_button.Value)
worldmap('Europe')
load coastlines
plotm(coastlat, coastlon, 'k', 'LineWidth', slider_control.Value)

