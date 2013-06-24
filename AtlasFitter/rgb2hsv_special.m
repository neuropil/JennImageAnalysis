function [output varargout] = rgb2hsv_special(I,c,varargin)
%Special version of the rgb2hsv function that allows the output of either
%h, s, or v channels independently.
%I is the input image.
%c is the output channel, either 'h', 's', or 'v'.  
%Not specifying c will output all three.

if nargin == 1; c = 'all'; end

if isa(I, 'uint8')
    I = double(I) / 255;
elseif isa(I, 'uint16')
    I = double(I) / 65535;
end

if (ndims(I)==3)
    r = I(:,:,1); g = I(:,:,2); b = I(:,:,3);
    siz = size(r);
    r = r(:); g = g(:); b = b(:);
elseif (ndims(I)==2)
    r = I(:,1); g = I(:,2); b = I(:,3);
    siz = size(r);
else
    r = I(1); g = I(2); b = I(3);  
    siz = size(r);
end

v = max(max(r,g),b);
if strcmp(c,'v')==1; output = reshape(v,siz); return; end

h = zeros(size(v));
s = (v - min(min(r,g),b));

z = ~s;
s = s + z;
k = find(r == v);
h(k) = (g(k) - b(k))./s(k);
k = find(g == v);
h(k) = 2 + (b(k) - r(k))./s(k);
k = find(b == v);
h(k) = 4 + (r(k) - g(k))./s(k);
h = h/6;
k = find(h < 0);
h(k) = h(k) + 1;
h=(~z).*h;

if strcmp(c,'h')==1; output = reshape(h,siz); return; end

clear r
clear g
clear b

k = find(v);
s(k) = (~z(k)).*s(k)./v(k);
s(~v) = 0;

if strcmp(c,'s')==1; output = reshape(s,siz); return; end


h = reshape(h,siz);
s = reshape(s,siz);
v = reshape(v,siz);
if nargout == 1
    if     (ndims(I)==3); output=cat(3,h,s,v); 
    else                  output=[h,s,v];
    end                  
elseif nargout == 3
    output       = h;
    varargout{1} = s;
    varargout{2} = v;
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'varargout') == 0
        clear(varnames(vari).name); 
    end
end
clear vari varnames;