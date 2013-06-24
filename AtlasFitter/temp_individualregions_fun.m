function [handles,output] = temp_individualregions_fun(handles,Iir,output)

badcols = zeros(3,size(Iir,2));
for c = 1:3
    badcols(c,:) = sum(Iir(:,:,c),1) == 0;
end
Iir(:,sum(badcols,1) == 3,:) = [];
    
badrows = zeros(size(Iir,1),3);
for c = 1:3
    badrows(:,c) = sum(Iir(:,:,c),2) == 0;
end
Iir(sum(badrows,2) == 3,:,:) = [];    

figure;
imshow(Iir);
title(['Region ',handles.lockedatlas{handles.i}{handles.r}{1},' Image ',num2str(handles.i)]);
pause(0.1);


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;