function output = logicalneighbors(bw,c,d)

%bw contains the object perimeter
%c is the i,j coordinates of the point
%d is the dimensions of the bw image (size(bw,1),size(bw,2))
%output is the 3x3 neighborhood surrounding i,j.

%This function will pad the neighborhood with zeros if i,j is on the edge.

output = false(3,3);
output(2,2) = bw(c(1),c(2));
i = c(1);
j = c(2);

if i == 0 || j == 0 || i > d(1) || j > d(2); disp('Coordinates out of bounds.'); end

if i~=1 && i~=d(1) && j~=1 && j~=d(2);
    output = [bw(i-1,j-1) bw(i-1,j) bw(i-1,j+1);...
              bw(i  ,j-1) bw(i  ,j) bw(i  ,j+1);...
              bw(i+1,j-1) bw(i+1,j) bw(i+1,j+1)];
else

    if i ~= 1;    output(1,2) = bw(i-1,j  ); end
    if i ~= d(1); output(3,2) = bw(i+1,j  ); end
    if j ~= 1;    output(2,1) = bw(i  ,j-1); end
    if j ~= d(2); output(2,3) = bw(i  ,j+1); end
    
    if i ~= 1    && j ~= 1;    output(1,1) = bw(i-1,j-1); end
    if i ~= 1    && j ~= d(2); output(1,3) = bw(i-1,j+1); end
    if i ~= d(1) && j ~= 1;    output(3,1) = bw(i+1,j-1); end
    if i ~= d(1) && j ~= d(2); output(3,3) = bw(i+1,j+1); end
end

    
varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'output') == 0; clear(varnames(vari).name); end
end
clear vari varnames;    