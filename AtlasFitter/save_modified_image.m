function handles = save_modified_image(handles,I)

slice = get(handles.slice_slider,'value');
handles.image = I;
set(handles.imagehandle,'cdata',handles.image);
pause(0.01);

[pname fname ext versn] = fileparts(handles.imagepaths{slice}); %#ok<NASGU>
if length(fname) > 3 && strcmp(fname(end-3:end),'_mod') == 1
    newname = [pname,filesep,fname,ext];
else
    newname = [pname,filesep,fname,'_mod',ext];
end
imwrite(I,newname,'TIFF','Compression','none');
handles.imagepaths{slice} = newname;


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;