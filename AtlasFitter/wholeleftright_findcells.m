function [handles,output] = wholeleftright_findcells(handles,Ilr,output)

if isfield(output,'x'); x = output.x;
else                    x = [];
end
if isfield(output,'norm'); output = rmfield(output,'norm'); end

x = CellCounter(Ilr,'all',x);
output.cells{handles.i} = logical(x.cellcores);
output.norm{ handles.i} = sparse( x.cellnorm);


if strcmp(get_atlas_property('analyze_user_regions'),'ignore')
    output.cells{handles.i} = logical(userregion_ignore(output.cells{handles.i},handles));
    output.norm{ handles.i} = sparse( userregion_ignore(output.norm{ handles.i},handles));
end

if isfield(output,'x'); output = rmfield(output,'x'); end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;