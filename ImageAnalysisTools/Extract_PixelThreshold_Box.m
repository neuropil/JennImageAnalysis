function [thresh] = Extract_PixelThreshold_Box(filenames, pathname)

%EXTRACT_THRESHOLD - extracts threshold of pixel intensity over several
%images and saves vector of threhsolds for red and green RGB channels
%
%   Users must direct function to file folder containing single set of
%   images for threshold analysis; images must be tif file format.
%   
%   Users are encouraged to modify the code to match its output file
%   names to match this rule.
%
%   JAT 11/01/2011

% FILE is CALLED BY extract_density2.m


%% Load and extract

red_threshold = zeros();
green_threshold = zeros();

cd(pathname);

filenames = cellstr(filenames);

for i = 1:length(filenames)
    

    % load image file
    fn = char(filenames{i});
    
    a = imread(fn);
    redpixels = a(:,:,1);
    
    greenpixels = a(:,:,2);
    
    [xx yy] = size(redpixels);
    
    cols = [160 160 10 10];
    rows = [10 160 160 10];
    samplebox = roipoly(xx,yy,cols,rows);
    [Bi,Li] = bwboundaries(samplebox,'noholes');
    boxIndices = cell2mat(Bi);
    
    boximage = imshow(a);
    hold on
    plot(boxIndices(:,1),boxIndices(:,2),'y');
    
    imwrite(boximage, 'newraw.tif','tif');
    
    [~, xi, yi] = roipoly('newraw.tif');
    
    close
    
    polydim = size(a); % Dimensions of image file
    polyx = polydim(1,1); % X dimension of image
    polyy = polydim(1,2); % Y dimension of image
    nts_mask = poly2mask(xi,yi,polyx,polyy);
    
    num_Gpxls = greenpixels(nts_mask);
    sngGpixels = single(num_Gpxls);
    
    num_Rpxls = redpixels(nts_mask);
    sngRpixels = single(num_Rpxls);
    
    red_threshold(i) = mean(sngRpixels);
    green_threshold(i) = mean(sngGpixels);
    
end

thresh.red_threshold = red_threshold;
thresh.green_threshold = green_threshold;


 
fisave = 'pixel_thresholds.mat';
 
save(fisave, '-struct', 'thresh');




