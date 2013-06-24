function compile_atlas_traces(first,last,x)

disp('Load Atlas');
[f p] = uigetfile; load([p f]); atlas = regions; %#ok<NODEF>

cnt=0;
for i = first:last
    cnt=cnt+1;
    load(['D:\Brody Lab\RBA\RBA_0',num2str(i),'_trace.mat']);
    for j = 1:length(regions)
        regions{j}{7} = x(cnt,:); %#ok<AGROW>
    end
    atlas{i} = regions;
end

regions = atlas; %#ok<NASGU>

disp('Save Atlas');
[f p] = uiputfile; save([p f],'regions');
    