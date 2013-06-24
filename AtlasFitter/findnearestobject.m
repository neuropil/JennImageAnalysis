function output = findnearestobject(regions,click,force,varargin)

points     = getregionpoints(regions);
difx       = abs(points(:,1) - click(1,1));
dify       = abs(points(:,2) - click(1,2));
dif        = [difx dify];
diflogic   = sum(dif < 10,2);
distance   = sqrt(difx .^ 2 + dify .^ 2);
goodregion = [];
output     = [];
if nargin == 2; force = 'nothing'; end

if ~isempty(find(diflogic == 2,1)) || strcmp(force,'point')==1
    
    point = find(diflogic == 2);
    if isempty(point)
        point = find(distance == min(distance));
        if min(distance) > 20
            disp(['Warning: Click was ',num2str(min(distance)),' pixels from the nearest point.']);
        end
    end
    
    output(1) = 1; %1 for a point, 2 for a region
    output(2:1+length(point)) = point;
else
    
    for r = 1:length(regions)
        coords = regions{r}{2};
        difr      = [];
        difr(:,1) = coords(:,1) - click(1,1);
        difr(:,2) = coords(:,2) - click(1,2);
        angs      = zeros(length(coords),1);
        
        for p = 1:length(coords)
            ang = atand(difr(p,2)/difr(p,1));
            
            if     difr(p,1) >= 0 && difr(p,2) >= 0;
            elseif difr(p,1) <  0 && difr(p,2) >= 0; ang = 180 + ang;
            elseif difr(p,1) <  0 && difr(p,2) <  0; ang = 180 + ang;
            elseif difr(p,1) >= 0 && difr(p,2) <  0; ang = 360 + ang;
            end
            
            angs(p) = ang;
        end
        
        angcover = zeros(360,1);
        angs(end+1)     = ang(1); %#ok<AGROW>
        angs            = round(angs);
        angs(angs == 0) = 360;
        for a = 1:length(angs)-1
            temp1 = max(angs(a:a+1));
            temp2 = min(angs(a:a+1));
  
            if temp1 - temp2 < 180
                angcover(round(temp2):round(temp1)) = 1;
            else
                angcover(round(temp1):360) = 1;
                angcover(1:round(temp2))   = 1;
            end
        end
        
        if sum(angcover) == 360
            goodregion(end+1) = r; %#ok<AGROW>
        end 
    end
    
    if numel(goodregion) == 1
        output(1) = 2;
        output(2) = goodregion;
    else
        goodregionnew = [];
        for r = 1:length(goodregion)
            if ~strcmp(regions{goodregion(r)}{1},'Whole Section') && ...
               ~strcmp(regions{goodregion(r)}{1},'Whole Left')  && ...
               ~strcmp(regions{goodregion(r)}{1},'Whole Right')
                goodregionnew(end+1) = goodregion(r); %#ok<AGROW>
            end
        end
        if numel(goodregionnew) == 1
            output(1) = 2;
            output(2) = goodregionnew;
        end
    end
end
        
varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'output') == 0; clear(varnames(vari).name); end
end
clear vari varnames;