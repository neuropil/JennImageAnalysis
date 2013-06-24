function output = userregion_overlap(handles)

output = [];

for slice = 1:handles.numslices
    I = imread(handles.imagepaths{slice});
    I = zeros(size(I,1),size(I,2));
    
    if ~isempty(handles.lockedatlas{slice})
        po = zeros(length(handles.lockedatlas{slice}),1);
        atlas = handles.lockedatlasnum{slice};
        disp(['Computing Overlap for Atlas ',num2str(atlas)]);
        
        mask = zeros(size(I,1),size(I,2));
        for ur = 1:length(handles.userregion{slice})
            if ~isempty(handles.userregion{slice}{ur})
                xi = handles.userregion{slice}{ur}(:,1);
                yi = handles.userregion{slice}{ur}(:,2);
                mask = mask + roipoly(I,xi,yi);
            end
        end
        
        mask(mask > 1) = 1;
        ar = zeros(length(handles.lockedatlas{slice}),1);
        
        for r = 1:length(handles.lockedatlas{slice});
            xi = handles.lockedatlas{slice}{r}{2}(:,1);
            yi = handles.lockedatlas{slice}{r}{2}(:,2); 
            BW = roipoly(I,xi,yi);

            ar(r) = sum(sum(BW));
            ol = BW + mask;
            ol = sum(sum(ol == 2));
            po(r) = po(r) + (ol / ar(r));

        end

        for r = 1:length(handles.lockedatlas{slice})
            rn{r} = handles.lockedatlas{slice}{r}{1}; %#ok<AGROW>
            if     ~isempty(find(handles.leftright{atlas}{1} == r,1)); side = 'L';
            elseif ~isempty(find(handles.leftright{atlas}{2} == r,1)); side = 'R';
            else                                                       side = ' ';
            end
            message = [side,' ',rn{r}];
            message(end+1:20) = ' ';
            message = [message num2str(po(r))]; %#ok<AGROW>
            disp(message);
        end
        
        output{slice}.imagepaths     = handles.imagepaths{slice}; %#ok<AGROW>
        output{slice}.lockedatlasnum = handles.lockedatlasnum{slice}; %#ok<AGROW>
        output{slice}.lockedatlas    = handles.lockedatlas{slice}; %#ok<AGROW>
        output{slice}.lockedflip     = handles.lockedflip{slice}; %#ok<AGROW>
        output{slice}.lockedangles   = handles.lockedangles{slice}; %#ok<AGROW>
        output{slice}.userregions    = handles.userregion{slice}; %#ok<AGROW>
        output{slice}.regionnames    = rn; %#ok<AGROW>
        output{slice}.regionareas    = ar; %#ok<AGROW>
        output{slice}.percentoverlap = po; %#ok<AGROW>
        
    end
end

disp('UserRegion Overlap Complete');


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'output') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;