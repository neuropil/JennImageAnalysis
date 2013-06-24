function handles = updatecurrentflip(handles,direction)

atlas        = get(handles.atlas_slider,'value');
left         = get(handles.left_check,'value');
right        = get(handles.right_check,'value');
lr           = handles.leftright{atlas};
activeobject = handles.activeobject;


if     left == 1 && right == 0; goodregions = lr{1};
elseif left == 0 && right == 1; goodregions = lr{2};
elseif left == 1 && right == 1; goodregions = 1:length(handles.currentatlas);
else 
    if ~isempty(activeobject) && activeobject(1) == 2 
        goodregions = activeobject(:,2);
    else
        return;
    end
end

if strcmp(direction,'reset')
    handles.currentflip = zeros(length(handles.currentatlas),1);
else
    for r = 1:length(goodregions)
        if handles.currentflip(goodregions(r)) == 0; handles.currentflip(goodregions(r)) = 1;
        else                                         handles.currentflip(goodregions(r)) = 0;
        end
    end
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;