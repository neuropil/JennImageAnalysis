function trans = warpfilter3(oldpoints,newpoints,allpoints)

reductionvalue = 2;

oldpoints = oldpoints / reductionvalue;
newpoints = newpoints / reductionvalue;
allpoints = allpoints / reductionvalue;

for temp = 1:size(oldpoints,1)
    Z(temp,:) = newpoints(temp,:)-oldpoints(temp,:); %#ok<AGROW>
end

oldpoints = oldpoints + (rand(size(oldpoints)) * 0.01);

normX = min(allpoints(:,1))-1;
normY = min(allpoints(:,2))-1;

allnorm(:,1) = allpoints(:,1) - normX;
allnorm(:,2) = allpoints(:,2) - normY;
oldnorm(:,1) = oldpoints(:,1) - normX;
oldnorm(:,2) = oldpoints(:,2) - normY;

[X Y] = meshgrid(1:max(allnorm(:,1))+2,1:max(allnorm(:,2))+2);
Z1 = griddata(oldnorm(:,1),oldnorm(:,2),Z(:,1),X,Y);
Z2 = griddata(oldnorm(:,1),oldnorm(:,2),Z(:,2),X,Y);

for i = 1:2
    clear temp;
    if i == 1; temp = Z1;
    else       temp = Z2;
    end
    
    c1 = NaN(size(temp,1),1);
    c2 = c1;
    c3 = NaN(size(temp,2),1);
    c4 = c3;
    maxr = size(temp,1);
    maxc = size(temp,2);
    for r = 1:maxr
        t = find(isnan(temp(r,:)) == 0);
        if ~isempty(t)
            c1(r) = min(t)-1;
            c2(r) = max(t)+1;
        end
    end
    for c = 1:maxc
        t = find(isnan(temp(:,c)) == 0);
        if ~isempty(t)
            c3(c) = min(t)-1;
            c4(c) = max(t)+1;
        end
    end

    nangone = 0;
    while nangone == 0
        for r = 1:maxr
            if c1(r) > 0
                temp(r,c1(r)) = temp(r,c1(r)+1);
                if c3(c1(r)) >= r
                    c3(c1(r)) = r - 1;
                end
                if c4(c1(r)) <= r
                    c4(c1(r)) = r + 1;
                end
                if isnan(c3(c1(r)))
                    c3(c1(r)) = r - 1;
                    c4(c1(r)) = r + 1;
                end
                c1(r) = c1(r) - 1;
            end
            if c2(r) <= maxc
                temp(r,c2(r)) = temp(r,c2(r)-1);
                if c3(c2(r)) >= r
                    c3(c2(r)) = r - 1;
                end
                if c4(c2(r)) <= r
                    c4(c2(r)) = r + 1;
                end
                if isnan(c3(c2(r)))
                    c3(c2(r)) = r - 1;
                    c4(c2(r)) = r + 1;
                end
                c2(r) = c2(r) + 1;
            end
        end
        for c = 1:maxc
            if c3(c) > 0
                temp(c3(c),c) = temp(c3(c)+1,c);
                if c1(c3(c)) >= c
                    c1(c3(c)) = c - 1;
                end
                if c2(c3(c)) <= c
                    c2(c3(c)) = c + 1;
                end
                if isnan(c1(c3(c)))
                    c1(c3(c)) = c - 1;
                    c2(c3(c)) = c + 1;
                end
                c3(c) = c3(c) - 1;
            end
            if c4(c) <= maxr
                temp(c4(c),c) = temp(c4(c)-1,c);
                if c1(c4(c)) >= c
                    c1(c4(c)) = c - 1;
                end
                if c2(c4(c)) <= c
                    c2(c4(c)) = c + 1;
                end
                if isnan(c1(c4(c)))
                    c1(c4(c)) = c - 1;
                    c2(c4(c)) = c + 1;
                end
                c4(c) = c4(c) + 1;
            end
        end
        
        if sum(c1) == 0 && sum(c3) == 0
            if sum(c2 < maxc) == 0 && sum(c4 < maxr) == 0
                nangone = 1;
            end
        end
            
    end
    if i == 1; temp1 = temp; 
    else       temp2 = temp;
    end
end

trans      = zeros(size(allnorm));
for p = 1:size(allnorm,1)
    trans(p,1) = temp1(ceil(allnorm(p,2)),ceil(allnorm(p,1)));
    trans(p,2) = temp2(ceil(allnorm(p,2)),ceil(allnorm(p,1)));
end

trans = trans * reductionvalue;

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'trans') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


