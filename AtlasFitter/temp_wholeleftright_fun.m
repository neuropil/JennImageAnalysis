function [handles,output] = temp_wholeleftright_fun(handles,Ilr,output)

badcols = zeros(3,size(Ilr,2));
for c = 1:3
    badcols(c,:) = sum(Ilr(:,:,c),1) == 0;
end
Ilr(:,sum(badcols,1) == 3,:) = [];
    
badrows = zeros(size(Ilr,1),3);
for c = 1:3
    badrows(:,c) = sum(Ilr(:,:,c),2) == 0;
end
Ilr(sum(badrows,2) == 3,:,:) = [];    

figure;
imshow(Ilr);
title(['Whole Left Right Image ',num2str(handles.i)]);
pause(0.1);


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;