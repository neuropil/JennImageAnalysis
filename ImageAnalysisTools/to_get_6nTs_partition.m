

figure, imshow('pout.tif');
h = imrect;
BW = createMask(h);



%%

imshow('rice.png');
[BW xCoords yCoords] = roipoly();


%%

[B,L,N,A] = bwboundaries(BW);
hold on
% plot(xCoords, yCoords, 'y-', 'Linewidth', 2);
% plot(xCoords(1), yCoords(1), 'ro');
% plot(xCoords(2), yCoords(2), 'bo');

%%

plot((B{1,1}(:,2)),(B{1,1}(:,1)), 'k-', 'Linewidth', 3);

xmin = min(xCoords);
xmax = max(xCoords);
ymin = min(yCoords);
ymax = max(yCoords);

width = xmax - xmin;
height = ymax - ymin;

%%

vert_partitions = width/3; % Number of vertical partitions
horiz_partitions = height/2; % Number of horizontal paritions

%%

v_point1 = xmin + vert_partitions;
v_point2 = xmin + vert_partitions*2;


h_point1 = ymin + horiz_partitions;

v_p1coords = find(B{1,1}(:,2) == floor(v_point1));
v_p2coords = find(B{1,1}(:,2) == floor(v_point2));

h_p1coords = find(B{1,1}(:,1) == floor(h_point1));

%%

plot((B{1,1}(v_p1coords,2)),(B{1,1}(v_p1coords,1)), 'co');

plot(v_point1,h_point1,'co');



plot((B{1,1}(v_p2coords,2)),(B{1,1}(v_p2coords,1)), 'co');

plot(v_point2,h_point1,'co');


plot((B{1,1}(h_p1coords,2)),(B{1,1}(h_p1coords,1)), 'co');

%%

line([(B{1,1}(v_p1coords(1),2)) (B{1,1}(v_p1coords(2),2))],[(B{1,1}(v_p1coords(1),1)) (B{1,1}(v_p1coords(2),1))], 'Color','r','LineWidth',2);
line([(B{1,1}(v_p2coords(1),2)) (B{1,1}(v_p2coords(2),2))],[(B{1,1}(v_p2coords(1),1)) (B{1,1}(v_p2coords(2),1))], 'Color','r','LineWidth',2);


%%

line([min(B{1,1}(h_p1coords,2)) max(B{1,1}(h_p1coords,2))],[(B{1,1}(h_p1coords(1),1)) (B{1,1}(h_p1coords(2),1))], 'Color','r','LineWidth',2);

%% Quadrant 1

q1_coord1 = [(B{1,1}(v_p1coords(1),2));(B{1,1}(v_p1coords(1),1))];
q1_coord2 = [v_point1;h_point1];
q1_coord3 = [min(B{1,1}(h_p1coords,2));h_point1];

quadrant_1_Xcoords = [q1_coord1(1);q1_coord2(1);q1_coord3(1)];
quadrant_1_Ycoords = [q1_coord1(2);q1_coord2(2);q1_coord3(2)];

q1_ytest = yCoords < quadrant_1_Ycoords(3) & yCoords > quadrant_1_Ycoords(1);
q1_xtest = (xCoords > quadrant_1_Xcoords(3) | xCoords < quadrant_1_Xcoords(3)) & xCoords < quadrant_1_Xcoords(1);

%%
Quad1_coord_indices = false(length(q1_ytest),1);
for q1i = 1:length(q1_ytest)
    if q1_ytest(q1i) == 1  && q1_xtest(q1i) == 1;
        Quad1_coord_indices(q1i) = 1;
    else
        Quad1_coord_indices(q1i) = 0;
    end
end

Quad1_coord_indices = find(Quad1_coord_indices == 1);

%%

[q1r, q1c] = size(quadrant_1_Xcoords);

for q1i2 = 1:length(Quad1_coord_indices)
    quadrant_1_Xcoords(q1r + q1i2) = xCoords(Quad1_coord_indices(q1i2));
    quadrant_1_Ycoords(q1r + q1i2) = yCoords(Quad1_coord_indices(q1i2));
end

quadrant_1_Xcoords(end + 1) = quadrant_1_Xcoords(1);
quadrant_1_Ycoords(end + 1) = quadrant_1_Ycoords(1);

quad_1 = [quadrant_1_Xcoords quadrant_1_Ycoords];


%%

h = impoly(gca, quad_1);

%% Quadrant 2


q2_coord1 = [min(B{1,1}(h_p1coords,2));h_point1];
q2_coord2 = [v_point1;h_point1];
q2_coord3 = [v_point1;max(B{1,1}(v_p1coords,1))];

quadrant_2_Xcoords = [q2_coord1(1);q2_coord2(1);q2_coord3(1)];
quadrant_2_Ycoords = [q2_coord1(2);q2_coord2(2);q2_coord3(2)];

q2_ytest = yCoords > quadrant_1_Ycoords(2);
q2_xtest = xCoords < quadrant_1_Xcoords(2);


%%
Quad2_coord_indices = false(length(q2_ytest),1);
for q2i = 1:length(q2_ytest)
    if q2_ytest(q2i) == 1  && q2_xtest(q2i) == 1;
        Quad2_coord_indices(q2i) = 1;
    else
        Quad2_coord_indices(q2i) = 0;
    end
end

Quad2_coord_indices = find(Quad2_coord_indices == 1);


%%

[q2r, q2c] = size(quadrant_2_Xcoords);

for q2i2 = 1:length(Quad2_coord_indices)
    quadrant_2_Xcoords(q2r + q2i2) = xCoords(Quad2_coord_indices(q2i2));
    quadrant_2_Ycoords(q2r + q2i2) = yCoords(Quad2_coord_indices(q2i2));
end

quadrant_2_Xcoords(end + 1) = quadrant_2_Xcoords(1);
quadrant_2_Ycoords(end + 1) = quadrant_2_Ycoords(1);

quad_2 = [quadrant_2_Xcoords quadrant_2_Ycoords];

%%

h2 = impoly(gca, quad_2);

%% Quadrant 3

q3_coord1 = [(B{1,1}(v_p1coords(1),2));(B{1,1}(v_p1coords(1),1))];
q3_coord2 = [v_point1;h_point1];
q3_coord3 = [v_point2;h_point1];
q3_coord4 = [(B{1,1}(v_p2coords(1),2));(B{1,1}(v_p2coords(1),1))];

quadrant_3_Xcoords = [q3_coord1(1);q3_coord2(1);q3_coord3(1);q3_coord4(1)];
quadrant_3_Ycoords = [q3_coord1(2);q3_coord2(2);q3_coord3(2);q3_coord4(2)];

q3_ytest = yCoords < quadrant_3_Ycoords(1) | yCoords < quadrant_3_Ycoords(4);
q3_xtest = xCoords > quadrant_3_Xcoords(2) & xCoords < quadrant_3_Xcoords(3);

%%

Quad3_coord_indices = false(length(q3_ytest),1);
for q3i = 1:length(q3_ytest)
    if q3_ytest(q3i) == 1  && q3_xtest(q3i) == 1;
        Quad3_coord_indices(q3i) = 1;
    else
        Quad3_coord_indices(q3i) = 0;
    end
end

Quad3_coord_indices = find(Quad3_coord_indices == 1);

%%
[q3r, q3c] = size(quadrant_3_Xcoords);

for q3i2 = 1:length(Quad3_coord_indices)
    quadrant_3_Xcoords(q3r + q3i2) = xCoords(Quad3_coord_indices(q3i2));
    quadrant_3_Ycoords(q3r + q3i2) = yCoords(Quad3_coord_indices(q3i2));
end

quadrant_3_Xcoords(end + 1) = quadrant_3_Xcoords(1);
quadrant_3_Ycoords(end + 1) = quadrant_3_Ycoords(1);

quad_3 = [quadrant_3_Xcoords quadrant_3_Ycoords];

%%
h3 = impoly(gca, quad_3);

%% Quadrant 4

q4_coord1 = [(B{1,1}(v_p1coords(2),2));(B{1,1}(v_p2coords(2),1))]; %92 177
q4_coord2 = [v_point1;h_point1];
q4_coord3 = [v_point2;h_point1];
q4_coord4 = [(B{1,1}(v_p2coords(1),2));(B{1,1}(v_p2coords(2),1))];

quadrant_4_Xcoords = [q4_coord1(1);q4_coord2(1);q4_coord3(1);q4_coord4(1)];
quadrant_4_Ycoords = [q4_coord1(2);q4_coord2(2);q4_coord3(2);q4_coord4(2)];

q4_ytest = yCoords > quadrant_4_Ycoords(1) | yCoords > quadrant_4_Ycoords(4);
q4_xtest = xCoords > quadrant_4_Xcoords(2) & xCoords < quadrant_4_Xcoords(3);

%%

Quad4_coord_indices = false(length(q4_ytest),1);
for q4i = 1:length(q4_ytest)
    if q4_ytest(q4i) == 1  && q4_xtest(q4i) == 1;
        Quad4_coord_indices(q4i) = 1;
    else
        Quad4_coord_indices(q4i) = 0;
    end
end

Quad4_coord_indices = find(Quad4_coord_indices == 1);

%%
[q4r, q4c] = size(quadrant_4_Xcoords);

for q4i2 = 1:length(Quad4_coord_indices)
    quadrant_4_Xcoords(q4r + q4i2) = xCoords(Quad4_coord_indices(q4i2));
    quadrant_4_Ycoords(q4r + q4i2) = yCoords(Quad4_coord_indices(q4i2));
end

quadrant_4_Xcoords(end + 1) = quadrant_4_Xcoords(1);
quadrant_4_Ycoords(end + 1) = quadrant_4_Ycoords(1);

quad_4 = [quadrant_4_Xcoords quadrant_4_Ycoords];

%%

h4 = impoly(gca, quad_4);

%%

q5_coord1 = [(B{1,1}(v_p2coords(1),2));(B{1,1}(v_p2coords(1),1))]; %92 177
q5_coord2 = [v_point2;h_point1];
q5_coord3 = [(B{1,1}(h_p1coords(1),2));(B{1,1}(h_p1coords(1),1))]; % 217 110

quadrant_5_Xcoords = [q5_coord1(1);q5_coord2(1);q5_coord3(1)];
quadrant_5_Ycoords = [q5_coord1(2);q5_coord2(2);q5_coord3(2)];

q5_ytest = yCoords < quadrant_5_Ycoords(2);
q5_xtest = xCoords > quadrant_5_Xcoords(2);

%%

Quad5_coord_indices = false(length(q5_ytest),1);
for q5i = 1:length(q5_ytest)
    if q5_ytest(q5i) == 1  && q5_xtest(q5i) == 1;
        Quad5_coord_indices(q5i) = 1;
    else
        Quad5_coord_indices(q5i) = 0;
    end
end

Quad5_coord_indices = find(Quad5_coord_indices == 1);

%%
[q5r, q5c] = size(quadrant_5_Xcoords);

for q5i2 = 1:length(Quad5_coord_indices)
    quadrant_5_Xcoords(q4r + q4i2) = xCoords(Quad4_coord_indices(q4i2));
    quadrant_5_Ycoords(q4r + q4i2) = yCoords(Quad4_coord_indices(q4i2));
end

quadrant_4_Xcoords(end + 1) = quadrant_4_Xcoords(1);
quadrant_4_Ycoords(end + 1) = quadrant_4_Ycoords(1);

quad_4 = [quadrant_4_Xcoords quadrant_4_Ycoords];


















message = sprintf('Left-click to draw out a polygon on the entropy-filtered image\nat the upper right of the figure.\nRight click to finish.');
uiwait(msgbox(message));



