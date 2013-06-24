function x = index_image(x)

sw = 0;

b = 100;
cr = 1:b:size(x.cells,2) - b;

if max(max(x.cells)) < 1
    x.index{1} = [];
    x.pixel{1} = [];
else
    x.index{max(max(x.cells))} = [];
    x.pixel{max(max(x.cells))} = [];
end

if sw==1; h = waitbar(0,'Indexing Image'); end
T = length(cr);
cnt = 0;

offset = 0;

for c = cr
    cnt=cnt+1;
    if sw==1; waitbar(cnt/T); end

    cei = c + b - 1;
    if c == cr(end); cei = size(x.cells,2); end

    croplog = x.log(  :,c:cei);
    cropcel = x.cells(:,c:cei);


    R = unique(cropcel);
    R = R(R~=0);

    t = length(R);
    for rcnt = 1:t

        rgn = R(rcnt);
        
        pxls = find(cropcel == rgn);
        x.index{rgn} = [x.index{rgn}; croplog(pxls)];
        x.pixel{rgn} = [x.pixel{rgn}; pxls + offset];
    end

    offset = offset + numel(croplog);
end

    
if sw==1; close(h); pause(0.1); end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'x') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;