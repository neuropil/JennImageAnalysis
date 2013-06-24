function regions = delete_regions(regions)

for r = 1:length(regions)
    for p = 1:length(regions{r}{3})
        try delete(regions{r}{3}(p)); catch disp(['Error: Region ',num2str(r),' Point ',num2str(p),' does not exist.']); end 
    end
    try delete(regions{r}{4}); catch disp(['Error: Patch for region ',num2str(r),' does not exist.']); end 
    try delete(regions{r}{5}); catch disp(['Error: Text for region ',num2str(r),' does not exist.']); end 
    
    regions{r}{3} = []; 
    regions{r}{4} = [];
    regions{r}{5} = [];
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'regions') == 0; clear(varnames(vari).name); end
end
clear vari varnames;
    