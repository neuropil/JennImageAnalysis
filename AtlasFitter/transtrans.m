function trans = transtrans(handles,direction)

atlas        = get(handles.atlas_slider,'value');
points       = getregionpoints(handles.currentatlas);
speed        = get(handles.fs_toggle,'value');
left         = get(handles.left_check,'value');
right        = get(handles.right_check,'value');
dock         = get(handles.dockregions_toggle,'value');
lr           = handles.leftright{atlas};
regions      = handles.region{atlas};
activeobject = handles.activeobject;
pairs        = handles.currentpairs;

trans = zeros(size(points));
if speed == 1; direction = direction * str2num(get_atlas_property('fast_speed')); end %#ok<ST2NM>

if     left == 1 && right == 0; goodregions = lr{1};
elseif left == 0 && right == 1; goodregions = lr{2};
elseif left == 1 && right == 1; goodregions = lr{2}; goodregions(end+1:end+length(lr{1})) = lr{1};
else
    if ~isempty(activeobject) && activeobject(1) == 2 
        cnt = 0;
        for r = 1:length(regions)
            for p = 1:size(regions{r}{2},1)
                cnt=cnt+1;
                if sum(r == activeobject(:,2)) > 0
                    trans(cnt,:) = direction;
                    if dock == 0
                        temp1 = pairs{cnt};
                        for pp = 1:length(temp1)
                            trans(temp1(pp),:) = direction;
                        end
                    end
                end
            end
        end
    else
        return;
    end
end

if sum(sum(trans)) == 0
    cnt = 0;
    for r = 1:length(regions);
        for p = 1:size(regions{r}{2},1)
            cnt=cnt+1;
            if ~isempty(find(goodregions == r,1))
                trans(cnt,:) = direction;
                if dock == 0
                    temp1 = pairs{cnt};
                    for pp = 1:length(temp1)
                        trans(temp1(pp),:) = direction;
                    end
                end
            end
        end
    end
end

if get(handles.locksurface_check,'value') == 1
    trans = locksurfacepoints(trans,handles);
end



varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0; clear(varnames(vari).name); end
end
clear vari varnames;