function [handles,output] = individualregions_countcells(handles,Iir,output)

Iir = sum(Iir,3);
Iir(Iir ~= 0) = 1;

if strcmp(get_atlas_property('analyze_user_regions'),'ignore')
    Iir = userregion_ignore(Iir,handles);
end

ar = sum(sum(Iir)) / 1e4; %#ok<NASGU>

temp = output.cells{handles.i};
temp(Iir == 0) = 0;
temp1 = sparse(bwlabel(temp));

cnt = unique(temp1);
cnt = full(cnt(cnt ~= 0)); 

name = handles.lockedatlas{handles.i}{handles.r}{1};
if     ~isempty(find(handles.leftright{handles.lockedatlasnum{handles.i}}{1} == handles.r,1)); name = ['L_',name]; %#ok<EFIND>
elseif ~isempty(find(handles.leftright{handles.lockedatlasnum{handles.i}}{2} == handles.r,1)); name = ['R_',name]; %#ok<EFIND>
end

name(name == ' ') = '_';

output.count{handles.i}.atlasnum = handles.lockedatlasnum{handles.i};
eval(['output.count{handles.i}.',name,' = numel(cnt);']);
eval(['output.normalized_count{handles.i}.',name,' = numel(cnt)/ar;']);
eval(['output.area{handles.i}.',name,' = ar;']);


temp = output.norm{handles.i};
temp(Iir == 0) = 0;
celltemp = [];
for i = 1:numel(cnt);
    celltemp(i) = mean(temp(temp1 == cnt(i))); %#ok<AGROW>
end
celltemp = full(celltemp); %#ok<NASGU>

eval(['output.meancell{handles.i}.',name,' = celltemp;']);
eval(['output.signal{handles.i}.',name,' = sum(temp(temp1 ~= 0));']);

if isfield(output,'x');    output = rmfield(output,'x');    end

if handles.r == length(handles.lockedatlas{handles.i})
    disp(output.count{handles.i});
    output.cells{handles.i} = [];
    output.norm{ handles.i} = [];
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;