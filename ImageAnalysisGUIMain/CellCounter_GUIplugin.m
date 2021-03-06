% x = CellCounter(I,action,x)   Identifies cells in image I
%
% PARAMETERS:
% -----------
%
%   I               The image.  Can be a monochrome or color image of 8but,
%                   16bit, or double precision. Color information is
%                   collapsed by adding pixels values across the 3rd
%                   dimensions. I can contain either bright cells on a dark
%                   background or dark cells on a bright background.
%
%
% OPTIONAL PARAMETERS:
% --------------------
%
%   action          A string defining the action the function should
%                   perform
%
%                   'all' will perform all actions (default)
%                   'findedge' the function will only return edges
%
%   x               x is a structure equivalent to the output of
%                   CellCounter. Any fields in x will be skipped in the
%                   computation.  For example, if you pass in x.edg then
%                   the edge computation will be skipped and the matrix in
%                   x.edg will be used in its place.  Possible fields are:
%
%                   thresholds      this is a structure containing the
%                                   following fields:
%
%                       minwatersize    watersheds with fewer than this
%                                       many pixels will be discarded.
%
%                       cell            threshold score for identifying
%                                       which watersheds contain a cell.
%                                       Lowering this value will increase
%                                       the number of identified cells
%
%                       mincellsize     cells with fewer than this many
%                                       pixels are discarded
%
%                       maxcellsize     cells with greater than this many
%                                       pixels are discarded
%
%                       boundary        a threshold used to fuse
%                                       neighboring cells that both touch
%                                       their watershed boundaries.
%                                       Lowering this value will lead to
%                                       fewer fusions. Setting to 0 will
%                                       result in no fusions.
%
%                       blursize        the size of the Gaussian kernel
%                                       used to lowpass filter the image.
%
%                       blurspread      the standard deviation of the
%                                       Gaussian function used in the
%                                       lowpass filter.
%
%                       cellpixels      the number of darkest pixels in the
%                                       Watershed's local minimum used to
%                                       test if that local minimum is a
%                                       cell
%
%                       backpercent     the percent of brightest pixels in
%                                       the Watershed used as a measure of
%                                       local background
%
%                       cellsign        set to 1 for images where the cells
%                                       are brighter than the background,
%                                       e.g. fluorescence, set to 0 for
%                                       images where the cells are darker
%                                       than the background, e.g.
%                                       colorimetric.
%
%                       findedge        set to 1 to locate sharp edges and
%                                       exclude waterhseds near them from
%                                       analysis. Set to 0 to skip edge
%                                       detection.
%
%                   log         This is the 2D matrix on which the cell
%                               identification algorithm operates.  It is
%                               internally calculated as the natural log of
%                               the image after summing across color
%                               channels.
%
%                   edg         This is a logical 2D matrix used as a mask
%                               to exclude watersheds from analysis. Any
%                               watershed that overlaps with a pixel of
%                               value 1 will be excluded from anaysis.  It
%                               is internally calculated using an edge
%                               detection algorithm.
%
%                   mask        Has the same behavior as x.edg except it is
%                               not internally calculated.  Allows users to
%                               exclude regions from analysis based on some
%                               external function.
%
%                   water       This is a 2D matrix identifying the
%                               subregions within which the cell
%                               identification test will be applied.
%                               Independent subregions identified as pixels
%                               with the equivalent interger value.
%                               Internally it is calculated using the
%                               Watershed algorithm.
%
%                   index       This is a cell with each element
%                               corresponding to the subregions defined by
%                               that integer, i.e. index{5} regers to
%                               subregion 5. Each element contains the
%                               values of the pixels associated with that
%                               subregion.Internally calculated as the
%                               pixel values from the log image.
%
%
% OUTPUT:
% -------
%
%   x               This is a structure containing the following fields:
%
%                   thresholds, log, edg, mask, water, and index see above
%                   for description.
%
%                   fullwater   a logical matrix identifying the waterhsed
%                               boundaries as 1.
%
%                   cells       a 2D matrix equivelent to water output.
%                               Watersheds determined not to contain a cell
%                               are set to 0.
%
%                   pixels      a cell similar to index except it contains
%                               the location of each pixel in each
%                               subregion, not its value.
%
%                   cellcores   a 2D binary matrix identifying which pixels
%                               are determined to belong to cells.
%
%                   cellnorm    the prodcut of cellcores and log
%
%                   cellCperim  a 2D binary matrix identifying the pixels
%                               on the boundaries of the cell cores.
%
%                   cellWperim  2 2D binary matrix identifying the
%                               boundaries of the regions in cells
%
%                   bound       a list of pixel coordinates that touch the
%                               cell cores
%
%                   neighbors   an index of which subregions border each
%                               other. Each value is a unique ID assigned
%                               to each possible subregion pair. ID =
%                               (Region1 * Region2) + 1/(Region1 + Region2)
%
%                   conmat      a cell where each element refers to a
%                               cell core.  Each element contains the cells
%                               that cell is no more than 1 pixel from.
%
%                   cellatbound a list of the cells that touch their
%                               subregion boundaries.
%
%                   fuse        a matrix containing the information
%                               regarding which cells have been fused. Each
%                               row corresponds to a fused pair and
%                               contains 5 values: 1 is the dominant cell
%                               in the pair, 2 is the subordinant cell, 3
%                               is the z-score of the pixels between them,
%                               4 is the difference between signal and
%                               background of the pixels between them, and
%                               5 is the product of 3 and 4.
%
%   Developed by Charles Kopec 2010
%   See ## publication for further description.

function x = CellCounter_GUIplugin(~,~,x,varargin)


    

    mask = roipoly; %Left click on the image to draw a polygon around the ROI, Right click closes it, Enter finishes
    %
    
    I = zeros(size(Ioriginal));
    for i = 1:size(Ioriginal,3);
        tempImage = Ioriginal(:,:,i);
        tempImage(mask == 0) = 0;
        I(:,:,i) = tempImage;
    end
    
    [borders,~] = bwboundaries(mask);
    
    
    sw = 1; %if you set this to 1 it will display waitbars
    
    
        
        %Just a personal log of values we've used.
        %for Chuck  50 0.08 15 300 0.0005 5 1 15 0.3    0 1
        %for Bo     10 0.12  3  20 0      3 1  3 0.3    1 0
        %for Sergei 30 0.16  6  80 0      5 1 16 0.1631 1 1
        

    
    if x.thresholds.cellsign == 1
        %cells are maxima. the image must be inverted since the algorithm looks for minima.
        if strcmp(class(I),'uint8');  
            I = 255 - I;
        elseif strcmp(class(I),'uint16'); 
            I = 65536 - I;
        else
            I = max(max(max(I))) - I;
        end
    end
    
    if sw==1; h = waitbar(0.1,'Preprocessing Image.'); end
    
    %lowpass filter the image, sum across color channels, and take the natural log
    if ~isfield(x,'log')
        if x.thresholds.blursize == 0 || x.thresholds.blurspread == 0
            temp = I;
        else
            temp  = imfilter(I,fspecial('gaussian',x.thresholds.blursize,x.thresholds.blurspread));
            if sw==1; waitbar(0.4); end
        end
        temp  = sum(temp,3);
        temp(temp == 0) = 1;
        x.log  = log(temp);
    else
        mask = sum(I,3);
        x.log(mask == 0) = 0;
    end
    
    %Run edge detection.
    if ~isfield(x,'edg')
        if x.thresholds.findedge == 1
            %So far I've found this first method works well for colorimetric
            %images while the second works well for fluorescence images.  Feel
            %free to modify this code to best work in your images.
            if x.thresholds.cellsign == 0
                x.edg = logical(edge(x.log,'sobel')); if sw==1; waitbar(0.7); end
                x.edg = imdilate(x.edg,strel('disk',2));
                x.edg = bwareaopen(x.edg,100,8);
                x.edg = imdilate(x.edg,strel('disk',8));
                
            else
                x.edg = logical(edge(x.log,'canny',[0.0125 0.05],5));
                x.edg = bwareaopen(x.edg,250,8);
                x.edg = imdilate(x.edg,strel('disk',8));
            end
        else
            x.edg = false(size(x.log));
        end
    end
    
    %If all the user wants to do is find the edge, stop here.
    if strcmp(action,'findedge') == 1
        if sw==1; close(h); pause(0.1); end
        return;
    end
    
    %If the user has supplied a mask, apply it to the log image.
    if isfield(x,'mask'); x.log(x.mask == 0) = Inf; end
    
    %Identify subregions using the watershed algorithm
    if ~isfield(x,'water')
        x.water = watershed(x.log); if sw==1; waitbar(0.9); end
        x.fullwater = false(size(x.water));
        x.fullwater(x.water == 0) = 1;
    end
    
    if isfield(x,'mask'); x.water(x.mask == 0) = 0; end
    
    %Remove small watersheds, those remaining are our first pass potential cells
    temp = false(size(x.water));
    temp(x.water ~= 0) = 1;
    temp = bwareaopen(temp,x.thresholds.minwatersize,4); if sw==1; waitbar(1); end
    x.cells = bwlabel(temp);
    
    if sw==1; close(h); pause(0.1); end
    
    %Index the image
    if ~isfield(x,'index')
        x = index_image(x);
    end
    
    %Remove any subregions that touch previously detected edges
    x = removeedge(x);
    
    %Apply significance test to remaining subregions, those that pass threshold
    %are deemed to contian cells.
    x.cellcores = false(size(I,1),size(I,2));
    x.cellnorm  = zeros(size(x.log));
    x = cellid(x);
    
    %Remove expty elements from index and pixels, renumber the cells
    %accordingly so there are no skipped numbers
    if sw==1; h = waitbar(0.1,'Cleaning Up Cells.'); end
    x = compressids(x); if sw==1; waitbar(0.3); end
    
    %Identify pixels that are the perimeter of the cell cores
    x.cellCperim = logical(bwperim(x.cellcores)); if sw==1; waitbar(0.5); end
    
    %Identify pixels that are the perimeter of the subregions with cells
    temp = false(size(x.cells));
    temp(x.cells ~= 0) = 1;
    x.cellWperim = logical(bwperim(temp)); if sw==1; waitbar(0.7); end
    
    if x.thresholds.boundary > 0
        %Calculate bound
        temp = imdilate(temp,strel('disk',1)); if sw==1; waitbar(0.9); end
        x.bound = find(x.cells == 0 & temp == 1);
        if sw==1; close(h); end
        
        %Determine which cells border one another
        x = get_neighbor_regions(x);
        
        %Find those cell cores that touch the subregion boundaries
        temp = x.cells(x.cellCperim == 1 & x.cellWperim == 1);
        temp = unique(temp);
        x.cellatbound = temp(temp ~= 0);
        
        %Determine which neighboring cells to fuse
        x = modify_neighbors(x);
        
        if sw==1; h = waitbar(0.1,'Cleaning Up Cells.'); end
        temp = false(size(x.cells));
        temp(x.cells ~= 0) = 1;
        x.cellWperim = logical(bwperim(temp)); if sw==1; waitbar(0.3); end
    end
    
    %Remove large cells
    temp = bwareaopen(x.cellcores,x.thresholds.maxcellsize,4);
    x.cellcores = x.cellcores - temp; if sw==1; waitbar(0.5); end
    x.cellnorm(x.cellcores == 0) = 0;
    
    x.cellCperim = logical(bwperim(x.cellcores)); if sw==1; waitbar(0.7); end
    
    x.cellcores = logical(x.cellcores);
    if sw==1; close(h); pause(0.1); end
    
    x.filename = FileName;
    x.Original_Image = Ioriginal;
    
    L = bwlabel(x.cellcores);
    count = max(unique(L));
    x.cellcount = count; % OUTPUT x.cellcount FOR CELL COUNT
    
    %To superimpose the cells on the image do the following
    I(:,:,1) = x.cellcores; %the red channel will now have the identified cells
    
    I = I(:,:,1);
    
    red = cat(3, ones(size(I)), zeros(size(I)), zeros(size(I)));
    himage = imshow(red);
    set(himage, 'AlphaData', x.Original_Image(:,:,1));
    hold on
    iim3 = imshow(x.Original_Image(:,:,1));
    set(iim3,'AlphaData',double(I));
    plot(borders{1,1}(:,2),borders{1,1}(:,1),'k')
     

end


    
