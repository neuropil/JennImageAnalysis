function [handles,output] = temp_wholesection_fun(handles,Iws,output)

badcols = zeros(3,size(Iws,2));
for c = 1:3
    badcols(c,:) = sum(Iws(:,:,c),1) == 0;
end
Iws(:,sum(badcols,1) == 3,:) = [];
    
badrows = zeros(size(Iws,1),3);
for c = 1:3
    badrows(:,c) = sum(Iws(:,:,c),2) == 0;
end
Iws(sum(badrows,2) == 3,:,:) = [];    

figure;
imshow(Iws);
title(['Whole Section Image ',num2str(handles.i)]);
pause(1);


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;