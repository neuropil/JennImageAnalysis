function trans = movepointtrans(handles)

points = getregionpoints(handles.currentatlas);
trans  = zeros(size(points));

waitforbuttonpress;
click = get(handles.axes1,'CurrentPoint');

difx = click(1,1) - points(handles.activeobject(2:end),1);
dify = click(1,2) - points(handles.activeobject(2:end),2);

trans(handles.activeobject(2:end),1) = difx;
trans(handles.activeobject(2:end),2) = dify;

if get(handles.locksurface_check,'value') == 1
    trans = locksurfacepoints(trans,handles);
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0; clear(varnames(vari).name); end
end
clear vari varnames;