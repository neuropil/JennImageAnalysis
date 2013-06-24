% output = compare_cellids(cells1,cells2,weights,D,outtype)
% Compares two binary matrixes, cells1 and cells2 for the percent match
% between the identified cells in both.
%
% The function does not compute the individual pixel correlation between 
% the two input matrixes.  Rather it determines how well the cells
% identified in cells2 match those identified in cells1.  As long as one 
% pixel from a given cell in cell1 aligns with one pixel from a given cell
% in cell2 that cell in cells2 is considered a match.  
%
% False positivies are cells identified in cells2 that do not overlap with
% any pixels considered cells in cells1.  
%
% False negatives are cells identified in cells1 that do not overlap with
% any pixels considered cells in cells2.
%
% Clumps are when a group of pixels in one input matrix are all part of one
% cell but in the other matrix are part of 2 or more cells.
%
% The match score is computed using the following formula:
% score = 1 - (sum([false_pos,false_neg,clumps]*weights) / total cell count)
%
%
%
% INPUT PARAMETERS:
% --------------------
%
%   cells1          A binary matrix. 1 where there is a cell and 0 where
%                   there isn't.  This matrix is the standard to which
%                   cells2 is compared and is considered to be correct.
%
%   cells2          A binary matrix like cells1 with 1 where there is a 
%                   cell and 0 where there isn't.  This matrix is not 
%                   assumed to be correct.
% 
%
% OPTIONAL PARAMETERS:
% --------------------
%
%   weights         The score takes into account 3 types of errors: false
%                   positives, false negatives, and clumps.  This is a
%                   three element vector with values between 0 and 1 used
%                   to weight each of the errors before combining into a
%                   final score. Setting a value to 0 causes that type of
%                   error to be ignored in the match score.  Default is 
%                   [1 1 1].
%
%   D               This is a flag that controls the graphical display. Set 
%                   to 1 to turn on the display.  Default is 0.
%
%   outtype         This is a string that controls the type of output the
%                   function produces.  'basic' simply outputs the match
%                   score. 'full' outputs a structure with the following
%                   fields:
%
%                   score   the match score
%
%                   count   the total number of cells from cells1
%
%                   falsepos    the number of false positives
%                   falseneg    the number of false negatives
%                   overlap     the number of clumped cells
%
%                   clumped cells are when a group of pixels in one input
%                   matrix are all part of one cell but in the other input
%                   image are part of two or more cells. Default is 'basic'
%
%
% OUTPUT:
% --------------------
%
%   output          depending on the setting for outtype (see above) it can
%                   either be simply the match score or a structure
%                   containing error information.
%
% Developed by Charles Kopec 2010
%

function output = compare_cellids(cells1,cells2,weights,D,outtype,varargin)

%assumed cells1 is the ideal case and cells2 is the current fit
if nargin < 3; weights = [1 1 1]; end
if nargin < 4; D = 0; end
if nargin < 5; outtype = 'basic'; end

buf = 20;
cells1 = cells1(buf:end-buf+1,buf:end-buf+1);
cells2 = cells2(buf:end-buf+1,buf:end-buf+1);

temp1 = bwlabel(cells1);
cnt1  = max(max(temp1));

temp2 = bwlabel(cells2);
cnt2  = max(max(temp2));

overlap1 = 0;
for i = 1:cnt1
    if sum(sum(temp1 == i & temp2 ~= 0)) > 0;
        overlap1 = overlap1 + 1;
    end
end

overlap2 = 0;
for i = 1:cnt2
    if sum(sum(temp2 == i & temp1 ~= 0)) > 0;
        overlap2 = overlap2 + 1;
    end
end

falseneg = (cnt1 - overlap1) * weights(1); %how many real cells are missed.
falsepos = (cnt2 - overlap2) * weights(2); %how many things that are not cells are called cells

totalcnt = cnt1 + cnt2;
totalerr = falsepos + falseneg; 

overlaperr = (totalcnt - totalerr) - (min([overlap1 overlap2]) * 2); %how many cells are clumped together with other cells
totalerr   = totalerr + (overlaperr * weights(3));

if strcmp(outtype,'basic')
    output = 1 - (totalerr / cnt1);
else
    output.score = 1 - (totalerr / cnt1);
    output.count = cnt1;
    output.falsepos = falsepos;
    output.falseneg = falseneg;
    output.overlap  = overlaperr;
end


if D == 1;
    c = zeros(size(cells1));
    c(cells1 == 1 & cells2 == 0) = 1;
    c(cells1 == 0 & cells2 == 1) = 2;
    c(cells1 == 1 & cells2 == 1) = 3;
    colors = [0 0 0;...
              0 1 0;...
              0 0 1;...
              1 0 0];
    c(1:4) = 0:3;      
    
    imagesc(c);
    colormap(colors);
    title(['G: c1   B: c2   R: overlap   ',num2str(1 - (totalerr / cnt1))]);
    
end