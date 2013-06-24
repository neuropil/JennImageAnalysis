function pairs = findpointpairs(atlas,leftright,varargin)

reducepairs = 0;
if ~iscell(atlas{1}{1});   atemp = atlas;     clear atlas;     atlas{1}    =atemp; reducepairs=1; end

if nargin == 1; leftright = findleftright(atlas); end
if ~iscell(leftright{1}); lrtemp = leftright; clear leftright; leftright{1}=lrtemp;               end


pairs = [];
for a = 1:length(atlas)
    cnt = 0;
    bps       = round(getregionpoints(atlas{a}(leftright{a}{3})));
    allpoints = round(getregionpoints(atlas{a}));
    rpoints   = round(getregionpoints(atlas{a}(leftright{a}{1})));
    lpoints   = round(getregionpoints(atlas{a}(leftright{a}{2})));
    
    for s = 1:3
        points = zeros(size(allpoints));
        if s == 1
            npoints = lpoints;
            rng = 1:size(npoints,1);
            points(rng,:) = npoints;
            points(end-size(bps,1)+1:end,:) = bps;
        elseif s == 2
            npoints = rpoints;
            rng = size(rpoints,1)+1:size(rpoints,1)+size(npoints,1);
            points(rng,:) = npoints;
            points(end-size(bps,1)+1:end,:) = bps;
        else
            points = allpoints;
            rng = size(lpoints,1)+size(rpoints,1)+1:size(allpoints,1);
        end
        
        for p = rng
            cnt=cnt+1;
            xsame = (points(:,1) == points(p,1));
            ysame = (points(:,2) == points(p,2));

            samelogic = xsame + ysame;
            temp1     = find(samelogic == 2);
            temp2     = temp1(temp1 ~= p);

            pairs{a}{cnt} = temp2; %#ok<AGROW>
        end
    end
end
     
if reducepairs == 1
    ptemp = pairs{1};
    clear pairs;
    pairs = ptemp;
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'pairs') == 0; clear(varnames(vari).name); end
end
clear vari varnames;