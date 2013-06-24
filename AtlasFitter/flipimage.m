function If = flipimage(handles,d)

I  = handles.image;

if isa(I, 'uint8');
    If = uint8(zeros(size(I)));
elseif isa(I, 'uint16')
    If = uint16(zeros(size(I)));
end

rows = size(I,1);
cols = size(I,2);

if strcmp(d,'horz')
    for col = 1:cols
        for color = 1:size(I,3)
            If(:,col,color) = I(:,cols-col+1,color);
        end
    end
else
    for row = 1:rows
        for color = 1:size(I,3)
            If(row,:,color) = I(rows-row+1,:,color);
        end
    end
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'If') == 0; clear(varnames(vari).name); end
end
clear vari varnames;

