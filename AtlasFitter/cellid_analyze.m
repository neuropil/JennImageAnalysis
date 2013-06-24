% output = cellid_analyze(x,h)
% Outputs the statistics of the watershed and local minima at the current
% point in an image. 
%
% To use this function first run the image through CellCounter.  Then
% display the image in a figure, click on the point you would like to
% analyze, and run this function.
%
%
% INPUT PARAMETERS:
% --------------------
%
%   x       This is the output structure from CellCounter
% 
%
% OPTIONAL PARAMETERS:
% --------------------
%
%   h       The handle to the figure you want the graphical output 
%           displayed in.  Not specifying h will cause a new figure to be
%           generated.
%
%
% OUTPUT:
% --------------------
%
%   output  This is a structure contianing the following fields:
%
%           water       the watershid ID you clicked in
%           cell        the ID of the cell in that watershed
%           sizewater   the size of the watershed
%           signal      mean pixel intensity of pixels in the cell
%           background  mean pixel intensity of pixels in the background
%           noise       the standard deviation of the background pixels
%           z           the z-score of the signal given the background
%           d           the difference between the signal and background
%           score       product of z and d
%           t           pixel intensity threshold for defining the cell
%           sizecore    number of pixels in the cell
%           waterlog    matrix displayed in the graphical output
%
%   The graphical output shows a pseudocolor image of the log pixel values.
%   The boundary of the cell is drawn in white and the boundary of the
%   watershed is drawn in black.  If the watershed was discarded it will
%   not be drawn.  If the cell does not meet criteria it will not be drawn
%   and output.cell will be set to 0.
%
% Developed by Charles Kopec 2010
%

function output = cellid_analyze(x,h,varargin)

p = get(gca,'CurrentPoint'); r=round(p(1,2)); c=round(p(1,1));

w = x.water(r,c);
output.water = w;
output.cell  = x.cells(r,c);

temp1 = x.log(x.water == w);
if isempty(temp1); disp(['No watershed for pixel ',num2str(r),',',num2str(c)]); return; end
temp2 = sortrows(temp1,1);

if length(temp2) < x.thresholds.cellpixels; pixelscell = length(temp2);
else                                        pixelscell = x.thresholds.cellpixels;
end

s = mean(temp2(1:pixelscell));
b = mean(temp2(round(length(temp2) * x.thresholds.backpercent):end));
n = std( temp2(round(length(temp2) * x.thresholds.backpercent):end));


output.sizewater  = numel(temp1);
output.signal     = s;
output.background = b;
output.noise      = n;
output.z          = abs(s - b) / n;
output.d          = abs(s - b);
output.score      = output.z * output.d;
output.t          = ((s - b) / 2) + b;

[rs cs] = find(x.water == w & x.log < output.t);
temp3 = zeros(max(rs)-min(rs)+1,max(cs)-min(cs)+1);
for pt = 1:numel(rs)
    temp3(rs(pt)-min(rs)+1,cs(pt)-min(cs)+1) = 1;
end

output.sizecore   = numel(rs);
buf = 3;

[rs1 cs1] = find(x.water == w);
if     min(rs1)-buf < 1;             buf = 0;
elseif max(rs1)+buf > size(x.log,1); buf = 0;
elseif min(cs1)-buf < 1;             buf = 0;
elseif max(cs1)+buf > size(x.log,2); buf = 0;
end
    
temp4 = x.log(min(rs1)-buf:max(rs1)+buf,min(cs1)-buf:max(cs1)+buf);

[rs2 cs2] = find(x.water == w & x.cellCperim == 1);
for pt = 1:numel(rs2)
    temp4(rs2(pt)-min(rs1)+1+buf,cs2(pt)-min(cs1)+1+buf) = 100;
end

[rs3 cs3] = find(x.cellWperim(min(rs1)-buf:max(rs1)+buf,min(cs1)-buf:max(cs1)+buf) == 1);
for pt = 1:numel(rs3)
    temp4(rs3(pt),cs3(pt)) = -100;
end

output.waterlog = temp4;
if nargin < 2
    figure; 
else
    figure(h);
    colorbar('off');
end
imagesc(temp4,[min(temp1)-0.01 max(temp1)+0.01]); 
c = colormap;
c(1,:) = [1 1 1];
c(end,:) = [0 0 0];
colormap(c);
