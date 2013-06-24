function leftright = findleftright(atlas)

for a = 1:length(atlas)
    regions = atlas{a};
    points  = getregionpoints(regions);
    centerx = mean(points(:,1));
    cntl    = 0;
    cntr    = 0;
    
    for r = 1:length(regions)
        
        if ~strcmp(regions{r}{1},'Whole Section')
            labelx = regions{r}{6}(1);

            if labelx < centerx; cntl=cntl+1; leftright{a}{1}(cntl) = r; %#ok<AGROW>
            else                 cntr=cntr+1; leftright{a}{2}(cntr) = r; %#ok<AGROW>
            end
        else
            leftright{a}{3} = r; %#ok<AGROW>
        end
            
    end
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'leftright') == 0; clear(varnames(vari).name); end
end
clear vari varnames;