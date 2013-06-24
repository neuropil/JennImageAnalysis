function x = cellid(x)          

sw = 0;

mxcell = max(max(x.cells));

if sw==1; h = waitbar(0,'First Pass: Finding Cells'); end
for id = 1:mxcell
    if sw==1; if rem(id,100)==0; waitbar(id/mxcell); end; end
    
    temp1 = x.index{id};
    if isempty(temp1); continue; end
    temp2 = sortrows(temp1,1);

    if length(temp2) < x.thresholds.cellpixels; pixelscell = length(temp2);
    else                                        pixelscell = x.thresholds.cellpixels;
    end
    
    s = mean(temp2(1:pixelscell));
    
    b = mean(temp2(round(length(temp2) * x.thresholds.backpercent):end));
    n = std( temp2(round(length(temp2) * x.thresholds.backpercent):end));

    if (abs(s - b) / n) * (abs(s - b)) >= x.thresholds.cell
        m = mean(temp2(1:pixelscell));
        t = ((m - b) / 2) + b;
        
        core = x.pixel{id}(temp1 <= t);
        
        if numel(core) >= x.thresholds.mincellsize && numel(core) <= x.thresholds.maxcellsize
            x.cellcores(core) = 1;
            bkgrnd = x.pixel{id}(temp1 > t);
            x.cellnorm(core) = x.log(core) - mean(x.log(bkgrnd));
        else
            x.cells(x.pixel{id}) = 0;
            x.index{id} = [];
            x.pixel{id} = [];
            
        end
    else
        x.cells(x.pixel{id}) = 0;
        x.index{id} = [];
        x.pixel{id} = [];
        
    end

end
if sw==1; close(h); end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'x') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;










