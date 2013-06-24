function s = test_CellCounter_params(x,I,M,DSP)

for i = 1:length(I)
    temp = CellCounter(I{i},'all',x); 
    if DSP == 2; figure('color','w'); end
    s(i) = compare_cellids(M{i},temp.cellcores,[1 1 1],logical(DSP)); %#ok<AGROW>
    %s{i} = compare_cellids(M{i},temp.cellcores,[1 1 1],logical(DSP),'full'); %#ok<AGROW>
    if logical(DSP) == 1; pause(0.1); end
end
            