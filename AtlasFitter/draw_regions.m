function regions = draw_regions(regions,trans,redraw,varargin)

if nargin == 1
    trans = zeros(1,2);
    redraw = 1;
end
if nargin == 2
    redraw = 1;
end

points = getregionpoints(regions);
if size(points,1) ~= size(trans,1)
    transtemp      = zeros(size(points));
    transtemp(:,1) = trans(1,1);
    transtemp(:,2) = trans(1,2);
    trans          = transtemp;
end

cnt_t = 0;
for r = 1:length(regions)
    
    xi = zeros(size(regions{r}{2},1),1);
    yi = zeros(size(regions{r}{2},1),1);
    
    for p = 1:size(regions{r}{2},1)
        cnt_t = cnt_t + 1;
        xi(p) = regions{r}{2}(p,1) + trans(cnt_t,1);
        yi(p) = regions{r}{2}(p,2) + trans(cnt_t,2);
    end
    
    xcenter = mean([max(xi) min(xi)]);
    ycenter = mean([max(yi) min(yi)]);
    
    regions{r}{3} = []; 
    regions{r}{4} = [];
    regions{r}{5} = [];
    
    if redraw == 1
        hpoints = zeros(length(xi),1);
        for p = 1:length(xi)
            hpoint = rectangle('Position',[xi(p)-10,yi(p)-10,20,20],...
                    'Curvature',1,'EdgeColor','r','LineWidth',2);
            hpoints(p) = hpoint; 
        end

        hpatch = line(xi,yi,'Color',[1 0 0],'LineWidth',2);
        htext  = text(xcenter,ycenter,regions{r}{1});
        
        regions{r}{3} = hpoints; 
        regions{r}{4} = hpatch;
        regions{r}{5} = htext;   
    end
    
    regions{r}{2} = [xi yi];
    regions{r}{6} = [xcenter ycenter];
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'regions') == 0; clear(varnames(vari).name); end
end
clear vari varnames;