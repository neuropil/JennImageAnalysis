function atlas_converter

p = uigetdir;
files = dir(p);

for f = 1:length(files)
    disp(['Converting ',files(f).name,'...']);
    [pathstr, name, ext, versn] = fileparts(files(f).name); %#ok<NASGU>
    
    if strcmp(ext,'.tif') == 1
        x = imread([p filesep files(f).name]);
        if size(x,3) == 3
            y = x(:,:,3);
            z = zeros(size(x,1),size(x,2));
            z(y == 208) = 1;
            
            x = z; %#ok<NASGU>
            save([p filesep 'RBA_' files(f).name(10:12) '.mat'],'x');
        end
    end
end
disp('Complete');