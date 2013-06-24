function trans = warpfilter2(oldpoints,newpoints,allpoints)

trans = [];
for temp = 1:size(oldpoints,1)
    Z(temp,:) = newpoints(temp,:)-oldpoints(temp,:); %#ok<AGROW>
end

[X Y] = meshgrid(1:max(allpoints(:,1))+1,1:max(allpoints(:,2))+1);
Z1 = griddata(oldpoints(:,1),oldpoints(:,2),Z(:,1),X,Y);
Z2 = griddata(oldpoints(:,1),oldpoints(:,2),Z(:,2),X,Y); %#ok<NASGU>

temp        = [];
temp(:,:,1) = Z1;
temp(:,:,2) = Z1;
d   (:,:,1) = Z1; d(~isnan(d)) = 0;
d   (:,:,2) = d(:,:,1);
swap        = [1 2; 2 1];

for i = 1:2
    for r = 1:size(temp,1)
        t = find(isnan(temp(r,:,swap(i,1))) == 0);
        if ~isempty(t)
            p1 = 1:min(t);
            p2 = max(t):size(temp,2);

            temp(r,p1,swap(i,1)) = temp(r,min(t),swap(i,1));
            d   (r,p1,swap(i,1)) = length(p1)-1+d(r,min(t),swap(i,1)): -1: d(r,min(t),swap(i,1));

            temp(r,p2,swap(i,1)) = temp(r,max(t),swap(i,1));
            d   (r,p2,swap(i,1)) = d(r,max(t),swap(i,1)) : length(p2)-1+d(r,max(t),swap(i,1));
        end
    end
    for c = 1:size(temp,2)
        t = find(isnan(temp(:,c,swap(i,2))) == 0);
        if ~isempty(t)
            p1 = 1:min(t);
            p2 = max(t):size(temp,1);

            temp(p1,c,swap(i,2))   = temp(min(t),c,swap(i,2));
            d   (p1,c,swap(i,2)) = length(p1)-1+d(min(t),c,swap(i,2)): -1: d(min(t),c,swap(i,2));

            temp(p2,c,swap(i,2)) = temp(max(t),c,swap(i,2));
            d   (p2,c,swap(i,2)) = d(max(t),c,swap(i,2)) : length(p2)-1+d(max(t),c,swap(i,2));
        end
    end
end

temp2(:,:,1) = temp(:,:,1)  ./ d(:,:,1);
temp2(:,:,2) = temp(:,:,2)  ./ d(:,:,2);
temp3        = sum(temp2,3) ./ ((1 ./ d(:,:,1)) + (1 ./ d(:,:,2)));
temp3(isnan(temp3) == 1) = Z1(isnan(temp3) == 1); %#ok<NASGU>



varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;