function propertyvalue = get_atlas_property(propertyname)

fid   = fopen('C:\Documents and Settings\stratfoj.UNIVERSITY\My Documents\MATLAB\AtlasFitter5\AtlasProperties.txt');
S = textscan(fid,'%s','delimiter','');
S = S{1};
propertyvalue = [];

for s = 1:length(S)
    lastpn = [];
    for i = 1:length(S{s})
        if     strcmp(S{s}(i),' ') == 1 &&  isempty(lastpn); lastpn = i - 1;
        elseif strcmp(S{s}(i),' ') == 0 && ~isempty(lastpn); firstpv = i; break;
        end
    end
    
    pn = S{s}(1:lastpn);
    
    if strcmp(pn,propertyname)
        propertyvalue = S{s}(firstpv:end);
        fclose(fid);
        return;
    end
end

fclose(fid);
disp(['Atlas Property "',propertyname,'" not found.']);


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'propertyvalue') == 0; clear(varnames(vari).name); end
end
clear vari varnames;