function cntr = centroid(coords)

if sum(coords(end,:) == coords(1,:)) ~= 2; 
    coords(end+1,:) = coords(1,:);
end

temp = 0;
for i=1:size(coords,1)-1
    temp = temp + ((coords(i,1) * coords(i+1,2)) - (coords(i+1,1) * coords(i,2)));
end

A = abs(temp / 2);

tempx = 0;
tempy = 0;
for i=1:size(coords,1)-1
    tempx = tempx + ((coords(i,1) + coords(i+1,1)) * ((coords(i,1) * coords(i+1,2)) - (coords(i+1,1) * coords(i,2))));
    tempy = tempy + ((coords(i,2) + coords(i+1,2)) * ((coords(i,1) * coords(i+1,2)) - (coords(i+1,1) * coords(i,2))));
end

cntr = abs([tempx tempy] / (6 * A));
