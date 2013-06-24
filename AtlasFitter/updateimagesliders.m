function handles = updateimagesliders(handles)

x = get(handles.axes1,'XLim');
y = get(handles.axes1,'YLim');

xr = abs(x(2) - x(1) + 1) / 2;
yr = abs(y(2) - y(1) + 1) / 2;

Ix = handles.imagesize(2);
Iy = handles.imagesize(1);

xv = mean(x);
yv = mean(y);

yv = Iy - yv;

if xv < xr-1 || xv > Ix-xr+1; xv = Ix/2; end
if yv < yr-1 || yv > Iy-yr+1; yv = Iy/2; end

xs = Ix - (2 * xr);
ys = Iy - (2 * yr);

set(handles.horizontal_slider,'Min',xr-1,'Max',Ix-xr+1,'value',xv);
set(handles.vertical_slider,  'Min',yr-1,'Max',Iy-yr+1,'value',yv);

if xs > 0; set(handles.horizontal_slider,'SliderStep',[10/xs 100/xs]); 
           set(handles.horizontal_slider,'Enable','On');
else       set(handles.horizontal_slider,'Enable','Off');
end
if ys > 0; set(handles.vertical_slider,  'SliderStep',[10/ys 100/ys]); 
           set(handles.vertical_slider,  'Enable','On');
else       set(handles.vertical_slider,  'Enable','Off');
end

handles.vsprevious = get(handles.vertical_slider,'value');
handles.hsprevious = get(handles.horizontal_slider,'value');


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;