function [bound varargout] = findboundary(I,T,click,V,GL)

morphiter  = str2num(get_atlas_property('morphological_filter_size'));  %#ok<ST2NM>
filtersize = str2num(get_atlas_property('lowpass_filter_size'));        %#ok<ST2NM>
filterstd  = str2num(get_atlas_property('lowpass_standard_deviation')); %#ok<ST2NM>

if V <= 3
    I2 = I(:,:,V);
    if     isa(I, 'uint8');      n = 255;
    elseif isa(I, 'uint16');     n = 65535;
    elseif max(max(max(I))) > 1; n = max(max(max(I)));
    else                         n = 1;
    end
else
    disp('Performing HSV Conversion...');    
    if     V == 4; outchan = 'h'; 
    elseif V == 5; outchan = 's';
    elseif V == 6; outchan = 'v';
    end
    I2 = rgb2hsv_special(I,outchan);
    n = 1;
end
                                       
disp('Padding the Image...');
padsize = max([morphiter*2 filtersize]); 
if     strcmp(get_atlas_property('erased_area_color'),'black'); b = double(min(min(I2)));
elseif strcmp(get_atlas_property('erased_area_color'),'white'); b = double(max(max(I2)));
else                                                            b = 0;
end
Ipad = ones(size(I2,1)+(2*padsize),size(I2,2)+(2*padsize)) .* b;
for c = 1:size(I2,2)
    Ipad(padsize+1:end-padsize,c+padsize) = I2(:,c);
end
    
disp('Performing Lowpass Filter...');
if     isa(I, 'uint8');  Ipad = uint8( Ipad);
elseif isa(I, 'uint16'); Ipad = uint16(Ipad);
end
If = imfilter(Ipad,fspecial('gaussian',filtersize,filterstd));
if     isa(I, 'uint8');  If = double(If);
elseif isa(I, 'uint16'); If = double(If);
end
If = If ./ n;

bw = false(size(If));
if GL == 1; bw(If > T) = 1;                               
else        bw(If < T) = 1;
end

bw(1:padsize,:) = 0;
bw(end-padsize+1:end,:) = 0;
bw(:,1:padsize) = 0;
bw(:,end-padsize+1:end) = 0;

disp('Filling Tissue Holes...');
bw = imfill(bw,'holes');                    

disp('Finding Clicked Object...')
L     = bwlabel(bw);                           
region = L(round(click(3)),round(click(1)));

bw2 = false(size(bw));                       
bw2(L == region) = 1;                    
bw = bw2;

disp('Performing Morphological Filter...');
bw = imopen(bw,strel('disk',morphiter,8));
bw = imclose(bw,strel('disk',2*morphiter,8)); 
bw = imopen(bw,strel('disk',morphiter,8)); 

bw(1:padsize,:)         = [];
bw(end-padsize+1:end,:) = [];
bw(:,1:padsize)         = [];
bw(:,end-padsize+1:end) = [];

bw = bwperim(bw);                         

disp('Tracing Boundary...');
try bound = traceboundary(bw); catch bound = []; end

if nargout > 1
    varargout(1) = {mean(bound)};
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'bound') == 0 && strcmp(varnames(vari).name,'varargout') == 0
        clear(varnames(vari).name); 
    end
end
clear vari varnames;