function [handles,output] = wholeimage_findedge(handles,I,output)

if isempty(handles.lockedatlas{handles.i}); return; end

output.x = CellCounter(I,'findedge');


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;