function x = removeedge(x)

badareas = unique(x.cells(x.edg == 1));
badareas(badareas == 0) = [];

for i = 1:length(badareas);
    r = badareas(i);
    
    x.cells(x.pixel{r}) = 0;
    x.index{r} = [];
    x.pixel{r} = [];
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'x') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;