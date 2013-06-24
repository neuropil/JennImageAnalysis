function handles = update_manualcount(handles,slice,deleteonly,varargin)

if nargin < 3; deleteonly = 0; end

for i = 1:length(handles.whitedots)
    for j = 1:length(handles.whitedots{i});
        try delete(handles.whitedots{i}(j)); end %#ok<TRYNC>
    end
    handles.whitedots{i} = [];
end

if length(handles.manualcount)<slice || isempty(handles.manualcount{slice}) || deleteonly ==1; return; end

for countid = 1:length(handles.manualcount{slice})
    dotsize = handles.countcolor{countid}(4);
    for i = 1:length(handles.manualcount{slice}{countid})
        handles.whitedots{         countid}(i)   = rectangle('Position',...
            [handles.manualcount{slice}{countid}(i,1)-floor(dotsize/2),...
             handles.manualcount{slice}{countid}(i,2)-floor(dotsize/2),dotsize,dotsize],...
            'Curvature',1,'EdgeColor','none','FaceColor',handles.countcolor{countid}(1:3));
    end
end
