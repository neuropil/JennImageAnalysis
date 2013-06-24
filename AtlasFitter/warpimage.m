function trans = warpimage(oldpoints,newpoints,handles)

atlas = get(handles.atlas_slider,'value');
allpoints = getregionpoints(handles.currentatlas);

trans = interpolated_warp_algorithm(oldpoints,newpoints,allpoints);

if get(handles.left_check,'value')==1 && get(handles.right_check,'value')==0
    lregions = handles.leftright{atlas}{1};
    cnt=0;
    for r = 1:length(handles.currentatlas)
        for p = 1:size(handles.currentatlas{r}{2},1)
            cnt=cnt+1;
            if isempty(find(lregions == r,1)); trans(cnt,:)=[0 0]; end
        end
    end
    
elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==1
    rregions = handles.leftright{atlas}{2};
    cnt=0;
    for r = 1:length(handles.currentatlas)
        for p = 1:size(handles.currentatlas{r}{2},1)
            cnt=cnt+1;
            if isempty(find(rregions == r,1)); trans(cnt,:)=[0 0]; end
        end
    end
end

regions = handles.currentatlas;
for r = 1:length(regions); if strcmp(regions{r}{1},'Whole Section') == 1; break; end; end
points = round(regions{r}{2});

allpoints = getregionpoints(handles.currentatlas);
for bp = 1:size(points,1)
    for ap = 1:size(allpoints,1)
        if sum(points(bp,:) == allpoints(ap,:)) == 2 && sum(trans(ap,:)) ~= 0
            trans(end-size(points,1)+bp,:) = trans(ap,:);
            break 
        end
    end
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;