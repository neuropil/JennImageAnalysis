function output = perimdirection(p,c,direction)

%p is the coordinates of the perimeter
%c is the centroid of the perimeter
%direction is either 'cw' or 'ccw'

ang = zeros(size(p,1),1);
temp(:,1) = p(:,1) - c(1);
temp(:,2) = p(:,2) - c(2);

for i = 1:size(p,1) 
   ang(i) =  atand(abs(temp(i,2)) / abs(temp(i,1)));
   
   if     temp(i,1) <  0 && temp(i,2) <= 0; ang(i) = ang(i) + 180;
   elseif temp(i,1) >= 0 && temp(i,2) <  0; ang(i) = 360 - ang(i);
   elseif temp(i,1) <= 0 && temp(i,2) >  0; ang(i) = 180 - ang(i);
   end
   
   if i > 1; 
       a = sqrt((temp(i-1,1) ^ 2) + (temp(i-1,2) ^ 2));
       b = sqrt((temp(i,1)   ^ 2) + (temp(i,2)   ^ 2));
       c = sqrt(((p(i-1,1) - p(i,1)) ^ 2) + ((p(i-1,2) - p(i,2)) ^ 2));
       s = (a + b + c) / 2;
       
       ad(i-1) = ang(i) - ang(i-1);  %#ok<AGROW>
       Ar(i-1) = sqrt(s * (s - a) * (s - b) * (s - c)); %#ok<NASGU>
   end 
   
end

Ar(ad < 0) = -Ar(ad < 0);

if     sum(Ar) > 0; d = 'ccw';
elseif sum(Ar) < 0; d = 'cw';
else                d = 'keep';
end

if strcmp(direction,d) == 1 || strcmp('keep',d) == 1
    output = p; 
else
    output = p(end:-1:1,:);
end
    
if (strcmp('cw',d) == 1 || strcmp('ccw',d) == 1)
    if strcmp(d,direction) == 0
        disp(['Region direction originally ',d,'. Reversing to ',direction]);
    else
        disp(['Region direction originally ',d,'. No change made.']);
    end
else
    disp('Region direction cannot be determined. No change made.');
end
    

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'output') == 0; clear(varnames(vari).name); end
end
clear vari varnames;