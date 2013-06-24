function A = predictatlas(handles)

A = [];
D = [];
for a = 1:length(handles.region)
    D = [D handles.region{a}{1}{7}(1)]; %#ok<AGROW>
end

data = [];
for s = 1:length(handles.lockedatlasnum);
    if ~isempty(handles.lockedatlasnum{s})
        data = [data; s D(handles.lockedatlasnum{s})]; %#ok<AGROW>
    end
end

if size(data,1) < 2; disp('Atlas Predictor requires at least 2 locked atlases.'); return; end

p = polyfit(data(:,1), data(:,2), 1);
slice = get(handles.slice_slider,'value');

d = (p(1) * slice) + p(2);
d_dif = abs(D - d);

A = find(d_dif == min(d_dif));
A = A(1);


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'A') == 0; clear(varnames(vari).name); end
end
clear vari varnames;