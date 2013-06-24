function points = getregionpoints(regions)

points = [];

for r = 1:length(regions)
    
    xi = round(regions{r}{2}(:,1));
    yi = round(regions{r}{2}(:,2));
    
    points(end+1:end+length(xi),:) = [xi yi];
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'points') == 0; clear(varnames(vari).name); end
end
clear vari varnames;