% output = gradient_find_parameters(mask)
% Runs a gradient ascent to find the optimum parameter values for
% CellCounter to find cells in a test set of images.
%
% The way this function is currently written the user must enter the paths
% for the image files and the paths for the binary matrixes containing the
% manually identified cells in the code.  The binary matrixes must have the
% same number of rows and columns as the image files.  Pixels with value 1
% are those the user thinks belongs to cells.  The binary matrixes must be
% saved under the variable name manualcells.
%
% Other parameter values relevant for the gradient ascent can be modified
% from the code directly. 
% 
%
% OPTIONAL PARAMETERS:
% --------------------
%
%   mask            a binary matrix. Watersheds from CellCounter that
%                   overlap with pixels of value 1 will be excluded from 
%                   analysis
%
% OUTPUT:
% --------------------
%
%   output          a strcuture containing the collowing fields:
%
%           params  the best set of parameters found
%
%           score   the score of that set of parameters on each of the test
%                   images
%
% Developed by Charles Kopec 2010
%


function output = gradient_find_parameters(mask,varargin)

%Define the range over which you want to search the parameter space

%Use this set for Watershed algorithm
range(1,:) = [10   150]; %min water size
range(2,:) = [0.01 0.3]; %cell threshold
range(3,:) = [3     30]; %min cell size
range(4,:) = [100 1000]; %max cell size
range(5,:) = [0   0.01]; %boundary threshold
range(6,:) = [3     15]; %blur size
range(7,:) = [0     10]; %blur spread
range(8,:) = [3     30]; %pixels for cell signal
range(9,:) = [0.1  0.6]; %percent pixels for background
range(10,:)= [1      1]; %1 for bright cells on dark background, 0 for opposite
range(11,:)= [1      1]; %1 to exclude regions near edges
fitparams = 1:9;

%Use this set for SizeIntensity Algorithm
% range(1,:) = [0      0]; %min water size
% range(2,:) = [0    255]; %cell threshold
% range(3,:) = [1     30]; %min cell size
% range(4,:) = [100 1000]; %max cell size
% fitparams = 2:4;

%generate a random seed for parameters
for p = 1:size(range,1)
    params(p) = (rand(1) * (range(p,2) - range(p,1))) + range(p,1); %#ok<AGROW>
    if sum([1,3,4,6,8]==p)>0 
        params(p) = round(params(p)); %#ok<AGROW>
    end
end

%These are the files that contain binary matrixes manually identifying cells
load('D:\Brody Lab\Human Cell ID Benchmarks\Sergei_1_ck.mat'); M{1} = manualcells;
load('D:\Brody Lab\Human Cell ID Benchmarks\Sergei_2_ck.mat'); M{2} = manualcells;
load('D:\Brody Lab\Human Cell ID Benchmarks\Sergei_3_ck.mat'); M{3} = manualcells;
load('D:\Brody Lab\Human Cell ID Benchmarks\Sergei_4_ck.mat'); M{4} = manualcells;

%These are the original image files the above files correspond to
I{1} = imread('D:\Brody Lab\ratter\Histology_Analysis\Benchmarks\Sergei_1.tif');
I{2} = imread('D:\Brody Lab\ratter\Histology_Analysis\Benchmarks\Sergei_2.tif');
I{3} = imread('D:\Brody Lab\ratter\Histology_Analysis\Benchmarks\Sergei_3.tif');
I{4} = imread('D:\Brody Lab\ratter\Histology_Analysis\Benchmarks\Sergei_4.tif');

n = 20; %the number of tests to perform per iteration
ntests = 200; %the maximum number of iterations to perform

%as iterations go by, the range over which each parameter is search is reduced 
%by this fraction.
spread = 1:-0.95/(ntests-1):0.05; 
scores = [];

%loop through the iterations
for i = 1:ntests
    disp(['Test ',num2str(i), ' of ',num2str(ntests)]);
    disp(params);
    p = fitparams(ceil(rand(1) * numel(fitparams)));
    disp(['Testing paramter ',num2str(p)]);
    
    %determine the range over which the parameter will be searched then
    %generate a random set of values within that range
    pr = ((range(p,2) - range(p,1)) * spread(i)) / 2;
    pmax = params(p) + pr; 
    pmin = params(p) - pr; 
    if pmax > range(p,2); pmin = pmin - (pmax - range(p,2)); end
    if pmin < range(p,1); pmax = pmax + (range(p,1) - pmin); end
    if pmax > range(p,2); pmax = range(p,2); end
    if pmin < range(p,1); pmin = range(p,1); end
    v = (rand(n,1) * (pmax - pmin)) + pmin;
    v(1) = params(p);
    ntemp = n;
    
    %these parameters must be integers and are modified accordingly
    if sum([1,3,4,6,8]==p)>0; 
        pmax = round(pmax); pmin = round(pmin);
        if pmax - pmin <= n; v = pmin:pmax; ntemp = pmax - pmin + 1;
        else                 v = round(v);
        end
    end
    
    %loop through each parameter value from the random set above and test
    %the fit between what CellCounter returns and what you manually
    %identified
    s = zeros(4,ntemp); 
    for j = 1:ntemp
        x.thresholds = params;
        x.thresholds(p) = v(j);
        
        %if you supplied a mask for the image it is added in here.
        if nargin > 0; x.mask = mask; end
        try %#ok<TRYNC>
            %this runs the comparison on all of the images
            s(:,j) = test_CellCounter_params(x,I,M,0); %use this line for cell counter
            
            %use this for a basic size intensity cell identification algorithm
            %s(:,j) = test_sizeintensity_params(x,I,M,0);
        end
        clear x;
    end
    %the score used for a particular set of parameters is the produce of
    %the scores for that parameter set for each image in the test set
    s = prod(s);
    
    %find the best parameter value
    best = find(s == max(s));
    if length(best) > 1
        temp = randperm(length(best));
        best = best(temp(1));
    end
    
    scores = [scores s(best)]; %#ok<AGROW>
    
    params(p) = v(best);
    disp(['Best Score ',num2str(s(best))]);
    
    %if there has been no improvement in the score in the past 30
    %iterations, stop
    if i > 30 && scores(i) == scores(i - 30)
        disp('No improvement in the last 30 interations.');
        break;
    end
end
    
%output the best parameter values from this run and the score those
%parameter values give for each image
output.params = params;
output.score  = s(best);
    