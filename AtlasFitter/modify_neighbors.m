function x = modify_neighbors(x)

sw = 0;

x.fuse = [];
if sw==1; h = waitbar(0,'Testing Neighboring Regions'); end
t = numel(x.cellatbound);
for N1 = 1:t
    if sw==1; waitbar(N1/t); end
    
    r1 = x.cellatbound(N1);
    R  = x.conmat{r1};
    
    for N2 = 1:numel(R)
        
        r2 = R(N2);
        
        if r1 == r2;             continue; end
        if r1 >  r2;             continue; end
        
        id = (r1*r2)+(1/(r1+r2));
        [rs cs] = find(x.neighbors == id); %#ok<NASGU>
        if isempty(rs); continue; end
        if numel(rs) < 3; continue; end
        
        bd = x.log(x.neighbors(rs,1));
        temp1 = x.index{r1};
        if isempty(temp1); continue; end
        temp1 = sortrows(temp1,1);

        s1 = mean(temp1(1:round(length(temp1) * 0.1)));
        n1 = std( temp1(1:round(length(temp1) * 0.1)));
        
        temp2 = x.index{r2};
        if isempty(temp2); continue; end
        temp2 = sortrows(temp2,1);

        s2 = mean(temp2(1:round(length(temp2) * 0.1)));
        n2 = std( temp2(1:round(length(temp2) * 0.1)));
        
        if s1 > s2; s = s1; n = n1;
        else        s = s2; n = n2;
        end
        
        bd = sortrows(bd,1);
        sbd = mean(bd(1:3));
        
        z = abs(s - sbd) / n;
        d = abs(s - sbd);
        
        if z*d <= x.thresholds.boundary
            if s1 > s2; x.fuse = [x.fuse; r2 r1 z d z*d]; %r1 fuses into r2 
            else        x.fuse = [x.fuse; r1 r2 z d z*d]; %r2 fuses into r1
            end
        end
        
    end
end

if sw==1; close(h); pause(0.1); end

if ~isempty(x.fuse); x.fuse = sortrows(x.fuse,5); end;

recalc = [];
gone   = [];

if sw==1; h = waitbar(0,'Fusing Select Neighbors'); end
for i = 1:size(x.fuse,1)
    if sw==1; if rem(i,10) == 0; waitbar(i/size(x.fuse,1)); end; end
    
    %r2 fuses into r1
    r1 = x.fuse(i,1);
    r2 = x.fuse(i,2);
    
    if ~isempty(find(gone == r2,1)); continue; end
    if ~isempty(find(gone == r1,1)); continue; end
    
    id = (r1*r2)+(1/(r1+r2));
    [rs cs] = find(x.neighbors == id); %#ok<NASGU>
    
    x.cells(x.pixel{r2}) = r1;
    x.cells(x.neighbors(rs,1)) = r1;
    x.index{r1} = [x.index{r1}; x.log(x.neighbors(rs,1))];
    x.pixel{r1} = [x.pixel{r1}; x.neighbors(rs,1)];
    
    x.pixel{r1} = [x.pixel{r1}; x.pixel{r2}];
    x.index{r1} = [x.index{r1}; x.index{r2}];
    x.pixel{r2} = [];
    x.index{r2} = [];
    
    gone = [gone r2]; %#ok<AGROW>
    recalc = [recalc r1]; %#ok<AGROW>
end
if sw==1; close(h); pause(0.1); end
    
if sw==1; h = waitbar(0,'Recalculating Fused Regions'); end
for i = 1:numel(recalc)
    if sw==1; if rem(i,10) == 0; waitbar(i/numel(recalc)); end; end
    
    r1 = recalc(i);
    
%     if r1 == 2919
%         99
%     end
    
    temp1 = x.index{r1};
    if isempty(temp1); continue; end
    temp2 = sortrows(temp1,1);

    %s = mean(temp2(1:round(length(temp2) * 0.1)));
    if length(temp2) < x.thresholds.cellpixels; pixelscell = length(temp2);
    else                                        pixelscell = x.thresholds.cellpixels;
    end
    
    s = mean(temp2(1:pixelscell));
    
    b = mean(temp2(round(length(temp2) * 0.5):end));
    n = std( temp2(round(length(temp2) * 0.5):end));
    
    x.cellcores(x.pixel{r1}) = 0;
    x.cellnorm( x.pixel{r1}) = 0;

    score = (abs(s - b) / n) * (abs(s - b));
    if score >= x.thresholds.cell
        m = mean(temp2(1:pixelscell));
        t = ((m - b) / 2) + b;
        
        core = x.pixel{r1}(temp1 <= t);
        if numel(core) >= x.thresholds.mincellsize && numel(core) <= x.thresholds.maxcellsize
            x.cellcores(core) = 1;
            bkgrnd = x.pixel{r1}(temp1 > t);
            x.cellnorm(core) = x.log(core) - mean(x.log(bkgrnd));
        else
            x.index{r1} = [];
            x.cells(x.pixel{r1}) = 0;
        end
        
    else
        %disp(['Region ',num2str(r1),' lost cell after fusion with score ',num2str(score)]);
        x.cells(x.pixel{r1}) = 0;
        x.index{r1} = [];
        x.pixel{r1} = [];
    end
    
end
if sw==1; close(h); pause(0.1); end



varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'x') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;