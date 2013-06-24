function Ir = rotateimage(handles,d)

I  = handles.image;

if isa(I, 'uint8');
    Ir = uint8(zeros(size(I,2),size(I,1),size(I,3)));
elseif isa(I, 'uint16')
    Ir = uint16(zeros(size(I,2),size(I,1),size(I,3)));
end

if d == 1
    rtemp = size(I,1):-1:1;
    ctemp = 1:size(I,2);
else
    rtemp = 1:size(I,1);
    ctemp = size(I,2):-1:1;
end

cnt=0;
for r = rtemp
    cnt=cnt+1;
    for color = 1:size(I,3)
        Ir(ctemp,cnt,color) = I(r,:,color)';
    end
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'Ir') == 0 && strcmp(varnames(vari).name,'output') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;