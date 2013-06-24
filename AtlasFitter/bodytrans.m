function trans = bodytrans(points,speed,direction,pn)

trans              = zeros(size(points));

if speed == 0; speed = 1;
else           speed = str2num(get_atlas_property('fast_speed')); %#ok<ST2NM>
end

if direction == 0; direction = 1;
else               direction = 2;
end

center             = mean([max(points(:,direction)) min(points(:,direction))]);
maxdif             = max(points(:,direction)) - center;
trans(:,direction) = (points(:,direction) - center) / maxdif;
trans              = trans * speed;

if pn == -1
    trans = -trans;
end

if get(handles.locksurface_check,'value') == 1
    trans = locksurfacepoints(trans,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0; clear(varnames(vari).name); end
end
clear vari varnames;