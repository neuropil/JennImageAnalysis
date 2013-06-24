function [den, thresholdX] = Extract_PixelDensity_ROI(~)

%EXTRACT_DENSITY - extracts data over several days of behavior to track
%percent correct and total correct and percent complete
%
%   user-defined file names such as 'tb_u001_041231a.mat', where 'u001' is
%   a rat id starting from your initial, '041241' is year month day, 'a' is
%   an experimet id for the same day (could be a, b, c,... etc.).
%
%   Users are encouraged to modify the code to match its output file
%   names to match this rule.
%
%   JAT 10/12/2011


[filenames, pathname] = uigetfile( ...
{'*.tif;*.tiff', 'Image Files (*.tif,*.tiff)';...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');

%% Creat ROI selection
red_density = zeros();
green_density = zeros();

thresholdX = Extract_PixelThreshold_Box(filenames, pathname);
thresholdG = mean(thresholdX.green_threshold) + 2*std(thresholdX.green_threshold);
thresholdR = mean(thresholdX.red_threshold) + 2*std(thresholdX.red_threshold);

cd(pathname);

filenames = cellstr(filenames);

for i = 1:length(filenames)
    
    % load image file
    fn = char(filenames{i});
    
    a = imread(fn);
    redpixels = a(:,:,1);
    
    greenpixels = a(:,:,2);
    
    [~, xi, yi] = roipoly(a);
    
    close
    
    polydim = size(a);
    polyx = polydim(1,1);
    polyy = polydim(1,2);
    
    nts_mask = poly2mask(xi,yi,polyx,polyy);
    
    num_Gpxls = greenpixels(nts_mask);
    num_Gpxls2 = numel(num_Gpxls);
    Gpixelindex = find(num_Gpxls > thresholdG);
    
    num_Rpxls = redpixels(nts_mask);
    num_Rpxls2 = numel(num_Rpxls); 
    Rpixelindex = find(num_Rpxls > thresholdR);
    
    red_density(i) = numel(Rpixelindex)/num_Rpxls2;
    green_density(i) = numel(Gpixelindex)/num_Gpxls2;
    
end


den.red_density = red_density;
den.green_density = green_density;

fisave = 'pixel_density.mat';

save(fisave, '-struct', 'den');


% % open a file for writing
% fid = fopen('density.txt', 'w');
% 
% % print a title, followed by a blank line
% fprintf(fid, 'red_density green_density\n\n');
% 
% % print values in column order
% % two values appear on each row of the file
% fprintf(fid, '%f  %f\n', denexcel);
% fclose(fid);
%  
 

