function I = userregion_ignore(I,handles)

mask = zeros(size(I,1),size(I,2));
for ur = 1:length(handles.userregion{handles.i})
    if ~isempty(handles.userregion{handles.i}{ur})
        xi = handles.userregion{handles.i}{ur}(:,1);
        yi = handles.userregion{handles.i}{ur}(:,2);
        mask = mask + roipoly(I,xi,yi);
    end
end

mask(mask > 1) = 1;

I(mask == 1) = 0;