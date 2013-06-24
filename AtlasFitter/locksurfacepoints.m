function trans = locksurfacepoints(trans,handles)

atlas = get(handles.atlas_slider,'value');
for r = 1:length(handles.region{atlas})
    if     get(handles.left_check,'value') == 1 && get(handles.right_check,'value') == 1
        if strcmp(handles.region{atlas}{r}{1},'Whole Section'); break; end
    elseif get(handles.left_check,'value') == 1 && get(handles.right_check,'value') == 0
        if strcmp(handles.region{atlas}{r}{1},'Whole Left'); break; end
    elseif get(handles.left_check,'value') == 0 && get(handles.right_check,'value') == 1
        if strcmp(handles.region{atlas}{r}{1},'Whole Right'); break; end
    else
        if strcmp(handles.region{atlas}{r}{1},'Whole Section'); break; end
    end
end

% allpoints = getregionpoints(handles.region{atlas});
% points    = handles.region{atlas}{r}{2};
allpoints = getregionpoints(handles.currentatlas);
points    = round(handles.currentatlas{r}{2});

for p = 1:size(points,1)
    x = (allpoints(:,1) == points(p,1));
    y = (allpoints(:,2) == points(p,2));
    
    z = x + y;
    bps = find(z == 2);
    for temp = 1:length(bps)
        trans(bps(temp),:) = [0 0];
    end
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0; clear(varnames(vari).name); end
end
clear vari varnames;