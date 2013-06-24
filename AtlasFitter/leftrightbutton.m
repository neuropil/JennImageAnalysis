function handles = leftrightbutton(handles)

if get(handles.left_check,'value') == 1 && get(handles.right_check,'value') == 1
    try %#ok<TRYNC>
        load([handles.buttonpath 'L.mat']);
        set(handles.left_check,'Cdata',x);
        set(handles.left_check,'string','');
        load([handles.buttonpath 'R.mat']);
        set(handles.right_check,'Cdata',x);
        set(handles.right_check,'string','');
    end
elseif get(handles.left_check,'value') == 1 && get(handles.right_check,'value') == 0
    try %#ok<TRYNC>
        load([handles.buttonpath 'L.mat']);
        set(handles.left_check,'Cdata',x);
        set(handles.left_check,'string','');
        load([handles.buttonpath 'R_off.mat']);
        set(handles.right_check,'Cdata',x);
        set(handles.right_check,'string','');
    end
elseif get(handles.left_check,'value') == 0 && get(handles.right_check,'value') == 1
    try %#ok<TRYNC>
        load([handles.buttonpath 'L_off.mat']);
        set(handles.left_check,'Cdata',x);
        set(handles.left_check,'string','');
        load([handles.buttonpath 'R.mat']);
        set(handles.right_check,'Cdata',x);
        set(handles.right_check,'string','');
    end
elseif get(handles.left_check,'value') == 0 && get(handles.right_check,'value') == 0
    try %#ok<TRYNC>
        load([handles.buttonpath 'L_off.mat']);
        set(handles.left_check,'Cdata',x);
        set(handles.left_check,'string','');
        load([handles.buttonpath 'R_off.mat']);
        set(handles.right_check,'Cdata',x);
        set(handles.right_check,'string','');
    end    
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;