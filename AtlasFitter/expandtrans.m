function trans = expandtrans(handles,pn,inputpoints,varargin)

atlas        = get(handles.atlas_slider,'value');
if nargin == 3; points = inputpoints;
else            points = getregionpoints(handles.currentatlas);
end
speed        = get(handles.fs_toggle,'value');
left         = get(handles.left_check,'value');
right        = get(handles.right_check,'value');
dock         = get(handles.dockregions_toggle,'value');
direction    = get(handles.hv_toggle,'value');
lr           = handles.leftright{atlas};
regions      = handles.currentatlas;
activeobject = handles.activeobject;
pairs        = handles.currentpairs;

trans = zeros(size(points));

if speed == 0; speed = 1;
else           speed = str2num(get_atlas_property('fast_speed')); %#ok<ST2NM>
end

if direction == 0; direction = 1;
else               direction = 2;
end

if     left == 1 && right == 0; goodregions = lr{1};
elseif left == 0 && right == 1; goodregions = lr{2};
elseif left == 1 && right == 1; goodregions = lr{1}; goodregions(end+1:end+length(lr{2})) = lr{2};
else 
    if ~isempty(activeobject) && activeobject(1) == 2 
        goodregions = activeobject(:,2);
    else
        return;
    end
end

goodpoints = [];
cnta = 0;
cntb = 0;
for r = 1:length(regions)
    for p = 1:size(regions{r}{2},1)
        cnta = cnta + 1;
        if ~isempty(find(goodregions == r,1))
            cntb = cntb + 1;
            goodpoints(cntb,:) = points(cnta,:); %#ok<AGROW>
        end
    end
end

center = mean(goodpoints(:,direction));
maxdif = max(goodpoints(:,direction)) - center;

cnta = 0;
cntb = 0;
for r = 1:length(regions)
    for p = 1:size(regions{r}{2},1)
        cnta = cnta + 1;
        if ~isempty(find(goodregions == r,1))
            cntb = cntb + 1;
            trans(cnta,direction) = (goodpoints(cntb,direction) - center) / maxdif;
            if dock == 0
                temp1 = pairs{cnta};
                for pp = 1:length(temp1)
                    trans(temp1(pp),direction) = (goodpoints(cntb,direction) - center) / maxdif;
                end
            end
        end
    end
end

trans = trans * speed;

if pn == -1
    trans = -trans;
end

if get(handles.locksurface_check,'value') == 1
    trans = locksurfacepoints(trans,handles);
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0; clear(varnames(vari).name); end
end
clear vari varnames;