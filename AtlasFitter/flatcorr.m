function xrgb = flatcorr(xrgb,flat,D,varargin)

    if nargin == 0
        [f p] = uigetfile('*.tif');
        cd(p);
        xrgb = imread([p f]);
        [ff pp] = uigetfile('*.tif');
        flat = imread([pp ff]);
        D = 1;
    end
    if nargin == 1
        [ff pp] = uigetfile('*.tif');
        flat = imread([pp ff]);
        D = 1;
    end
    if nargin == 2
        D = 1;
    end
     
    try
        xrgb = double(xrgb);
        flat = double(flat);

        for c = 1:3; xrgb(:,:,c) = xrgb(:,:,c) ./ flat(:,:,c); end
        xrgb = xrgb * (1 / max(xrgb(xrgb ~= Inf))) * 128;
    catch
        xrgb = double(xrgb);

        for r = 1:size(xrgb,1)
            for c = 1:3; 
                xrgb(r,:,c) = xrgb(r,:,c) ./ double(flat(r,:,c)); 
            end
        end
        normfact = (1 / max(xrgb(xrgb ~= Inf))) * 128;
        for r = 1:size(xrgb,1)
            for c = 1:3; 
                xrgb(r,:,c) = xrgb(r,:,c) * normfact; 
            end
        end
        
    end
    
    xrgb = uint8(xrgb);
    
    if D == 1; figure; imshow(xrgb); end
    
    
varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'xrgb') == 0; clear(varnames(vari).name); end
end
clear vari varnames;