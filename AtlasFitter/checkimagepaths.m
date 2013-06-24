function newpaths = checkimagepaths(oldpaths,imagestackpath)

curpath = [pwd,filesep];
answer1 = [];
newpaths = [];
cnt=0;
changesmade = 0;

for i = 1:length(oldpaths)
    oldpaths{i}(oldpaths{i} == '\') = filesep;
    oldpaths{i}(oldpaths{i} == '/') = filesep;
    
    [pname,fname,ext,versn] = fileparts(oldpaths{i}); %#ok<NASGU>
    pname = [pname,filesep]; %#ok<AGROW>
    if strcmp(pname,curpath) == 1; 
        if exist([pname,fname,ext],'file') == 2
            disp(['Found file: ',fname,ext,'  in current directory.']);
            %The file is where it should be
            cnt=cnt+1;
            newpaths{cnt} = oldpaths{i}; %#ok<AGROW>
            continue;
        else
            disp(['Cannot locate file: ',[fname,ext],'.   Please find it for me.']);
            [f p] = uigetfile(['*',ext]);
            if f == 0; continue;
            else
                cnt=cnt+1;
                newpaths{cnt} = [p,f]; %#ok<AGROW>
                cd(p);
                curpath = p;
                changesmade = 1;
            end
        end
    elseif exist([pname,filesep,fname,ext],'file') == 2
        %The file exists, but not in the current directory.
        disp(['Found file: ',fname,ext,'  in alternate directory.']);
        cnt=cnt+1;
        newpaths{cnt} = oldpaths{i}; %#ok<AGROW>
        continue;
    elseif exist([curpath,fname,ext],'file') == 2
        %The file is not where the oldpath points, but it is in the current directory
        if isempty(answer1); 
            disp('Mismatch between actual file location and where the path points.');
            answer1 = questdlg('Do you want to update the directory?',...
                'The image files appear to have been moved.','Yes','No','Cancel','Yes');
        end
        changesmade = 1;
        if strcmp(answer1,'Cancel')
            newpaths = [];
            return;
        elseif strcmp(answer1,'Yes')
            disp(['Setting new file path as: ',curpath,fname,ext]);
            cnt=cnt+1;
            newpaths{cnt} = [curpath,fname,ext]; %#ok<AGROW>
            continue;
        elseif strcmp(answer1,'No')
            disp(['Cannot locate file: ',fname,ext,'.   Please find it for me.']);
            [f p] = uigetfile(['*',ext]);
            if f == 0; continue;
            else
                cnt=cnt+1;
                newpaths{cnt} = [p,f]; %#ok<AGROW>
                cd(p);
                curpath = p;
            end
        end
    else
        %The path does not point to the current directory and the file
        %is nowhere to be found.  User must find it manually.
        disp(['Cannot locate file: ',fname,ext,'.   Please find it for me.']);
        [f p] = uigetfile(['*',ext]);
        changesmade = 1;
        if f == 0; continue;
        else
            cnt=cnt+1;
            newpaths{cnt} = [p,f]; %#ok<AGROW>
            cd(p);
            curpath = p;
        end
    end
end

if changesmade == 1
    disp('Saving Modified Image File.')
    imagestack = newpaths; %#ok<NASGU>
    [pname,fname,ext,versn] = fileparts(imagestackpath); %#ok<NASGU>
    save([pname,filesep,fname,'_mod',ext],'imagestack');
end
            
varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'newpaths') == 0; clear(varnames(vari).name); end
end
clear vari varnames;