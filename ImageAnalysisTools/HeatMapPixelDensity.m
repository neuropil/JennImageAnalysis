function [Gtest,bluepixels,maskIndices,fileName,pathname] = HeatMapPixelDensity()


[fileName, pathname] = uigetfile( ...
{'*.tif;*.tiff', 'Image Files (*.tif,*.tiff)';...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'off');

cd(pathname);

a = imread(fileName);

load pixel_thresholds.mat

%% Creat ROI selection

% Create matrix variable for red pixels
redpixels = a(:,:,1); 
% Create matrix variable for green pixels
greenpixels = a(:,:,2);
% Create matrix variable for blue pixels
bluepixels = a(:,:,3);

% Initalize interface to trace Region Of Interest (roi)
[~, xi, yi] = roipoly(fileName); 

%% Plot image and ROI
close
% Assign Region Of Interest values with new variable
nts_boundary = roipoly(a,xi,yi);
% Create Stock rgb file for image of interest
rgb = imread(fileName);
% Convert rgb image to grayscale for later use
grgb = rgb2gray(rgb);

%% Image Analysis

% Get single image dimensions
polydim = size(a); % Dimensions of image file
polyx = polydim(1,1); % X dimension of image
polyy = polydim(1,2); % Y dimension of image

% Create NTS mask
nts_mask = poly2mask(xi,yi,polyx,polyy);  

% Extract location/position information from nts mask
[boundary_coordinates,logic_boundary_matrix] = bwboundaries(nts_boundary,'noholes');
maskIndices = cell2mat(boundary_coordinates);

%% Extract Density based on Threshold



prompt = {'Enter # of Standard Deviations'};
dlg_title = 'Input # Std. Dev.';
num_lines = 1;
def = {'3'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

std_dev = str2double(answer);

%% Get green pixels
% pixth = load('pixel_thresholds.mat');
% Extracts a vector of green pixels within nts mask
num_Gpxls = greenpixels(nts_mask);
% Obtains total number of green pixels within nts mask
num_Gpxls2 = numel(num_Gpxls);
% Converts vector of green pixels from unit8 to single data type for
% statistical analysis
sngGpixels = single(num_Gpxls);
% Creates Threshold value for green pixels 
% thresholdG = mean(sngGpixels) + 2*std(sngGpixels);

thresholdG = mean(green_threshold) + std_dev*std(green_threshold);

% Finds maximal pixel intensity value to determine the upper bound
maxGpixel = max(sngGpixels);
% Creates a vector of pixels
Gpixelindex = find(num_Gpxls > thresholdG); 
Gpixel_hist = num_Gpxls(Gpixelindex);
Gpixden = numel(Gpixelindex)/num_Gpxls2;


%% Histogram Kernel Density Estimate for Green Pixels in Boundary
% histo_compare = figure('Color','white','Toolbar','none',...
%      'Position',[300 300 900 500]);
%  
% xhistAxe = 0:5:255;
% 
% subplot(1,2,1);
% hist(num_Gpxls,xhistAxe);
% hold on;
% hist(Gpixel_hist,xhistAxe);
% axis([0 255 0 100000])
% h = findobj(gca,'Type','patch');
% display(h)
% 
% set(h(1),'FaceColor','g','EdgeColor','k');
% set(h(2),'FaceColor','k','EdgeColor','k');
% alpha(0.5);
% ylabel('Count');
% xlabel('Pixel Intensity');
% legend('Before Threshold','After Threshold')
% 
% Gbgpixels2double = double(Gpixel_hist);
% Gnumpixels2double = double(num_Gpxls);
% 
% subplot(1,2,2);
% [f1,x1,u] = ksdensity(Gnumpixels2double);
% plot(x1,f1,'k','LineWidth',3)
% title('Density estimate pixel intensity')
% hold on
% [f2,x2] = ksdensity(Gbgpixels2double);
% plot(x2,f2,'r','LineWidth',3);
% ylabel('Density');
% xlabel('Pixel Intensity');
% ylim([0 0.1]);
% legend('Before Threshold','After Threshold')
% hold off


%% Get red pixels

% Extracts a vector of red pixels from within nts mask
num_Rpxls = redpixels(nts_mask);

num_Rpxls2 = numel(num_Rpxls);

sngRpixels = single(num_Rpxls);

% thresholdR = mean(sngRpixels) + 2*std(sngRpixels);

thresholdR = mean(red_threshold) + std_dev*std(red_threshold);


maxRpixel = max(sngRpixels);

Rpixelindex = find(num_Rpxls > thresholdR); 

Rpixden = numel(Rpixelindex)/num_Rpxls2;

Rpixel_hist = num_Rpxls(Rpixelindex);

%% Histogram Kernel Density Estimate for Red Pixels in Boundary

% histo_compare2 = figure('Color','white','Toolbar','none',...
%      'Position',[300 300 900 500]);
%  
% subplot(1,2,1);
% hist(num_Rpxls,xhistAxe);
% hold on;
% hist(Rpixel_hist,xhistAxe);
% axis([0 255 0 100000]);
% h8 = findobj(gca,'Type','patch');
% display(h8);
% 
% set(h8(1),'FaceColor','r','EdgeColor','k');
% set(h8(2),'FaceColor','k','EdgeColor','k');
% alpha(0.5);
% ylabel('Count');
% xlabel('Pixel Intensity');
% legend('Before Threshold','After Threshold');
% 
% Rbgpixels2double = double(Rpixel_hist);
% Rnumpixels2double = double(num_Rpxls);
% 
% subplot(1,2,2);
% [f3,x3,u] = ksdensity(Rnumpixels2double);
% plot(x3,f3,'k','LineWidth',3);
% title('Density estimate pixel intensity');
% hold on;
% [f4,x4] = ksdensity(Rbgpixels2double);
% plot(x4,f4,'r','LineWidth',3);
% ylabel('Density');
% xlabel('Pixel Intensity');
% ylim([0 0.1]);
% legend('Before Threshold','After Threshold');
% hold off;


%% Create grid in mask and calculate red intensity

% Calculate red intensity mask & density
red_pixel_intensity = roicolor(redpixels,thresholdR,maxRpixel);

% figure,imshow(redpixels)
% figure,imshow(red_pixel_intensity) 

[Rintsity_threshold_coordinates,Rintensity_mask_matrix] = bwboundaries(red_pixel_intensity,'noholes');

find_red_pixels_above = find(Rintensity_mask_matrix > 0);
numSupra_thresh_red = numel(find_red_pixels_above);


%% Calculate grid in green intensity

% Calculate green intensity mask & density
green_pixel_intensity = roicolor(greenpixels,thresholdG,maxGpixel);

% figure,imshow(greenpixels)
% figure,imshow(green_pixel_intensity) 

[Gintsity_threshold_coordinates,Gintensity_mask_matrix] = bwboundaries(green_pixel_intensity,'noholes');

find_green_pixels_above = find(Gintensity_mask_matrix > 0);
numSupra_thresh_green = numel(find_green_pixels_above);


%% Plot boundaries of Threshold regions

GIndicies = cell2mat(Gintsity_threshold_coordinates);
RIndicies = cell2mat(Rintsity_threshold_coordinates);

%% Figure out how to get pixel data for heat map

Gintensity_mask_matrix(find(Gintensity_mask_matrix > 0)) = 1; 

STATSgp = regionprops(Gintensity_mask_matrix, greenpixels, 'MeanIntensity','MaxIntensity','MinIntensity','PixelValues','PixelList');

gpixelplot = STATSgp.PixelList;
gpixelplotVal = STATSgp.PixelValues;

Rintensity_mask_matrix(find(Rintensity_mask_matrix > 0)) = 1;

STATSrp = regionprops(Rintensity_mask_matrix, redpixels, 'MeanIntensity','MaxIntensity','MinIntensity','PixelValues','PixelList');

rpixelplot = STATSrp.PixelList;
rpixelplotVal = STATSrp.PixelValues;



%% Experimental

Rheat = zeros(size(Rintensity_mask_matrix));
% 1050 rows % 1398 cols

for i = 1:length(rpixelplotVal);
    Rheat(rpixelplot(i,2),rpixelplot(i,1)) = rpixelplotVal(i);
    %for x = 1:length(rpixelplotVal);
end



Gheat = zeros(size(Gintensity_mask_matrix));
for j = 1:length(gpixelplotVal);
    Gheat(gpixelplot(j,2),gpixelplot(j,1)) = gpixelplotVal(j);
    %for x = 1:length(rpixelplotVal);
end

[Rrows, Rcols] = size(Rheat);

Rtest = zeros(size(Rheat));
for xxi = 1:Rrows
    for xxj = 1:Rcols
        if Rheat(xxi, xxj) > 0 && nts_mask(xxi, xxj) == 1;
            Rtest(xxi, xxj) = Rheat(xxi, xxj);
        else
            Rtest(xxi, xxj) = 0;
        end
    end
end

[Grows, Gcols] = size(Gheat);

Gtest = zeros(size(Gheat));
for xxi = 1:Grows
    for xxj = 1:Gcols
        if Gheat(xxi, xxj) > 0 && nts_mask(xxi, xxj) == 1;
            Gtest(xxi, xxj) = Gheat(xxi, xxj);
        else
            Gtest(xxi, xxj) = 0;
        end
    end
end




% newbimage = sum(255 - bluepixels, 3);
% newbimage = uint8(newbimage);
% imshow(newbimage)



Rtest = uint8(Rtest);
Gtest = uint8(Gtest);

% figure;
% % imshow(blueonly);
% % hold on
% h1 = image(Gtest,'CDataMapping','scaled'); 
% colormap(jet(256));
% % alpha_data3 = (Rintensity_mask_matrix);
% set(h1, 'AlphaData', bluepixels);
% colorbar
% hold on
% plot(maskIndices(:,2),maskIndices(:,1),'k');
% 
% figure;
% % imshow(blueonly);
% % hold on
% h1 = image(Gheat,'CDataMapping','scaled'); 
% colormap(jet(256));
% alpha_data4 = (Gintensity_mask_matrix);
% set(h1, 'AlphaData', Gintensity_mask_matrix);
% colorbar
% % hold on
% % plot(maskIndices(:,2),maskIndices(:,1),'k');






            