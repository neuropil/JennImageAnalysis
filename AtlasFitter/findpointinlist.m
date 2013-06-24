function output = findpointinlist(point,list,error,varargin)

if nargin < 3; error = 1; end

temp1 = zeros(size(list,1),1);
temp2 = zeros(size(list,1),1);

if error == 1
    temp1(list(:,1)==point(1,1)) = 1;
    temp2(list(:,2)==point(1,2)) = 1;
else
    temp1 = (abs(list(:,1) - point(1,1))) <= error;
    temp2 = (abs(list(:,2) - point(1,2))) <= error;
end

output = find(sum([temp1 temp2],2) == 2);

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'output') == 0; clear(varnames(vari).name); end
end
clear vari varnames;