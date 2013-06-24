function BatchImageResize

% Use uigetfile function from Matlab to obtain directory
% location of files to resize: use of uigetfile is preferable to uigetdir
% in this instance because you can designate the file types to display in
% the directory window.  Also, groups of similar file types can be
% clustered for display.  BELOW I have clusted .tif and .tiff files for
% display

[~, pathname] = uigetfile( ...
{'*.tif;*.tiff', 'Image Files (*.tif,*.tiff)';... 
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'off');

%% Create new File Folder

% This code portion is a generic snippet that will check for the instance
% of a new folder and if not found will create the new folder for storage
% of ouputed data.  In order to maintain the same directory root location
% as the files being analyzed the new folder name is bound to the existing
% pathname designated in the uigetfile call.  In this code 'exist' checks
% whether the folder is located in the directory by using the 'exist'
% argument 'dir'.  If the folder is not found the 'mkdir' function creates the folder 

FilesOUT = char(strcat(pathname,'Resized_Images'));

if exist(FilesOUT, 'dir') == 0
     mkdir(FilesOUT);
end

%% Obtain Resize Ratio

% This line of code creates a variable with the desired image resize
% fraction.  If a reduction to 25% is desired indicate 0.25; if a reduction
% to 95% indicate 0.95.  Keep in mind this will not reduce the image by 95%, but
% resize to 95%.  'inputdlg' is a Matlab function that accepts arguments for a query
% , an input title, line number, and cell array of default answers 

ResizeVal = inputdlg('Indicate Fraction of Image reduction:', 'IMAGE RESIZE', 1, {'0.5'});

% This is a generic error-check snippet that will run if the user does not
% enter a value or exits the inputdlg with indicating an answer

while isempty(ResizeVal)
    ResizeVal = inputdlg('Indicate Fraction of Image reduction:', 'IMAGE RESIZE', 1, {'0.5'});
end
    
%% Obtain list of files

% This part of the code could be improved to error-check for a group of
% similar image file types.  Currently, the user needs to place only those
% files that are intended to be resized within the folder of interest which
% is located during the call to uigetfile

% Go to current directory for files indicated by uigetfile call

cd(pathname)

% The Matlab function ls gives a list of the files in the current
% directory.  Create a variable that will hold the output of calling ls on
% the current directory

imdir = ls;

% 'ls' creates a character array of the files in the current directory.  A
% more conveinent data structure for loading and manipulating file names is
% a cell array.  To convert a character array into a cell array of strings
% use the Matlab function 'cellstr'

imageList = cellstr(imdir);

% Whenever the information from ls is assigned to a variable the first
% three lines are not related to the available file names and should be
% removed

imageList(1:3) = [];


%% Run Resize loop

% This loop will read in each image file name, call the Image Processing
% Toolbox 'resize' function, and save the resulting image out to the new
% folder

for readI = 1:length(imageList)
% At the start of each loop ensure that the folder location is the original
% directory of image files to be processed
    cd(pathname) 
% This line obtains the current filename to be resized    
    FileName = char(imageList(readI));
% This line creates variable from the output of calling the 'imread'
% function on the current image filename
    IMoriginal = imread(FileName);
% This line creates a variable from the output of calling the 'resize'
% function on product of the 'imread' function.  Note that the 'resize'
% function needs a resize value input.  For this argument we will use the
% output of inputdlg ABOVE.  Note that an inputdlg output is in the form of
% a string variable.  The 'resize' function requires a number input, so we
% need to convert our inputdlg output 'ResizeVal' into a number using the
% Matlab function 'str2double' which converts a string variable to a double
% variable
    resizeOimage = imresize(IMoriginal, str2double(ResizeVal));
% This line is used to dynamically rename each new image file created with
% its original file name with the additional information that it was
% resized and its resized fraction.  To extract the file name of the
% original file we will use the Matlab function 'strtok' to find the file
% name.  'strtok' ouputs every element of a target string up to the
% delimiting feature.  Here we will search for the filename
% target using '.' as the delimiter.  Thus the output will be everything up to the '.'
    Fname = strtok(FileName,'.');
% Now we will create our new file name to be saved out in the new folder by
% combining all the relevant pieces of information.  I've used the strcat function
% to combine all the relevant pieces
    revisedFname = char(strcat('Resized_',num2str(str2double(ResizeVal{1}) * 100),'%_',Fname,'.tiff'));
% This line will open the new folder directory where resized files will be
% saved
    cd(FilesOUT);
% This line uses the 'imwrite' function to save the image file to the new
% folder location
    imwrite(resizeOimage,revisedFname,'tiff')
    
end
    
    
    
    