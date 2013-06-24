function [handles,output] = temp_wholeimage_fun(handles,I,output)

for c = 1:3
    output.Ifilt(:,:,c) = imfilter(I(:,:,c),fspecial('gaussian',30,10));
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;