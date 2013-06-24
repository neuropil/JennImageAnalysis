function handles = updateatlasbutton(handles,redraw)

slice = get(handles.slice_slider,'value');
atlas = get(handles.atlas_slider,'value');
if get(handles.atlas_toggle,'value') == 1
    try %#ok<TRYNC>
        load([handles.buttonpath 'A_off.mat']);
        set(handles.atlas_toggle,'Cdata',x);
        set(handles.atlas_toggle,'string','');
    end
    set(handles.u_button,           'Enable','off');
    set(handles.d_button,           'Enable','off');
    set(handles.l_button,           'Enable','off');
    set(handles.r_button,           'Enable','off');
    set(handles.exabs_button,       'Enable','off');
    set(handles.shabs_button,       'Enable','off');
    set(handles.exbody_button,      'Enable','off');
    set(handles.shbody_button,      'Enable','off');
    set(handles.resetatlas_button,  'Enable','off');
    set(handles.individual_toggle,  'Enable','off');
    set(handles.warp_button,        'Enable','off');
    set(handles.surfacewarp_button, 'Enable','off');
    set(handles.dockregions_toggle, 'Enable','off');
    set(handles.fixedpoints_toggle, 'Enable','off');
    set(handles.mobilepoints_toggle,'Enable','off');
    set(handles.modifybound_button, 'Enable','off');
    set(handles.lockatlas_button,   'Enable','off');
    set(handles.unlockatlas_button, 'Enable','off');
    set(handles.hv_toggle,          'Enable','off');
    set(handles.multiply_button,    'Enable','off');
    
else    
    if ~isempty(handles.lockedatlas{slice}) && handles.lockedatlasnum{slice} == atlas
        try %#ok<TRYNC>
            load([handles.buttonpath 'A_lock.mat']);
            set(handles.atlas_toggle,'Cdata',x);
            set(handles.atlas_toggle,'string','');
        end
    else
        try %#ok<TRYNC>
            load([handles.buttonpath 'A.mat']);
            set(handles.atlas_toggle,'Cdata',x);
            set(handles.atlas_toggle,'string','');
        end
    end
    set(handles.u_button,           'Enable','on');
    set(handles.d_button,           'Enable','on');
    set(handles.l_button,           'Enable','on');
    set(handles.r_button,           'Enable','on');
    set(handles.exabs_button,       'Enable','on');
    set(handles.shabs_button,       'Enable','on');
    set(handles.exbody_button,      'Enable','on');
    set(handles.shbody_button,      'Enable','on');
    set(handles.resetatlas_button,  'Enable','on');
    set(handles.individual_toggle,  'Enable','on');
    set(handles.warp_button,        'Enable','on');
    set(handles.surfacewarp_button, 'Enable','on');
    set(handles.dockregions_toggle, 'Enable','on');
    set(handles.fixedpoints_toggle, 'Enable','on');
    set(handles.mobilepoints_toggle,'Enable','on');
    set(handles.modifybound_button, 'Enable','on');
    set(handles.lockatlas_button,   'Enable','on');
    set(handles.unlockatlas_button, 'Enable','on');
    set(handles.hv_toggle,          'Enable','on');
    set(handles.multiply_button,    'Enable','on');
end
    
if redraw == 1
    if get(handles.atlas_toggle,'value') == 1
        handles.currentatlas = delete_regions(handles.currentatlas);
    else
        handles.currentatlas =   draw_regions(handles.currentatlas);
    end 
end

        
        
varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;        
        