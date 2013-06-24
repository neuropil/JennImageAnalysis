function x = compressids(x)

cnt = 0;
for i = 1:length(x.index)
    if ~isempty(x.index{i})
        cnt = cnt + 1;
        
        x.index{cnt} = x.index{i};
        x.pixel{cnt} = x.pixel{i};
        x.cells(x.pixel{i}) = cnt;
        
        x.index{i} = [];
        x.pixel{i} = [];
    end
end