function trans = warpfilter(oldpoints,newpoints,allpoints,power,varargin)

if nargin == 3
    power = 2;
end

for temp = 1:size(oldpoints,1)
    fp{temp} = [oldpoints(temp,:); newpoints(temp,:)-oldpoints(temp,:)]; %#ok<AGROW>
end

for x = 1:size(oldpoints,1) 
    for temp = 1:size(allpoints,1)
        dm{x}(temp) = pdist([allpoints(temp,:); oldpoints(x,:)]); %#ok<AGROW>
    end  
end

x_vert = zeros(1,size(allpoints,1));
x_horz = zeros(1,size(allpoints,1));
y      = zeros(1,size(allpoints,1));

for x = 1:1:size(oldpoints,1)
    v = fp{x}(2);
    h = fp{x}(4);
    d = dm{x};
    L = 1./(0.00001+d.^power); 
    
    x_vert = x_vert + (v*L); 
    x_horz = x_horz + (h*L); 
    y = y + L;               
end

vert_rule = (x_vert./y); 
horz_rule = (x_horz./y); 

trans = [vert_rule' horz_rule'];


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;