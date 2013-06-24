fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
fprintf('Press Any Key to Continue\n');
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');


figure, imshow('pout.tif');
h = imrect;
BW = createMask(h);
% position = wait(h);




%%

imshow('rice.png');
[BW, xCoords, yCoords] = roipoly();


%%

[B,L,N,A] = bwboundaries(BW);
hold on
plot(xCoords, yCoords, 'y-', 'Linewidth', 2);
plot(xCoords(1), yCoords(1), 'ro');
plot(xCoords(2), yCoords(2), 'bo');

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

v_point1 = xmin + vert_partitions
v_point2 = xmin + vert_partitions*2
% point3 = xmin + vert_partitions*3
% point4 = xmin + vert_partitions*4
% point5 = xmin + vert_partitions*5

h_point1 = ymin + horiz_partitions

v_p1coords = find(B{1,1}(:,2) == floor(v_point1))
v_p2coords = find(B{1,1}(:,2) == floor(v_point2))
% p3coords = find(B{1,1}(:,2) == floor(point3))
% p4coords = find(B{1,1}(:,2) == floor(point4))
% p5coords = find(B{1,1}(:,2) == floor(point5))

h_p1coords = find(B{1,1}(:,1) == floor(h_point1));

plot((B{1,1}(v_p1coords,2)),(B{1,1}(v_p1coords,1)), 'co');
plot((B{1,1}(v_p2coords,2)),(B{1,1}(v_p2coords,1)), 'co');
% plot((B{1,1}(p3coords,2)),(B{1,1}(p3coords,1)), 'co');
% plot((B{1,1}(p4coords,2)),(B{1,1}(p4coords,1)), 'co');
% plot((B{1,1}(p5coords,2)),(B{1,1}(p5coords,1)), 'co');

plot((B{1,1}(h_p1coords,2)),(B{1,1}(h_p1coords,1)), 'co');

%%

line([(B{1,1}(v_p1coords(1),2)) (B{1,1}(v_p1coords(2),2))],[(B{1,1}(v_p1coords(1),1)) (B{1,1}(v_p1coords(2),1))], 'Color','r','LineWidth',2);
line([(B{1,1}(v_p2coords(1),2)) (B{1,1}(v_p2coords(2),2))],[(B{1,1}(v_p2coords(1),1)) (B{1,1}(v_p2coords(2),1))], 'Color','r','LineWidth',2);
% line([(B{1,1}(p3coords(1),2)) (B{1,1}(p3coords(2),2))],[(B{1,1}(p3coords(1),1)) (B{1,1}(p3coords(2),1))], 'Color','r','LineWidth',2);
% line([(B{1,1}(p4coords(1),2)) (B{1,1}(p4coords(2),2))],[(B{1,1}(p4coords(1),1)) (B{1,1}(p4coords(2),1))], 'Color','r','LineWidth',2);
% line([(B{1,1}(p5coords(1),2)) (B{1,1}(p5coords(2),2))],[(B{1,1}(p5coords(1),1)) (B{1,1}(p5coords(2),1))], 'Color','r','LineWidth',2);

%%

line([(B{1,1}(h_p1coords(1),2)) (B{1,1}(h_p1coords(2),2))],[(B{1,1}(h_p1coords(1),1)) (B{1,1}(h_p1coords(2),1))], 'Color','r','LineWidth',2);

%%


message = sprintf('Left-click to draw out a polygon on the entropy-filtered image\nat the upper right of the figure.\nRight click to finish.');
uiwait(msgbox(message));



