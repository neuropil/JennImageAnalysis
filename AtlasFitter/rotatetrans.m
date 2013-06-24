function trans = rotatetrans(handles,direction,bodyangle,inputpoints,varargin)

warning('off','all');
atlas        = get(handles.atlas_slider,'value');
if nargin == 4; points = inputpoints;
else            points = getregionpoints(handles.currentatlas);
end
speed        = get(handles.fs_toggle,'value');
left         = get(handles.left_check,'value');
right        = get(handles.right_check,'value');
dock         = get(handles.dockregions_toggle,'value');
lr           = handles.leftright{atlas};
regions      = handles.currentatlas;
activeobject = handles.activeobject;
pairs        = handles.currentpairs;

if nargin == 2; bodyangle = []; end

trans = zeros(size(points));

if     speed == 0; speed = 1;
elseif speed == 1; speed = str2num(get_atlas_property('fast_speed')); %#ok<ST2NM>
end

if direction == -1;     speed = -speed;    end
if ~isempty(bodyangle); speed = bodyangle; end

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
cnt = 0;
cntb = 0;
for r = 1:length(regions)
    for p = 1:size(regions{r}{2},1)
        cnt = cnt + 1;
        if ~isempty(find(goodregions == r,1))
            cntb = cntb + 1;
            goodpoints(cntb,:) = points(cnt,:); %#ok<AGROW>

        end
    end
end

centerx = mean(goodpoints(:,1));
centery = mean(goodpoints(:,2));

difx = goodpoints(:,1) - centerx;
dify = goodpoints(:,2) - centery;

cnta = 0;
cntb = 0;
for r = 1:length(regions)
    for p = 1:size(regions{r}{2},1)
        cnta = cnta + 1;
        if ~isempty(find(goodregions == r,1))
            cntb = cntb + 1;
            
            ang1 = atand(dify(cntb) / difx(cntb));
    
            if ~isnan(ang1)
                rd   = sqrt((difx(cntb)^2) + (dify(cntb)^2));

                if     difx(cntb) >= 0 && dify(cntb) >= 0;
                elseif difx(cntb) <  0 && dify(cntb) >= 0; ang1 = 180 + ang1;
                elseif difx(cntb) <  0 && dify(cntb) <  0; ang1 = 180 + ang1;
                elseif difx(cntb) >= 0 && dify(cntb) <  0; ang1 = 360 + ang1;
                end

                ang2 = ang1 + speed;

                x2   = rd * cosd(ang2);
                y2   = rd * sind(ang2);

                trans(cnta,:) = [ x2 - difx(cntb)  y2 - dify(cntb)];
                if dock == 0
                    temp1 = pairs{cnta};
                    for pp = 1:length(temp1)
                        trans(temp1(pp),:) = [ x2 - difx(cntb)  y2 - dify(cntb)];
                    end
                end
            else
                trans(cnta,:) = [0 0];
                if dock == 0
                    temp1 = pairs{cnta};
                    for pp = 1:length(temp1)
                        trans(temp1(pp),:) = [ x2 - difx(cntb)  y2 - dify(cntb)];
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
    if strcmp(varnames(vari).name,'trans') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;