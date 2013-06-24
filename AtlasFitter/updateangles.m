function handles = updateangles(handles,direction)

if strcmp(direction,'reset')
    handles.currentangles = zeros(length(handles.currentatlas),1);
    set(handles.angle_edit,'string','0');
    return;
end

if strcmp(direction,'update')
    if ~isempty(handles.activeobject); R = handles.activeobject;
    else
        if     get(handles.left_check,'value')==1 && get(handles.right_check,'value')==0; r = 'Whole Left'; 
        elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==1; r = 'Whole Right';
        elseif get(handles.left_check,'value')==1 && get(handles.right_check,'value')==1; r = 'Whole Section';
        else   disp('Error: No active object found.'); return;
        end
        for i = 1:length(handles.currentatlas)
            if strcmp(handles.currentatlas{i}{1},r); R = i; break; end
        end
    end
    set(handles.angle_edit,'string',num2str(handles.currentangles(R(end)))); %#ok<ST2NM>
    return;
end
            
atlas        = get(handles.atlas_slider,'value');
lr           = handles.leftright{atlas};
speed        = get(handles.fs_toggle,'value');
if speed == 1; direction = direction * str2num(get_atlas_property('fast_speed')); end %#ok<ST2NM>

if ~isempty(handles.activeobject); R = handles.activeobject;
else
    if     get(handles.left_check,'value')==1 && get(handles.right_check,'value')==0; R = lr{1}; 
    elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==1; R = lr{2};
    elseif get(handles.left_check,'value')==1 && get(handles.right_check,'value')==1; R = 1:length(handles.currentatlas);
    else   disp('Error: No active object found.'); return;
    end
end

ang    = handles.currentangles;
ang(R) = ang(R) + direction;
ang(ang < 0)    = ang(ang < 0)    + 360;
ang(ang >= 360) = ang(ang >= 360) - 360;

handles.currentangles = ang;
set(handles.angle_edit,'string',num2str(ang(R(end))));



varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;