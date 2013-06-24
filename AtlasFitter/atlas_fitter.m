function varargout = atlas_fitter(varargin)
% ATLAS_FITTER M-file for atlas_fitter.fig
%      ATLAS_FITTER, by itself, creates a new ATLAS_FITTER or raises the existing
%      singleton*.
%
%      H = ATLAS_FITTER returns the handle to a new ATLAS_FITTER or the handle to
%      the existing singleton*.
%
%      ATLAS_FITTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATLAS_FITTER.M with the given input arguments.
%
%      ATLAS_FITTER('Property','Value',...) creates a new ATLAS_FITTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before atlas_fitter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to atlas_fitter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help atlas_fitter

% Last Modified by GUIDE v2.5 29-Apr-2011 10:53:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atlas_fitter_OpeningFcn, ...
                   'gui_OutputFcn',  @atlas_fitter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before atlas_fitter is made visible.
function atlas_fitter_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>

p = get_atlas_property('button_path'); 
try %#ok<TRYNC>
    load([p 'up_arrow.mat']);
    set(handles.u_button,'Cdata',x);
    set(handles.u_button,'string','');
end
try %#ok<TRYNC>
    load([p 'right_arrow.mat']);
    set(handles.r_button,'Cdata',x);
    set(handles.r_button,'string','');
end
try %#ok<TRYNC>
    load([p 'down_arrow.mat']);
    set(handles.d_button,'Cdata',x);
    set(handles.d_button,'string','');
end
try %#ok<TRYNC>
    load([p 'left_arrow.mat']);
    set(handles.l_button,'Cdata',x);
    set(handles.l_button,'string','');
end
try  %#ok<TRYNC>
    load([p 'expand_arrow_horizontal.mat']);
    set(handles.exabs_button,'Cdata',x);
    set(handles.exabs_button,'string','');
end
try %#ok<TRYNC>
    load([p 'expand_arrow_horizontal.mat']);
    set(handles.exbody_button,'Cdata',x);
    set(handles.exbody_button,'string','');
end
try %#ok<TRYNC>
    load([p 'shrink_arrow_horizontal.mat']);
    set(handles.shabs_button,'Cdata',x);
    set(handles.shabs_button,'string','');
end
try %#ok<TRYNC>
    load([p 'shrink_arrow_horizontal.mat']);
    set(handles.shbody_button,'Cdata',x);
    set(handles.shbody_button,'string','');
end
try %#ok<TRYNC>
    load([p 'cw_arrow.mat']);
    set(handles.cw_button,'Cdata',x);
    set(handles.cw_button,'string','');
end
try %#ok<TRYNC>
    load([p 'ccw_arrow.mat']);
    set(handles.ccw_button,'Cdata',x);
    set(handles.ccw_button,'string','');
end
try %#ok<TRYNC>
    load([p 'zoom.mat']);
    set(handles.zoom_toggle,'Cdata',x);
    set(handles.zoom_toggle,'string','');
end
try %#ok<TRYNC>
    load([p 'docked.mat']);
    set(handles.dockregions_toggle,'Cdata',x);
    set(handles.dockregions_toggle,'string','');
end
try %#ok<TRYNC>
    load([p 'L.mat']);
    set(handles.left_check,'Cdata',x);
    set(handles.left_check,'string','');
end
try %#ok<TRYNC>
    load([p 'R.mat']);
    set(handles.right_check,'Cdata',x);
    set(handles.right_check,'string','');
end
try %#ok<TRYNC>
    load([p 'S.mat']);
    set(handles.slice_toggle,'Cdata',x);
    set(handles.slice_toggle,'string','');
end
try %#ok<TRYNC>
    load([p 'A.mat']);
    set(handles.atlas_toggle,'Cdata',x);
    set(handles.atlas_toggle,'string','');
end
try %#ok<TRYNC>
    load([p 'LS.mat']);
    set(handles.greaterless_toggle,'Cdata',x);
    set(handles.greaterless_toggle,'string','');
end
try %#ok<TRYNC>
    load([p 'fliphorz.mat']);
    set(handles.fliphorz_button,'Cdata',x);
    set(handles.fliphorz_button,'string','');
end
try %#ok<TRYNC>
    load([p 'flipvert.mat']);
    set(handles.flipvert_button,'Cdata',x);
    set(handles.flipvert_button,'string','');
end
try %#ok<TRYNC>
    load([p 'pan.mat']);
    set(handles.pan_toggle,'Cdata',x);
    set(handles.pan_toggle,'string','');
end

himage = imagesc(ones(1500,2000,3)); colormap(gray);
handles.imagehandle = himage;
handles.image = ones(1500,2000,3);
handles.imagesize = size(handles.image);

set(handles.slice_slider,     'Min',1,'Max',2   ,'value',1  , 'Enable','off');
set(handles.atlas_slider,     'Min',1,'Max',2   ,'value',1  , 'Enable','off');
handles = updateimagesliders(handles);
set(handles.surface_slider,   'Min',0,'Max',1   ,'value',0.57, 'SliderStep',[0.01 0.05]);
set(handles.surfacethreshold_edit,'string','0.57');
handles.vsprevious = get(handles.vertical_slider,'value');
handles.hsprevious = get(handles.horizontal_slider,'value');

set(handles.left_check,'value',1);
set(handles.right_check,'value',1);
set(handles.h_check,'value',1);

handles.buttonpath        = p;
handles.activeobject      = [];
handles.mobilepoints{1}   = [];
handles.mobilepoints{2}   = [];
handles.fixedpoints{1}    = [];
handles.fixedpoints{2}    = [];
handles.manualcount       = cell(0);

handles.bluecircles       = [];
handles.bluelines         = [];
handles.blackcircles      = [];
handles.whitedots         = cell(0);
handles.countcolor        = cell(0);

handles.lockedatlas{1}    = [];
handles.currentatlas      = [];
handles.currentpairs      = [];
handles.currentflip       = [];
handles.currentangles     = [];
handles.currentleftright  = [1 1];
handles.lockedleftright{1}= [1 1];
handles.lockedflip{1}     = [];
handles.lockedangles{1}   = [];
handles.lockedatlasnum{1} = [];
handles.region            = cell(0);

handles.numregions        = [];
handles.leftright         = [];
handles.pointpairs        = [];
handles.atlaspath         = [];
handles.atlas_previous    = [];

handles.surface           = cell(0);
handles.imagepaths        = cell(0);
handles.surfacehandle     = cell(0);
handles.userregionh       = cell(0);
handles.userregion        = cell(0);
%set(gcf,'Renderer','OpenGL');

% Choose default command line output for atlas_fitter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes atlas_fitter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = atlas_fitter_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>


% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function vertical_slider_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    y = get(handles.axes1,'YLim');
    d = get(hObject,'value') - handles.vsprevious;
    y = y - d;

    set(handles.axes1,'YLim',y);
    handles.vsprevious = get(hObject,'value');

    guidata(hObject,handles);

catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes during object creation, after setting all properties.
function vertical_slider_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function horizontal_slider_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    x = get(handles.axes1,'XLim');
    d = get(hObject,'value') - handles.hsprevious;
    x = x + d;

    set(handles.axes1,'XLim',x);
    handles.hsprevious = get(hObject,'value');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes during object creation, after setting all properties.
function horizontal_slider_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function imagefile_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function imagefile_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function atlasfile_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function atlasfile_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function datafile_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function datafile_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadimages_button.
function loadimages_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if isfield(handles,'surfacehandle'); 
        for s = 1:length(handles.surfacehandle)
            if ~isempty(handles.surfacehandle{s})
                try delete(handles.surfacehandle{s}); %#ok<TRYNC>
                end
                handles.surfacehandle{s} = [];
            end
            handles.surface{s} = [];
        end
    end


    [f p] = uigetfile({'*.mat;*.tif'});
    if f == 0
        return;
    end

    set(gcf,'Pointer','watch'); pause(0.01);

    cd(p);
    [pathstr name ext versn] = fileparts(f); %#ok<NASGU>
    if strcmp(ext,'.tif')
        handles.imagepaths{1} = [p f];
        handles.image         = imread([p f]);
        handles.numslices     = 1;
    else
        load([p f]);
        handles.imagepaths = checkimagepaths(imagestack,[p f]); %#ok<USENS>
        try
            handles.image      = imread(handles.imagepaths{1});
        catch %#ok<CTCH>
            disp(['Error Loading Image: ',handles.imagepaths{1}]);
            return
        end
        handles.numslices  = length(handles.imagepaths);
    end
    set(handles.slice_slider,'Min',1,'Max',2,'value',1,'Enable','off');
    if handles.numslices > 5
        set(handles.slice_slider,'Enable','on','Max',handles.numslices,...
            'SliderStep',[1/(handles.numslices-1) 5/(handles.numslices-1)]);
    elseif handles.numslices > 1
        set(handles.slice_slider,'Enable','on','Max',handles.numslices,...
            'SliderStep',[1/(handles.numslices-1) 1/(handles.numslices-1)]);    
    end
    set(handles.slicecount_edit,'string','1');
    set(handles.imagehandle,'cdata',handles.image);
    set(handles.imagefile_edit,'string',f);
    handles.slice_previous = handles.numslices;
    for temp = 1:handles.numslices
        handles.surface{temp}        = [];
        handles.surfacehandle{temp}  = [];
        handles.userregionh{temp}    = [];
        handles.userregion{temp}     = [];
        handles.lockedatlas{temp}    = [];
        handles.lockedatlasnum{temp} = [];
        handles.lockedflip{temp}     = [];
        handles.lockedangles{temp}   = [];
        handles.lockedleftright{temp}= [1 1];
    end
    handles.imagesize = size(handles.image);
    axis([1 handles.imagesize(2) 1 handles.imagesize(1)]);

    handles = delete_blueobjects(handles,'both');
    handles = updateimagesliders(handles);

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in loadatlas_button.
function loadatlas_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    if isfield(handles,'region')
        handles.currentatlas = delete_regions(handles.currentatlas);
    end

    try
        defaultatlas = get_atlas_property('default_atlas_path');
        [p,f,ext,versn] = fileparts(defaultatlas); %#ok<NASGU>
        cd(p)
        [f p] = uigetfile('*.mat','',[f,ext]);
    catch
        [f p] = uigetfile;
    end
    if f == 0
        return;
    end
    set(gcf,'Pointer','watch'); pause(0.01);

    load([p f]);
    cd(p);

    handles.region       = regions; %#ok<USENS>
    for a = 1:length(handles.region)
        for r = 1:length(handles.region{a})
            handles.region{a}{r}{2} = perimdirection(handles.region{a}{r}{2},handles.region{a}{r}{6},'cw');
        end
    end
    handles.numregions   = length(regions);

    handles.region{1}    = draw_regions(handles.region{1});
    handles.currentatlas = handles.region{1};

    %axis([1 4000 1 3000]);
    if handles.numregions > 5
        set(handles.atlas_slider,'Min',1,'Max',handles.numregions,'value',1,...
            'SliderStep',[1/(handles.numregions-1) 5/(handles.numregions-1)],'enable','on');
    elseif handles.numregions > 1
        set(handles.atlas_slider,'Min',1,'Max',handles.numregions,'value',1,...
            'SliderStep',[1/(handles.numregions-1) 1/(handles.numregions-1)],'enable','on');    
    else
        set(handles.atlas_slider,'value',1,'Enable','off');
    end
    set(handles.atlascount_edit,'string','1');
    handles.atlas_previous = 1;
    handles.leftright      = findleftright(handles.region);
    handles.pointpairs     = findpointpairs(handles.region);
    handles.currentpairs   = findpointpairs(handles.currentatlas);

    handles = updateangles(handles,'reset');
    handles = updatecurrentflip(handles,'reset');
    handles = delete_blueobjects(handles,'both');

    handles.atlaspath = [p f];
    set(handles.atlasfile_edit,'string',f);

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in saveuserdata_button.
function saveuserdata_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>
oldH = handles;

try
    atlas = [];
    %if isfield(handles,'region')
        atlas.lockedatlas     = handles.lockedatlas;
        atlas.lockedatlasnum  = handles.lockedatlasnum;
        atlas.lockedflip      = handles.lockedflip;
        atlas.lockedangles    = handles.lockedangles;
        atlas.lockedleftright = handles.lockedleftright;
        atlas.region          = handles.region;
        atlas.numregions      = handles.numregions;
        atlas.leftright       = handles.leftright;
        atlas.pointpairs      = handles.pointpairs;
        atlas.atlaspath       = handles.atlaspath;
        atlas.currentatlas    = handles.currentatlas;
        atlas.currentpairs    = handles.currentpairs;
        atlas.currentflip     = handles.currentflip;
        atlas.currentangles   = handles.currentangles;
        atlas.atlas_previous  = handles.atlas_previous;
        atlas.currentatlasnum = str2num(get(handles.atlascount_edit,'string')); %#ok<ST2NM>
    %end
    %if isfield(handles,'image')
        atlas.imagepaths      = handles.imagepaths;
        atlas.surface         = handles.surface;
        atlas.surfacehandle   = handles.surfacehandle;
        atlas.userregion      = handles.userregion;
        atlas.userregionh     = handles.userregionh;
    %end
    %if ~isempty(handles.manualcount)
        atlas.manualcount     = handles.manualcount;
        atlas.countcolor      = handles.countcolor;
    %end
    
    if ~isempty(atlas)

        [f p] = uiputfile;
        if f == 0
            return;
        end
        cd(p);
        save([p f],'atlas');
        disp('User data saved.');
    else
        disp('Nothing to save.');
    end
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in addimage_button.
function addimage_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    [f p] = uigetfile({'*.tif;*.jpg;*.bmp;*.gif'},'MultiSelect','on');
    if isempty(f) || (~iscell(f) && strcmp(num2str(f),num2str(0))); return; end
    set(gcf,'Pointer','watch'); pause(0.01);

    if ~iscell(f); ftemp=f; clear f; f{1} = ftemp; end
    
    for i = 1:length(f)
        if ~isfield(handles,'imagepaths')
            handles.imagepaths{1} = [p f{i}];
        else
            handles.imagepaths{end+1} = [p f{i}];
        end
    end
    
    handles.image = imread([p f{end}]);
    cd(p);

    handles.numslices = length(handles.imagepaths);
    set(handles.imagehandle,'cdata',handles.image);
    handles.slice_previous = handles.numslices - 1;

    handles.imagesize = size(handles.image);
    axis([1 handles.imagesize(2) 1 handles.imagesize(1)]);

    if handles.numslices > 5
        set(handles.slice_slider,'Min',1,'Max',handles.numslices,'value',handles.numslices,...
            'SliderStep',[1/(handles.numslices-1) 5/(handles.numslices-1)],'enable','on');
    elseif handles.numslices > 1
        set(handles.slice_slider,'Min',1,'Max',handles.numslices,'value',handles.numslices,...
            'SliderStep',[1/(handles.numslices-1) 1/(handles.numslices-1)],'enable','on');
    else
        set(handles.slice_slider,'Min',1,'Max',1.01,'value',1,'SliderStep',[1 1],'enable','on');
        handles.slice_previous = 1;
    end
    
    set(handles.imagefile_edit,'string',f{end});

    set(handles.slicecount_edit,'string',num2str(handles.numslices));
    
    for i = 1:length(f)
        handles.surface{end+1}        = [];
        handles.surfacehandle{end+1}  = [];
        handles.userregionh{end+1}    = [];
        handles.userregion{end+1}     = [];
        handles.lockedatlasnum{end+1} = [];
        handles.lockedatlas{end+1}    = [];
        handles.lockedflip{end+1}     = [];
        handles.lockedangles{end+1}   = [];
        handles.lockedleftright{end+1}= [1 1];
    end
    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on slider movement.
function slice_slider_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    slice = round(get(hObject,'value')); 
    set(hObject,'value',slice);
    psh = handles.surfacehandle{handles.slice_previous};
    if ~isempty(psh); try delete(psh); end; end %#ok<TRYNC>
    if ~isempty(handles.surfacehandle{slice})
        h = patch(handles.surface{slice}(:,2),handles.surface{slice}(:,1),[1 1 1],...
            'EdgeColor','r','FaceColor','none','LineWidth',2);
        handles.surfacehandle{slice} = h;
    end

    if ~isempty(handles.userregionh{handles.slice_previous}); 
        for r = 1:length(handles.userregionh{handles.slice_previous}); 
            try delete(handles.userregionh{handles.slice_previous}{r}); end  %#ok<TRYNC>
        end
    end
    if ~isempty(handles.userregionh{slice})
        for r = 1:length(handles.userregionh{slice})
            xi = handles.userregion{slice}{r}(:,1);
            yi = handles.userregion{slice}{r}(:,2);
            handles.userregionh{slice}{r} = line(xi,yi,'color','g','LineWidth',3);
        end
    end
    if get(handles.atlas_toggle,'value') == 0
        if ~isempty(handles.lockedatlas{slice})
            handles.currentatlas  = delete_regions(handles.currentatlas);
            handles.currentatlas  = draw_regions(handles.lockedatlas{slice});
            handles.currentflip   = handles.lockedflip{slice};
            handles.currentangles = handles.lockedangles{slice};
            handles.currentpairs  = findpointpairs(handles.currentatlas);
            set(handles.atlas_slider,'value',handles.lockedatlasnum{slice});
            set(handles.atlascount_edit,'string',num2str(handles.lockedatlasnum{slice}));
        elseif get(handles.atlaspredictor_toggle,'value') == 1
            A = predictatlas(handles);
            if ~isempty(A) && A > 0 && A <= length(handles.region)
                disp(['Atlas Predictor set current atlas to ',num2str(A)]); 
                handles.currentatlas = delete_regions(handles.currentatlas);
                handles.currentatlas = draw_regions(handles.region{A});
                handles.currentpairs = findpointpairs(handles.currentatlas);
                handles = updatecurrentflip(handles,'reset');
                handles = updateangles(handles,'reset');
                set(handles.atlas_slider,'value',A);
                set(handles.atlascount_edit,'string',num2str(A));
            end
        end
    end

    handles.currentleftright = handles.lockedleftright{slice};
    set(handles.left_check, 'value',handles.currentleftright(1));
    set(handles.right_check,'value',handles.currentleftright(2));
    handles = leftrightbutton(handles);
    
    try 
        handles.image     = imread(handles.imagepaths{slice}); 
        handles.imagesize = size(handles.image);
        axis([1 handles.imagesize(2) 1 handles.imagesize(1)]);
        [pathstr,name,ext,versn] = fileparts(handles.imagepaths{slice}); %#ok<NASGU>
        set(handles.imagefile_edit,'string',name);
        handles = updateimagesliders(handles);

    catch
        disp(['Error Loading File: ',handles.imagepaths{slice}]);
        handles.image = []; 
        set(handles.imagefile_edit,'string','');
    end

    set(handles.imagehandle,'cdata',handles.image);
    set(handles.slicecount_edit,'string',num2str(slice));

    handles = update_manualcount(handles,slice);
    
    handles.slice_previous = slice;
    handles = updateatlasbutton(handles,0);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes during object creation, after setting all properties.
function slice_slider_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function atlas_slider_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    atlas = round(get(hObject,'value'));
    set(hObject,'value',atlas);
    slice = get(handles.slice_slider,'value');
    if get(handles.atlas_toggle,'value') == 0
        if ~isempty(handles.lockedatlas{slice}) && atlas == handles.lockedatlasnum{slice}
            handles.currentatlas  = delete_regions(handles.currentatlas);
            handles.currentatlas  = draw_regions(handles.lockedatlas{slice});
            handles.currentflip   = handles.lockedflip{slice};
            handles.currentangles = handles.lockedangles{slice};
            handles.currentpairs  = findpointpairs(handles.currentatlas);
            handles = updateangles(handles,'update');
        else
            handles.currentatlas  = delete_regions(handles.currentatlas);
            handles.currentatlas  = draw_regions(handles.region{atlas});
            handles.currentpairs  = handles.pointpairs{atlas};
            handles = updatecurrentflip(handles,'reset');
            handles = updateangles(handles,'reset');
        end
    end

    set(handles.atlascount_edit,'string',num2str(atlas));
    if get(handles.individual_toggle,'value') == 1
        set(handles.individual_toggle,'value',0);
        set(handles.left_check,'value',1);
        set(handles.right_check,'value',1);
        handles = leftrightbutton(handles);
    end
    handles = updateatlasbutton(handles,0);

    handles.activeobject    = [];

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes during object creation, after setting all properties.
function atlas_slider_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function slicecount_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function slicecount_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function atlascount_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function atlascount_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in u_button.
function u_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    trans = transtrans(handles,[0 -1]);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in r_button.
function r_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    trans = transtrans(handles,[1 0]);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in l_button.
function l_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    trans = transtrans(handles,[-1 0]);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in d_button.
function d_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    trans = transtrans(handles,[0 1]);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in cw_button.
function cw_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    if get(handles.atlas_toggle,'value') == 1 || ~isfield(handles,'region')
        %rotating the image;
        disp('Rotating Image. Please wait...');
        Ir = rotateimage(handles,1);
        handles = save_modified_image(handles,Ir);

        handles.imagesize = size(handles.image);
        axis([1 handles.imagesize(2) 1 handles.imagesize(1)]);

    else
        trans = rotatetrans(handles,1);

        handles.currentatlas = delete_regions(handles.currentatlas);
        handles.currentatlas =   draw_regions(handles.currentatlas,trans);

        handles = updateangles(handles,-1);
    end

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in ccw_button.
function ccw_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    if get(handles.atlas_toggle,'value') == 1 || ~isfield(handles,'region')
        %rotating the image;
        disp('Rotating Image. Please wait...');
        Ir = rotateimage(handles,-1);
        handles = save_modified_image(handles,Ir);

        handles.imagesize = size(handles.image);
        axis([1 handles.imagesize(2) 1 handles.imagesize(1)]);

    else
        trans = rotatetrans(handles,-1);

        handles.currentatlas = delete_regions(handles.currentatlas);
        handles.currentatlas =   draw_regions(handles.currentatlas,trans);

        handles = updateangles(handles,1);
    end

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in exabs_button.
function exabs_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>
oldH = handles;

try
    trans = expandtrans(handles,1);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in shabs_button.
function shabs_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    trans = expandtrans(handles,-1);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in analyzeregions_button.
function analyzeregions_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    if strcmp(get_atlas_property('analyze_user_regions'),'overlap')
        output = userregion_overlap(handles);
        if isempty(output); return; end
        [f p] = uiputfile;
        if f ~= 0; 
            set(gcf,'Pointer','arrow');
            save([p f],'output');
        end
    end

    set(gcf,'Pointer','watch');
    output = [];
    
    [fff ppp] = uiputfile;
    if fff == 0; return; end
    if exist([ppp fff],'file') == 2
        load([ppp fff]);
    end
    
    for i = 1:length(handles.imagepaths)
        pause(0.1);
        %Determine if this image has already been analyzed and saved to this file.
        if isstruct(output) && isfield(output,'cells') && length(output.cells) >= i
            disp(['Data for Image ',num2str(i),' already in file. Skipping image...']);
            continue;
        end
        
        I = imread(handles.imagepaths{i});
        handles.i = i;

        if ~strcmp(get_atlas_property('analyze_image'),'none')
            disp(['Analyzing Whole Image Slice ',num2str(i)]);
            f = get_atlas_property('analyze_image');
            [handles,output] = eval([f,'(handles,I,output)']);
        end

        if isempty(handles.lockedatlas{i}); continue; end

        if ~strcmp(get_atlas_property('analyze_whole_section'),'none')
            disp(['Analyzing Whole Section Slice ',num2str(i)]);
            for r = 1:length(handles.lockedatlas{i})
               if strcmp(handles.lockedatlas{i}{r}{1},'Whole Section'); break; end
            end
            xi   = handles.lockedatlas{i}{r}{2}(:,1);
            yi   = handles.lockedatlas{i}{r}{2}(:,2); 
            mask = roipoly(I(:,:,1),xi,yi);

            if     isa(I,'uint8');  Iws  = uint8(zeros(size(I)));
            elseif isa(I,'uint16'); Iws  = uint16(zeros(size(I)));
            else                    Iws  = zeros(size(I));
            end

            for c = 1:3; 
                temp = I(:,:,c);
                temp(mask == 0) = nan;
                Iws(:,:,c) = temp;
            end

            f = get_atlas_property('analyze_whole_section');
            [handles,output] = eval([f,'(handles,Iws,output)']);
            clear Iws mask sumI temp;
        end

        if sum(handles.lockedleftright{i}) > 0
            if ~strcmp(get_atlas_property('analyze_whole_leftright'),'none')
                disp(['Analyzing Whole Left and Whole Right Slice ',num2str(i)]);
                if handles.lockedleftright{i}(1) == 1
                    for r = 1:length(handles.lockedatlas{i})
                       if strcmp(handles.lockedatlas{i}{r}{1},'Whole Left'); break; end
                    end
                    xi   = handles.lockedatlas{i}{r}{2}(:,1);
                    yi   = handles.lockedatlas{i}{r}{2}(:,2); 
                    mask = roipoly(I(:,:,1),xi,yi);
                else
                    mask = zeros(size(I,1),size(I,2));
                end

                if handles.lockedleftright{i}(2) == 1
                    for r = 1:length(handles.lockedatlas{i})
                       if strcmp(handles.lockedatlas{i}{r}{1},'Whole Right'); break; end
                    end
                    xi   = handles.lockedatlas{i}{r}{2}(:,1);
                    yi   = handles.lockedatlas{i}{r}{2}(:,2); 
                    mask = mask + roipoly(I(:,:,1),xi,yi);
                end

                mask(mask > 1) = 1;

                if     isa(I,'uint8');  Ilr  = uint8(zeros(size(I)));
                elseif isa(I,'uint16'); Ilr  = uint16(zeros(size(I)));
                else                    Ilr  = zeros(size(I));
                end

                for c = 1:3; 
                    temp = I(:,:,c);
                    temp(mask == 0) = nan;
                    Ilr(:,:,c) = temp;
                end

                f = get_atlas_property('analyze_whole_leftright');
                [handles,output] = eval([f,'(handles,Ilr,output)']); 
                clear Ilr mask sumI temp;
            end

            if ~strcmp(get_atlas_property('analyze_individual_regions'),'none')
                for r = 1:length(handles.lockedatlas{i})
                    if handles.lockedleftright{i}(1) == 0 && ~isempty(find(handles.leftright{i}{1} == r)); continue; end %#ok<EFIND>
                    if handles.lockedleftright{i}(2) == 0 && ~isempty(find(handles.leftright{i}{2} == r)); continue; end %#ok<EFIND>
                    handles.r = r;
                    disp(['Analyzing Region ',handles.lockedatlas{i}{r}{1},' Slice ',num2str(i)]);
                    xi   = handles.lockedatlas{i}{r}{2}(:,1);
                    yi   = handles.lockedatlas{i}{r}{2}(:,2); 
                    mask = roipoly(I(:,:,1),xi,yi);

                    if     isa(I,'uint8');  Iir  = uint8(zeros(size(I)));
                    elseif isa(I,'uint16'); Iir  = uint16(zeros(size(I)));
                    else                    Iir  = zeros(size(I));
                    end

                    for c = 1:3; 
                        temp = I(:,:,c);
                        temp(mask == 0) = nan;
                        Iir(:,:,c) = temp;
                    end

                    f = get_atlas_property('analyze_individual_regions');
                    [handles,output] = eval([f,'(handles,Iir,output)']);
                    clear Iir mask sumI temp;
                end

            end
        end
        save([ppp fff],'output');
        clear I;
    end
    
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in exbody_button.
function exbody_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    points1  = getregionpoints(handles.currentatlas);
    ang      = str2double(get(handles.angle_edit,'string'));

    trans1   = rotatetrans(handles,1,ang,points1);
    points2  = points1 + trans1;
    trans2   = expandtrans(handles,1,points2);
    points3  = points2 + trans2;
    trans3   = rotatetrans(handles,1,-ang,points3);
    trans    = trans1 + trans2 + trans3;

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in shbody_button.
function shbody_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    points1  = getregionpoints(handles.currentatlas);
    ang      = str2double(get(handles.angle_edit,'string'));

    trans1   = rotatetrans(handles,1,ang,points1);
    points2  = points1 + trans1;
    trans2   = expandtrans(handles,-1,points2);
    points3  = points2 + trans2;
    trans3   = rotatetrans(handles,1,-ang,points3);
    trans    = trans1 + trans2 + trans3;

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in dockregions_toggle.
function dockregions_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        try
            load([handles.buttonpath 'undocked.mat']);
            set(handles.dockregions_toggle,'Cdata',x);
            set(handles.dockregions_toggle,'string','');
        catch
            set(handles.dockregions_toggle,'string','UD');
        end
    else
        try
            load([handles.buttonpath 'docked.mat']);
            set(handles.dockregions_toggle,'Cdata',x);
            set(handles.dockregions_toggle,'string','');
        catch
            set(handles.dockregions_toggle,'string','D');
        end
    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in hv_toggle.
function hv_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 0
        set(hObject,'string','Horizontal ML');

        try %#ok<TRYNC>
            load([handles.buttonpath 'expand_arrow_horizontal.mat']);
            set(handles.exbody_button,'Cdata',x);
            set(handles.exbody_button,'string','');

            set(handles.exabs_button,'Cdata',x);
            set(handles.exabs_button,'string','');        
        end

        try %#ok<TRYNC>
            load([handles.buttonpath 'shrink_arrow_horizontal.mat']);
            set(handles.shbody_button,'Cdata',x);
            set(handles.shbody_button,'string','');

            set(handles.shabs_button,'Cdata',x);
            set(handles.shabs_button,'string','');        
        end

    else
        set(hObject,'string','Vertical DV');

        try %#ok<TRYNC>
            load([handles.buttonpath 'expand_arrow_vertical.mat']);
            set(handles.exbody_button,'Cdata',x);
            set(handles.exbody_button,'string','');

            set(handles.exabs_button,'Cdata',x);
            set(handles.exabs_button,'string','');        
        end

        try %#ok<TRYNC>
            load([handles.buttonpath 'shrink_arrow_vertical.mat']);
            set(handles.shbody_button,'Cdata',x);
            set(handles.shbody_button,'string','');

            set(handles.shabs_button,'Cdata',x);
            set(handles.shabs_button,'string','');
        end    

    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in resetatlas_button.
function resetatlas_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    disp(['Loading: ',handles.atlaspath]);
    atlas   = get(handles.atlas_slider,'value');
    load(handles.atlaspath);

    handles = delete_blueobjects(handles,'both');

    for r = 1:length(regions{atlas}) %#ok<NODEF>
        regions{atlas}{r}{2} = perimdirection(regions{atlas}{r}{2},regions{atlas}{r}{6},'cw'); %#ok<AGROW>
    end

    handles.currentatlas  = delete_regions(handles.currentatlas);
    handles.currentatlas  = draw_regions(regions{atlas}); %#ok<USENS>
    handles.region{atlas} = regions{atlas}; %#ok<USENS>
    handles.leftright     = findleftright(handles.region);
    handles.currentpairs  = findpointpairs(handles.currentatlas);
    handles = updatecurrentflip(handles,'reset');
    handles = updateangles(handles,'reset');

    set(handles.angle_edit,'string','0');

    guidata(hObject,handles);
    disp(['Atlas ',num2str(atlas),' Reset']);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in zoom_toggle.
function zoom_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        zoom on;
        try %#ok<TRYNC>
            load([handles.buttonpath 'zoom_on.mat']);
            set(handles.zoom_toggle,'Cdata',x); %#ok<NODEF>
            set(handles.zoom_toggle,'string','');
        end    
    else
        zoom off;
        try %#ok<TRYNC>
            load([handles.buttonpath 'zoom.mat']);
            set(handles.zoom_toggle,'Cdata',x); %#ok<NODEF>
            set(handles.zoom_toggle,'string','');
        end
    end

    handles = updateimagesliders(handles);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in exportimages_button.
function exportimages_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,DEFNU>
oldH = handles;

try
    [f p] = uiputfile;
    imagestack = handles.imagepaths; %#ok<NASGU>
    save([p f],'imagestack');
    disp('Image Export Complete');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in left_check.
function left_check_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    handles = leftrightbutton(handles);
    handles = updateangles(handles,'update');
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end
    
varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in right_check.
function right_check_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    handles = leftrightbutton(handles);
    handles = updateangles(handles,'update');
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in fs_toggle.
function fs_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 0
        set(hObject,'string','Slow');
    else
        set(hObject,'string','Fast');
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


function angle_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function angle_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in individual_toggle.
function individual_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        button = 1;
        handles.activeobject = [];
        while button ~= 3
            [xtemp,ytemp,button]   = ginput(1);
            if button ~= 3
                handles.activeobject = [handles.activeobject; findnearestobject(handles.currentatlas,[xtemp ytemp])];        
                if ~isempty(handles.activeobject) && handles.activeobject(1) == 1
                    disp('Selected a point to move.');
                    trans                = movepointtrans(handles);
                    handles.currentatlas = delete_regions(handles.currentatlas);
                    handles.currentatlas =   draw_regions(handles.currentatlas,trans);
                    handles.activeobject = [];
                    handles = delete_blueobjects(handles,'both');
                    guidata(hObject,handles);
                elseif ~isempty(handles.activeobject) && handles.activeobject(1) == 2
                    disp(['Selected region ',handles.currentatlas{handles.activeobject(end,2)}{1},' to move.']);
                    set(handles.left_check,'value',0);
                    set(handles.right_check,'value',0);
                    handles = leftrightbutton(handles);
                else
                    disp('Did not select a point or region.');
                    button = 3;
                    set(hObject,'value',0);

                end
                guidata(hObject,handles);
            else
                if isempty(handles.activeobject)
                    set(hObject,'value',0);
                end
                guidata(hObject,handles);
            end
        end
    else

        handles.activeobject = [];

        set(handles.left_check,'value',1);
        set(handles.right_check,'value',1);
        handles = leftrightbutton(handles);
    end

    handles = updateangles(handles,'update');
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in fixedpoints_toggle.
function fixedpoints_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    if ~isfield(handles,'currentatlas') || isempty(handles.currentatlas) || get(handles.atlas_toggle,'value') == 1
        disp('You must load an atlas before defining fixed points.');
        return;
    end

    button    = 1;
    allpoints = getregionpoints(handles.currentatlas);


    disp('Select atlas points you want to be fixed.');
    while button ~= 3
        [xtemp1,ytemp1,button] = ginput(1);
        if button ~= 3
            obj = findnearestobject(handles.currentatlas,[xtemp1 ytemp1],'point');
            if obj(1) ~= 1; disp('You Must Select A Point'); return; end

            if ~isempty(handles.fixedpoints{1})
                tempsum = findpointinlist(allpoints(obj(2),:),handles.fixedpoints{1});
            else
                tempsum = [];
            end

            if ~isempty(tempsum)
                %This is a duplicate point, delete it.
                for i = 1:length(tempsum)
                    try delete(handles.blackcircles(tempsum(i))); end %#ok<TRYNC>
                end
                handles.blackcircles(tempsum)     = [];
                handles.fixedpoints{1}(tempsum,:) = [];

            else
                %This is a new point, add it.
                if ~isempty(handles.mobilepoints{1})
                    tempsum2 = findpointinlist(allpoints(obj(2),:),handles.mobilepoints{1});
                    if ~isempty(tempsum2)
                        %This is a mobile point, delete it first.
                        for i = 1:length(tempsum2)
                            try delete(handles.bluecircles(tempsum2(i))); end %#ok<TRYNC>
                            try delete(handles.bluelines(tempsum2(i))); end %#ok<TRYNC>
                            pause(0.01);
                        end
                        handles.bluecircles(tempsum2)       = [];
                        handles.bluelines(tempsum2)         = [];
                        handles.mobilepoints{1}(tempsum2,:) = [];
                        handles.mobilepoints{2}(tempsum2,:) = [];
                    end
                end

                handles.fixedpoints{1}(end+1,:) = allpoints(obj(2),:); %#ok<AGROW>
                handles.blackcircles(end+1) = rectangle('Position',...
                    [handles.fixedpoints{1}(end,1)-10,handles.fixedpoints{1}(end,2)-10,20,20],...
                    'Curvature',1,'EdgeColor','k','LineWidth',3);
            end
        end 
    end

    handles.fixedpoints{2} =  handles.fixedpoints{1};
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in mobilepoints_toggle.
function mobilepoints_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    if ~isfield(handles,'currentatlas') || isempty(handles.currentatlas) || get(handles.atlas_toggle,'value') == 1
        disp('You must load an atlas before defining mobile points.');
        return;
    end

    button    = 1;
    allpoints = getregionpoints(handles.currentatlas);
    while button ~= 3
        [xtemp1,ytemp1,button] = ginput(1);
        if button ~= 3
            obj = findnearestobject(handles.currentatlas,[xtemp1 ytemp1],'point');
            if obj(1) ~= 1; disp('You Must Select A Point'); return; end

            if ~isempty(handles.mobilepoints{1})
                tempsum = findpointinlist(allpoints(obj(2),:),handles.mobilepoints{1});
            else
                tempsum = [];
            end

            if ~isempty(tempsum)
                %This is a duplicate point, delete it.
                for i = 1:length(tempsum)
                    try delete(handles.bluecircles(tempsum(i))); end %#ok<TRYNC>
                    try delete(handles.bluelines(tempsum(i)));   end %#ok<TRYNC>
                end
                handles.bluecircles(tempsum)       = [];
                handles.bluelines(tempsum)         = [];
                handles.mobilepoints{1}(tempsum,:) = [];
                handles.mobilepoints{2}(tempsum,:) = [];
            else
                %This is a new point, add it.
                if ~isempty(handles.fixedpoints{1})
                    tempsum2 = findpointinlist(allpoints(obj(2),:),handles.fixedpoints{1});
                    if ~isempty(tempsum2)
                        %This is a fixed point, delete it first.
                        for i = 1:length(tempsum2)
                            try delete(handles.blackcircles(tempsum2(i))); end %#ok<TRYNC>
                            pause(0.01);
                        end
                        handles.blackcircles(tempsum2)     = [];
                        handles.fixedpoints{1}(tempsum2,:) = [];
                        handles.fixedpoints{2}(tempsum2,:) = [];
                    end
                end

                handles.mobilepoints{1}(end+1,:) = allpoints(obj(2),:); %#ok<AGROW>

                handles.bluecircles(end+1) = rectangle('Position',...
                    [handles.mobilepoints{1}(end,1)-10,handles.mobilepoints{1}(end,2)-10,20,20],...
                    'Curvature',1,'EdgeColor','b','LineWidth',3);

                [ytemp2,xtemp2,button] = ginput(1);
                ytemp2 = round(ytemp2);
                xtemp2 = round(xtemp2);
                if button == 3
                    disp('Mobile Point Identification Terminated by User.');
                    handles = delete_blueobjects(handles,'mobile');
                    guidata(hObject,handles);
                    return;
                end
                handles.mobilepoints{2}(end+1,:) = [ytemp2,xtemp2]; %#ok<AGROW>

                handles.bluelines(end+1) = line([handles.mobilepoints{1}(end,1) handles.mobilepoints{2}(end,1)],...
                    [handles.mobilepoints{1}(end,2) handles.mobilepoints{2}(end,2)],'color','b','linewidth',3);
            end
        end 
    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in warp_button.
function warp_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>
oldH = handles;

try
    if isempty(handles.mobilepoints{1});
        disp('No Mobile Points defined.');
        return;
    end
    set(gcf,'Pointer','watch'); pause(0.01);

    oldpoints = [handles.mobilepoints{1}; handles.fixedpoints{1}];
    newpoints = [handles.mobilepoints{2}; handles.fixedpoints{2}];

    if numel(oldpoints) == 0 || numel(newpoints) == 0
        set(gcf,'Pointer','arrow');
        return;
    end

    disp('Calculating warp function...');
    trans = warpimage(oldpoints,newpoints,handles);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    allpoints = getregionpoints(handles.currentatlas);

    for i = 1:length(handles.mobilepoints{2})
        obj = findnearestobject(handles.currentatlas,...
            [handles.mobilepoints{2}(i,1) handles.mobilepoints{2}(i,2)],'point');
        handles.fixedpoints{1}(end+1,:) = allpoints(obj(2),:);
        handles.blackcircles(end+1) = rectangle('Position',...
                [handles.fixedpoints{1}(end,1)-10,handles.fixedpoints{1}(end,2)-10,20,20],...
                'Curvature',1,'EdgeColor','k','LineWidth',3);
    end
    handles.fixedpoints{2} = handles.fixedpoints{1};

    handles = delete_blueobjects(handles,'mobile');
    handles = redraw_blueobjects(handles,'fixed');

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in surfacewarp_button.
function surfacewarp_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    warning('off','all')
    slice = get(handles.slice_slider,'value');
    if isfield(handles,'surface'); p = handles.surface{slice}; 
    else return;
    end

    if size(p,1) > 2000
        pnew = p(round(1:size(p,1)/2000:size(p,1)),:);
        p = pnew;
    end

    regions = handles.currentatlas;
    for r = 1:length(regions)
        if     get(handles.left_check,'value')==1 && get(handles.right_check,'value')==1
            if strcmp(handles.currentatlas{r}{1},'Whole Section') == 1; break; end
        elseif get(handles.left_check,'value')==1 && get(handles.right_check,'value')==0
            if strcmp(handles.currentatlas{r}{1},'Whole Left') == 1; break; end
        elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==1
            if strcmp(handles.currentatlas{r}{1},'Whole Right') == 1; break; end
        elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==0
            if strcmp(handles.currentatlas{r}{1},'Whole Section') == 1; break; end
        end
    end

    points    = round(handles.currentatlas{r}{2});
    allpoints = getregionpoints(handles.currentatlas);

    doublepoint = [];
    for i = 2:size(points,1)
        if points(i,:) == points(i-1,:); doublepoint = [doublepoint i]; end %#ok<AGROW>
    end
    points(doublepoint,:) = [];

    disp('Waiting for user to click atlas-surface point pairs...');

    button = 1;
    cnt = 0;
    pointa = [];
    pointb = [];
    while button ~= 3
        [xtemp1,ytemp1,button] = ginput(1);
        if button ~= 3
            cnt         = cnt + 1;
            pointa{cnt} = findnearestobject(handles.currentatlas,[xtemp1 ytemp1],'point'); %#ok<AGROW>
            if pointa{cnt}(1) ~= 1; disp('You Must Select A Point'); return; end

            temp1 = zeros(size(points,1),1);
            temp2 = zeros(size(points,1),1);
            temp1(points(:,1) == allpoints(pointa{cnt}(2),1)) = 1;
            temp2(points(:,2) == allpoints(pointa{cnt}(2),2)) = 1;
            if isempty(find(sum([temp1 temp2],2) == 2,1))
                disp(['ERROR: You must select points from ',handles.currentatlas{r}{1},' surface.']);
                pointa(cnt) = []; %#ok<AGROW>
                cnt = cnt - 1;
                continue;
            end

            handles.bluecircles(cnt) = rectangle('Position',...
                [allpoints(pointa{cnt}(2),1)-10,allpoints(pointa{cnt}(2),2)-10,20,20],...
                'Curvature',1,'EdgeColor','b','LineWidth',3);

            [ytemp2,xtemp2,button] = ginput(1);
            if button == 3; 
                disp('Surface Warp Terminated by User.');
                handles = delete_blueobjects(handles);
                guidata(hObject,handles);
                return; 
            end
            dtemp = zeros(size(p,1),1);
            for temp = 1:size(p,1);
                dtemp(temp) = pdist([xtemp2 ytemp2; p(temp,:)]);
            end

            pointb{cnt} = find(dtemp == min(dtemp)); %#ok<AGROW>
            handles.bluelines(cnt) = line([allpoints(pointa{cnt}(2),1) p(pointb{cnt},2)],...
                [allpoints(pointa{cnt}(2),2) p(pointb{cnt},1)],'color','b','linewidth',3);

        end 
    end
    if isempty(pointa) || isempty(pointb)
        disp('No atlas-surface point pairs defined.');
        return;
    end

    pointa{end+1} = pointa{1};
    pointb{end+1} = pointb{1};
    newpoints = [];

    set(gcf,'Pointer','watch'); pause(0.01);    
    disp('Registering atlas surface to histology surface...');
    for br = 1:length(pointa)-1

        coords   = allpoints(pointa{br}(2),:);
        for temp = 1:size(points,1)
            if points(temp,:) == coords; break; end
        end
        starta(br) = temp; %#ok<AGROW>

        coords    = allpoints(pointa{br+1}(2),:);
        for temp = 1:size(points,1)
            if points(temp,:) == coords; break; end
        end
        stopa(br) = temp; %#ok<AGROW>

        if stopa(br) > starta(br)
            pointst = points(starta(br):stopa(br),:);
        else
            pointst = [points(starta(br):end-1,:); points(1:stopa(br),:)];
        end

        da = pdist(pointst);
        da = squareform(da);
        ca = 0;
        for i=1:length(da)-1;
            ca = ca + da(i,i+1);
        end

        startb(br) = pointb{br}; %#ok<AGROW>
        stopb(br)  = pointb{br + 1}; %#ok<AGROW>
        if stopb(br) > startb(br)
            pt = p(startb(br):stopb(br),:);
        else
            pt = [p(startb(br):end,:); p(1:stopb(br),:)];
        end

        db = pdist(pt);
        db = squareform(db);
        cb = 0;
        for i=1:length(db)-1;
            cb = cb + db(i,i+1);
        end

        newscale = cb / ca;

        scalemat = [newscale 0]; 
        for i = 1:25
            bold       = 1;
            bpoints{br}    = zeros(size(pointst,1)-1,1); %#ok<AGROW>
            bpoints{br}(1) = 1; %#ok<AGROW>
            for temp = 1:size(pointst,1)-2
                adist = da(temp,temp+1);
                bdif  = abs(db(bold+1:end,bold) - (adist * newscale));
                temp1 = diff(bdif);
                temp2 = temp1(1:end-1) ./ temp1(2:end);
                temp3 = find(temp2 < 0 | temp2 == Inf);
                if isempty(temp3) && all(temp1 > 0); temp3 = 0; end
                if (adist * newscale) < db(bold+2,bold); temp3 = 0; end
                if ~isempty(temp3)
                    bnew  = bold + find(bdif == min(bdif(temp3+1)),1,'first');
                    bpoints{br}(temp+1) = bnew; %#ok<AGROW>
                    bold                = bnew;
                    bnew                = []; %#ok<NASGU>
                else
                    break
                end
            end

            if ~isempty(find(bpoints{br} == 0,1))
                scalemat(find(scalemat(:,2) == 0),2) = 1; %#ok<FNDSB>
            else
                adist = da(end-1,end);
                bdist = db(bpoints{br}(end),end);

                if bdist < adist * newscale
                    scalemat(find(scalemat(:,2) == 0),2) = 1; %#ok<FNDSB>
                else
                    scalemat(find(scalemat(:,2) == 0),2) = -1; %#ok<FNDSB>
                end
            end

            newscale = [];
            for temp = 1:size(scalemat,1) - 1
                if scalemat(temp,2) == -1 && scalemat(temp+1,2) == 1
                    newscale = mean([scalemat(temp,1) scalemat(temp+1,1)]);
                    break;
                end
            end
            if isempty(newscale)
                if isempty(find(scalemat(:,2) == -1,1))
                    newscale = scalemat(1,1) / 5;
                end
                if isempty(find(scalemat(:,2) == 1,1))
                    newscale = scalemat(end,1) * 5;
                end
            end
            scalemat(end+1,:) = [newscale 0]; %#ok<AGROW>
            scalemat = sortrows(scalemat);

        end
        bpoints{br} = bpoints{br} + startb(br) - 1; %#ok<AGROW>
        for temp = 1:length(bpoints{br})
            if bpoints{br}(temp) > length(p)
                bpoints{br}(temp) = bpoints{br}(temp) - length(p); %#ok<AGROW>
            end
        end
        npoints{br} = p(bpoints{br},:); %#ok<AGROW>
        newpoints(end+1:end+size(npoints{br},1),:) = npoints{br};
        if size(newpoints,1) > size(points,1)
            disp('Error: You probably clicked the points in the wrong direction.');
            handles = delete_blueobjects(handles,'both');
            guidata(hObject,handles);
            return;
        end
    end

    disp('Calculating warp function...');
    oldpoints = [points(starta(1):end-1,:); points(1:starta-1,:)];
    newpoints = [newpoints(:,2) newpoints(:,1)];
    
    if strcmp(get_atlas_property('surface_warp'),'add centroid')
        good = [];
        for r = 1:length(regions)
            if     get(handles.left_check,'value')==1 && get(handles.right_check,'value')==1
                if strcmp(handles.currentatlas{r}{1},'Whole Left') == 1; good(end+1)=r; end %#ok<AGROW>
                if strcmp(handles.currentatlas{r}{1},'Whole Right') == 1; good(end+1)=r; end %#ok<AGROW>
            elseif get(handles.left_check,'value')==1 && get(handles.right_check,'value')==0
                if strcmp(handles.currentatlas{r}{1},'Whole Left') == 1; good=r; break; end
            elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==1
                if strcmp(handles.currentatlas{r}{1},'Whole Right') == 1; good=r; break; end
            elseif get(handles.left_check,'value')==0 && get(handles.right_check,'value')==0
                if strcmp(handles.currentatlas{r}{1},'Whole Section') == 1; good=r; break; end
            end
        end

        otemp = zeros(size(oldpoints,1),length(good));
        for r=1:length(good)
            ptemp = round(regions{good(r)}{2});
            for p = 1:size(ptemp,1)
                for i = 1:size(oldpoints)
                    if sum(oldpoints(i,:) == ptemp(p,:)) == 2; otemp(i,r) = 1; end
                end
            end
        end

        for r = 1:length(good)
            oldpoints(end+1,:) = centroid(oldpoints(otemp(:,r) == 1,:)); %#ok<AGROW>
            newpoints(end+1,:) = centroid(newpoints(otemp(:,r) == 1,:)); %#ok<AGROW>
        end
    end
    
    trans = warpimage(oldpoints,newpoints,handles);

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas,trans);

    handles = delete_blueobjects(handles,'both');
    set(handles.locksurface_check,'value',0)

    guidata(hObject,handles);
    disp('Surface warp complete.');
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in locksurface_check.
function locksurface_check_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    allpoints = getregionpoints(handles.currentatlas);
    t  = ones(size(allpoints));
    t  = locksurfacepoints(t,handles);
    s  = sum(t,2);
    tempfixed = allpoints(s==0,:);

    if get(handles.locksurface_check,'value') == 1
        disp('Registering surface points as fixed points...');

        for p = 1:size(tempfixed,1)
            if ~isempty(handles.fixedpoints{1}) 
                temp = findpointinlist(tempfixed(p,:),handles.fixedpoints{1});
                if ~isempty(temp); continue; end
            end
            if ~isempty(handles.mobilepoints{1})
                tempsum2 = findpointinlist(tempfixed(p,:),handles.mobilepoints{1});
                if ~isempty(tempsum2)
                    %This is a mobile point, delete it first.
                    for i = 1:length(tempsum2)
                        try delete(handles.bluecircles(tempsum2(i))); end %#ok<TRYNC>
                        try delete(handles.bluelines(tempsum2(i))); end %#ok<TRYNC>
                        pause(0.01);
                    end
                    handles.bluecircles(tempsum2)       = [];
                    handles.bluelines(tempsum2)         = [];
                    handles.mobilepoints{1}(tempsum2,:) = [];
                    handles.mobilepoints{2}(tempsum2,:) = [];
                end
            end

            handles.fixedpoints{1}(end+1,:) = tempfixed(p,:);
            
            handles.blackcircles(end+1) = rectangle('Position',...
                [handles.fixedpoints{1}(end,1)-10,handles.fixedpoints{1}(end,2)-10,20,20],...
                'Curvature',1,'EdgeColor','k','LineWidth',3);
        end
        pause(0.001);
    else
        disp('Removing surface points as fixed points...');
        surfacepoints = [];
        for p = 1:size(tempfixed,1)
            if ~isempty(handles.fixedpoints{1}) 
                temp = findpointinlist(tempfixed(p,:),handles.fixedpoints{1});
                if ~isempty(temp); 
                   surfacepoints = [surfacepoints temp];  %#ok<AGROW>
                end
            end
        end
        if ~isempty(surfacepoints)
            for i = 1:length(surfacepoints)
                try delete(handles.blackcircles(surfacepoints(i))); end %#ok<TRYNC>
            end
            handles.blackcircles(surfacepoints) = [];
            handles.fixedpoints{1}(surfacepoints,:) = [];
        end
        pause(0.001);
    end


    handles.fixedpoints{2} = handles.fixedpoints{1};
    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in findsurface_button.
function findsurface_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,DEFNU>
oldH = handles;

try
    disp('Click on histological section.');
    waitforbuttonpress;
    click = get(handles.axes1,'CurrentPoint');
    slice = get(handles.slice_slider,'value');

    set(gcf,'Pointer','watch'); pause(0.01);
    if isfield(handles,'surfacehandle'); try delete(handles.surfacehandle{slice}); end; end %#ok<TRYNC>
    I = imread(handles.imagepaths{slice});
    T = get(handles.surface_slider,'value');
    V = [];
    if     get(handles.r_check,'value') == 1; V = 1;
    elseif get(handles.g_check,'value') == 1; V = 2;
    elseif get(handles.b_check,'value') == 1; V = 3;
    elseif get(handles.h_check,'value') == 1; V = 4;
    elseif get(handles.s_check,'value') == 1; V = 5;
    elseif get(handles.v_check,'value') == 1; V = 6;    
    end
    GL = get(handles.greaterless_toggle,'value');
    if isempty(V); disp('Must select color channel before finding surface.'); set(gcf,'Pointer','arrow'); return; end

    [b c] = findboundary(I,T,click,V,GL);
    if isempty(b); disp('Boundary not returned by findboundary'); set(gcf,'Pointer','arrow'); return; end

    b     = perimdirection(b,c,'ccw');
    if isempty(b); disp('Boundary not returned by perimdirection'); set(gcf,'Pointer','arrow'); return; end

    h = patch(b(:,2),b(:,1),[1 1 1],'EdgeColor','r','FaceColor','none','LineWidth',2);
    handles.surface{slice} = b;
    handles.surfacehandle{slice} = h;

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on slider movement.
function surface_slider_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    T = get(handles.surface_slider,'value');
    set(handles.surfacethreshold_edit,'string',num2str(T));
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes during object creation, after setting all properties.
function surface_slider_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function surfacethreshold_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function surfacethreshold_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in slice_toggle.
function slice_toggle_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes on button press in atlas_toggle.
function atlas_toggle_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
oldH = handles;

try
    handles = updateatlasbutton(handles,1);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in outlineregion_button.
function outlineregion_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    slice = get(handles.slice_slider,'value');
    if ~isempty(handles.userregionh{slice}); 
        answer = questdlg('Add another region?','Region already exists on this slice.','Add','Replace','Cancel','Replace');
        if strcmp(answer,'Replace')
            for r = 1:length(handles.userregionh{slice})
                delete(handles.userregionh{slice}{r}); 
            end
            handles.userregionh{slice} = [];
            handles.userregion{slice}  = [];
        elseif strcmp(answer,'Cancel')
            return;
        end
    end

    h = figure; 
    imshow(handles.image);
    if isfield(handles,'surface') && ~isempty(handles.surface{slice})
        m = max(handles.surface{slice});
        n = min(handles.surface{slice});
        axis([n(2) m(2) n(1) m(1)]);
    end

    [BW, xi, yi] = roipoly;
    close(h);
    handles.userregion{slice}{end+1}  = [xi,yi];
    handles.userregionh{slice}{end+1} = line(xi,yi,'color','g','LineWidth',3);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in deleteregion_button.
function deleteregion_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    slice = get(handles.slice_slider,'value');
    for r = 1:length(handles.userregionh{slice})
        delete(handles.userregionh{slice}{r}); 
    end
    handles.userregionh{slice} = [];
    handles.userregion{slice}  = [];
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in resetpoints_button.
function resetpoints_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    handles = delete_blueobjects(handles,'both');
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in unlockatlas_button.
function unlockatlas_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    slice = get(handles.slice_slider,'value');
    handles.lockedatlas{slice}    = [];
    handles.lockedflip{slice}     = [];
    handles.lockedangles{slice}   = [];
    handles.lockedatlasnum{slice} = [];
    handles.lockedleftright{slice}= [1 1];
    handles = updateatlasbutton(handles,0);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in lockatlas_button.
function lockatlas_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>
oldH = handles;

try
    slice = get(handles.slice_slider,'value');
    handles.lockedatlas{slice}    = handles.currentatlas;
    handles.lockedatlasnum{slice} = get(handles.atlas_slider,'value');
    handles.lockedflip{slice}     = handles.currentflip;
    handles.lockedangles{slice}   = handles.currentangles;
    handles.lockedleftright{slice}= [get(handles.left_check,'value') get(handles.right_check,'value')];
    handles = updateatlasbutton(handles,0);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in loaduserdata_button.
function loaduserdata_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>
oldH = handles;

try
    [f p] = uigetfile;
    if f == 0; return; end
    set(gcf,'Pointer','watch'); pause(0.01);

    cd(p);
    load([p f])
    if ~exist('atlas','var')
        disp(['Error: File loaded  ',[p f],'  does not contain atlas data']);
        return;
    end

    if isfield(handles,'currentatlas');
        handles.currentatlas = delete_regions(handles.currentatlas);
    end

    try handles.lockedatlas     = atlas.lockedatlas;    end %#ok<TRYNC>
    try handles.lockedatlasnum  = atlas.lockedatlasnum; end %#ok<TRYNC>
    try handles.lockedflip      = atlas.lockedflip;     end %#ok<TRYNC>
    try handles.lockedangles    = atlas.lockedangles;   end %#ok<TRYNC>
    try %#ok<TRYNC>
        if isfield(atlas,'lockedleftright');  
            handles.lockedleftright = atlas.lockedleftright;
        else
            for i = 1:length(atlas.lockedatlas)
                handles.lockedleftright{i} = [1 1];
            end
        end
    end
    try handles.region          = atlas.region;         end %#ok<TRYNC>
    try handles.numregions      = atlas.numregions;     end %#ok<TRYNC>
    try handles.leftright       = atlas.leftright;      end %#ok<TRYNC>
    try handles.pointpairs      = atlas.pointpairs;     end %#ok<TRYNC>
    try handles.atlaspath       = atlas.atlaspath;      end %#ok<TRYNC>
    try handles.currentatlas    = atlas.currentatlas;   end %#ok<TRYNC>
    try handles.currentpairs    = atlas.currentpairs;   end %#ok<TRYNC>
    try handles.currentflip     = atlas.currentflip;    end %#ok<TRYNC>
    try handles.currentangles   = atlas.currentangles;  end %#ok<TRYNC>
    try handles.atlas_previous  = atlas.atlas_previous; end %#ok<TRYNC>
    try handles.imagepaths      = atlas.imagepaths;     end %#ok<TRYNC>
    
    try currentatlasnum         = atlas.currentatlasnum; end %#ok<TRYNC>

    try %#ok<TRYNC>
        if handles.numregions > 5
            set(handles.atlas_slider,'Min',1,'Max',handles.numregions,'value',currentatlasnum,...
                'SliderStep',[1/(handles.numregions-1) 5/(handles.numregions-1)],'enable','on');
        else
            set(handles.atlas_slider,'Min',1,'Max',handles.numregions,'value',currentatlasnum,...
                'SliderStep',[1/(handles.numregions-1) 1/(handles.numregions-1)],'enable','on');    
        end
        set(handles.atlascount_edit,'string',num2str(currentatlasnum));
    end

    try handles.currentatlas = draw_regions(handles.currentatlas); end %#ok<TRYNC>
    guidata(hObject,handles);    
    set(gcf,'Pointer','arrow');

    if ~isempty(handles.imagepaths) %~isfield(handles,'imagepaths') || strcmp(handles.imagepaths{1},atlas.imagepaths{1}) == 0
        answer = questdlg('Do you want to load the image file associated with this atlas data?',...
            '','Yes','No','Cancel','Yes');
        if strcmp(answer,'Yes')
            set(gcf,'Pointer','watch'); pause(0.01);

            if exist(atlas.imagepaths{1},'file') ~= 2;
                disp(['File ',atlas.imagepaths{1},' does not appear to exist.']);
                return;
            end
            [pathstr name ext versn] = fileparts(atlas.imagepaths{1}); %#ok<NASGU>

            handles.image      = imread(atlas.imagepaths{1});
            handles.imagepaths = atlas.imagepaths;
            handles.numslices  = length(handles.imagepaths);

            set(handles.slice_slider,'Min',1,'Max',2,'value',1,'Enable','off');
            if handles.numslices > 5
                set(handles.slice_slider,'Enable','on','Max',handles.numslices,...
                    'SliderStep',[1/(handles.numslices-1) 5/(handles.numslices-1)]);
            elseif handles.numslices > 1
                set(handles.slice_slider,'Enable','on','Max',handles.numslices,...
                    'SliderStep',[1/(handles.numslices-1) 1/(handles.numslices-1)]);    
            end
            set(handles.slicecount_edit,'string','1');
            set(handles.imagehandle,'cdata',handles.image);
            set(handles.imagefile_edit,'string',name);
            handles.slice_previous = handles.numslices;
            handles.imagesize      = size(handles.image);

            try handles.surface       = atlas.surface;        end %#ok<TRYNC>
            try handles.surfacehandle = atlas.surfacehandle;  end %#ok<TRYNC>
            try handles.userregion    = atlas.userregion;     end %#ok<TRYNC>
            try handles.userregionh   = atlas.userregionh;    end %#ok<TRYNC>
            try handles.manualcount   = atlas.manualcount;    end %#ok<TRYNC>
            try handles.countcolor    = atlas.countcolor;     end %#ok<TRYNC>
            
            handles = update_manualcount(handles,1);
            
            if ~isempty(handles.surfacehandle{1})
                h = patch(handles.surface{1}(:,2),handles.surface{1}(:,1),[1 1 1],...
                    'EdgeColor','r','FaceColor','none','LineWidth',2);
                handles.surfacehandle{1} = h;
            end
            if ~isempty(handles.userregionh{1})
                for r = 1:length(handles.userregionh{1})
                    xi = handles.userregion{1}{r}(:,1);
                    yi = handles.userregion{1}{r}(:,2);
                    handles.userregionh{1}{r} = line(xi,yi,'color','g','LineWidth',3);
                end
            end

            axis([1 handles.imagesize(2) 1 handles.imagesize(1)]);
        end
    end

    guidata(hObject,handles);   
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in flatcorr_button.
function flatcorr_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    slice = get(handles.slice_slider,'value');
    disp('Please select the flat field image.');
    [f p] = uigetfile('*.tif');
    flat  = imread([p f]);
    answer = questdlg('Which images would you like to flatten?','','Current','All','None','Current');
    if strcmp(answer,'All')
        rng = 1:1:length(handles.imagepaths);
    elseif strcmp(answer,'Current')
        rng = slice;
    else
        return;
    end

    for s = rng
        imtemp = imread(handles.imagepaths{s});
        imtemp = flatcorr(imtemp,flat,0);

        set(handles.slice_slider,'value',s);
        set(handles.slicecount_edit,'string',num2str(s));
        set(handles.imagehandle,'cdata',imtemp);

        handles = save_modified_image(handles,imtemp);
    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in modifybound_button.
function modifybound_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>
oldH = handles;

try
    button    = 1;
    for r = 1:length(handles.currentatlas)
        if strcmp(handles.currentatlas{r},'Whole Section'); break; end
    end
    points    = round(handles.currentatlas{r}{2});
    allpoints = getregionpoints(handles.currentatlas);

    while button ~= 3
        [xtemp1,ytemp1,button] = ginput(1);
        if button ~= 3

            p1 = findnearestobject(handles.currentatlas,[xtemp1 ytemp1],'point');
            if p1(1) ~= 1; disp('You Must Select A Point'); return; end
            for p = 1:size(points,1)
                if allpoints(p1(2),:) == points(p,:); bp1 = p; end
            end
            closed = 0;
            ptemp  = [];
            while closed == 0
                [xtemp2,ytemp2,button] = ginput(1);
                temp = findnearestobject(handles.currentatlas,[xtemp2 ytemp2],'point');
                if temp(1) ~= 1; disp('You Must Select A Point'); return; end

                ptemp(end+1) = temp(2); %#ok<AGROW>
                for p = 1:size(points,1)
                    if allpoints(ptemp(end),:) == points(p,:); bp2 = p; closed = 1; end
                end
            end

            if length(ptemp) == 1
                if abs(bp1 - bp2)-1 < size(points,1)/2
                    if bp1<bp2; pnew = points([1:bp1,bp2:end],:);
                    else        pnew = points([1:bp2,bp1:end],:);
                    end
                else
                    if bp1<bp2; pnew = points(bp1:bp2,:);
                    else        pnew = points(bp2:bp1,:);
                    end
                end
            else
                if abs(bp1 - bp2)-1 < size(points,1)/2
                    if bp1<bp2; pnew = [points(1:bp1,:); allpoints(ptemp(1:end-1),:);    points(bp2:end,:)];
                    else        pnew = [points(1:bp2,:); allpoints(ptemp(end-1:-1:1),:); points(bp1:end,:)];
                    end
                else
                    if bp1<bp2; pnew = [points(bp1:bp2,:); allpoints(ptemp(end-1:-1:1),:)];
                    else        pnew = [points(bp2:bp1,:); allpoints(ptemp(1:end-1),:)];
                    end
                end
            end

            if sum(pnew(1,:) ~= pnew(end,:)) > 0; pnew(end+1,:) = pnew(1,:); end %#ok<AGROW>

            handles.currentatlas{r}{2} = pnew;
            handles.currentatlas = delete_regions(handles.currentatlas);
            handles.currentatlas =   draw_regions(handles.currentatlas);
            points = pnew;
            pause(0.1);
        end 
    end

    handles.currentpairs   = findpointpairs(handles.currentatlas);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in h_check.
function h_check_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(handles.s_check,'value',0);
        set(handles.v_check,'value',0);
        set(handles.r_check,'value',0);
        set(handles.g_check,'value',0);
        set(handles.b_check,'value',0);
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in s_check.
function s_check_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(handles.h_check,'value',0);
        set(handles.v_check,'value',0);
        set(handles.r_check,'value',0);
        set(handles.g_check,'value',0);
        set(handles.b_check,'value',0);
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in v_check.
function v_check_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(handles.h_check,'value',0);
        set(handles.s_check,'value',0);
        set(handles.r_check,'value',0);
        set(handles.g_check,'value',0);
        set(handles.b_check,'value',0);
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in r_check.
function r_check_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(handles.h_check,'value',0);
        set(handles.s_check,'value',0);
        set(handles.v_check,'value',0);
        set(handles.g_check,'value',0);
        set(handles.b_check,'value',0);
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in g_check.
function g_check_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(handles.h_check,'value',0);
        set(handles.s_check,'value',0);
        set(handles.v_check,'value',0);
        set(handles.r_check,'value',0);
        set(handles.b_check,'value',0);
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in b_check.
function b_check_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(handles.h_check,'value',0);
        set(handles.s_check,'value',0);
        set(handles.v_check,'value',0);
        set(handles.r_check,'value',0);
        set(handles.g_check,'value',0);
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in hsv_button.
function hsv_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,DEFNU>
oldH = handles;

try
    F = gcf;
    set(gcf,'Pointer','watch'); pause(0.01);
    slice = get(handles.slice_slider,'value');
    I = handles.image;
    disp('Performing HSV Conversion...');
    [Ih, Is, Iv] = rgb2hsv(I);

    filtsize = str2num(get_atlas_property('lowpass_filter_size')); %#ok<ST2NM>
    filtstd  = str2num(get_atlas_property('lowpass_standard_deviation')); %#ok<ST2NM>

    disp('Performing Lowpass Filter...');
    h = imfilter(Ih,fspecial('gaussian',filtsize,filtstd));
    figure; imagesc(h); colorbar;
    title(['Hue image slice ',num2str(slice)]);

    s = imfilter(Is,fspecial('gaussian',filtsize,filtstd));
    figure; imagesc(s); colorbar;
    title(['Saturation image slice ',num2str(slice)]);

    v = imfilter(Iv,fspecial('gaussian',filtsize,filtstd));
    figure; imagesc(v); colorbar;
    title(['Value image slice ',num2str(slice)]);
    set(F,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in rgb_button.
function rgb_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,DEFNU>
oldH = handles;

try
    F = gcf;
    set(gcf,'Pointer','watch'); pause(0.01);
    slice = get(handles.slice_slider,'value');
    I = handles.image;
    if     isa(I, 'uint8');      n = 255;
    elseif isa(I, 'uint16');     n = 65535;
    elseif max(max(max(I))) > 1; n = max(max(max(I)));
    else                         n = 1;
    end

    filtsize = str2num(get_atlas_property('lowpass_filter_size')); %#ok<ST2NM>
    filtstd  = str2num(get_atlas_property('lowpass_standard_deviation')); %#ok<ST2NM>

    disp('Performing Lowpass Filter...');
    r = imfilter(I(:,:,1),fspecial('gaussian',filtsize,filtstd));
    r = double(r) / n;
    figure; imagesc(r); colorbar;
    title(['Red image slice ',num2str(slice)]);

    g = imfilter(I(:,:,2),fspecial('gaussian',filtsize,filtstd));
    g = double(g) / n;
    figure; imagesc(g); colorbar;
    title(['Green image slice ',num2str(slice)]);

    b = imfilter(I(:,:,3),fspecial('gaussian',filtsize,filtstd));
    b = double(b) / n;
    figure; imagesc(b); colorbar;
    title(['Blue image slice ',num2str(slice)]);
    set(F,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in greaterless_toggle.
function greaterless_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    p = handles.buttonpath;
    if get(handles.greaterless_toggle,'value') == 1
        try %#ok<TRYNC>
            load([p 'GR.mat']);
            set(handles.greaterless_toggle,'Cdata',x);
            set(handles.greaterless_toggle,'string','');
        end
    else
        try %#ok<TRYNC>
            load([p 'LS.mat']);
            set(handles.greaterless_toggle,'Cdata',x);
            set(handles.greaterless_toggle,'string','');
        end
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in cleanatlas_button.
function cleanatlas_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    c = get(handles.axes1,'children');
    for i=1:length(c); 
        t = get(c(i),'type'); 
        if strcmp(t,'image') == 0
            delete(c(i));
        end
    end
    disp('All objects deleted from image.');
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in flipvert_button.
function flipvert_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    if get(handles.atlas_toggle,'value') == 1 || ~isfield(handles,'region')
        %flipping the image;
        disp('Flipping Image. Please wait...');
        If = flipimage(handles,'vert');
        handles = save_modified_image(handles,If);

    else
        atlas = get(handles.atlas_slider,'value');
        trans = fliptrans(handles,'vert');

        handles.currentatlas = delete_regions(handles.currentatlas);
        handles.currentatlas =   draw_regions(handles.currentatlas,trans);

        handles = updatecurrentflip(handles,'vert');
        for r = 1:length(handles.currentatlas)
            handles.currentatlas{r}{2} = perimdirection(handles.currentatlas{r}{2},handles.currentatlas{r}{6},'cw');
        end
        handles.currentpairs = findpointpairs(handles.currentatlas,handles.leftright{atlas});
    end

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in fliphorz_button.
function fliphorz_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    set(gcf,'Pointer','watch'); pause(0.01);
    if get(handles.atlas_toggle,'value') == 1 || ~isfield(handles,'region')
        %flipping the image;
        disp('Flipping Image. Please wait...');
        If = flipimage(handles,'horz');
        handles = save_modified_image(handles,If);

    else
        atlas = get(handles.atlas_slider,'value');
        trans = fliptrans(handles,'horz');

        handles.currentatlas = delete_regions(handles.currentatlas);
        handles.currentatlas =   draw_regions(handles.currentatlas,trans);

        handles = updatecurrentflip(handles,'horz');
        for r = 1:length(handles.currentatlas)
            handles.currentatlas{r}{2} = perimdirection(handles.currentatlas{r}{2},handles.currentatlas{r}{6},'cw');
        end
        handles.currentpairs = findpointpairs(handles.currentatlas,handles.leftright{atlas});
    end

    guidata(hObject,handles);
    set(gcf,'Pointer','arrow');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in multiply_button.
function multiply_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
oldH = handles;

try
    if ~isfield(handles,'region'); disp('No Atlas Loaded.'); return; end
    mult = str2num(get(handles.multiply_edit,'string')); %#ok<ST2NM>
    if mult == 0; disp('Cannot multiply by 0.'); return; end
    if mult == 1;                                return; end
    if get(handles.atlas_toggle,'value')==1;     return; end

    answer = questdlg('Multiply which atlas pannel?','','Current','All','Cancel','Current');
    if strcmp(answer,'Cancel'); return; end

    disp(['Multiplying CURRENT atlas by ',num2str(mult)]);
    for r = 1:length(handles.currentatlas)
        handles.currentatlas{r}{2} = round(handles.currentatlas{r}{2} * mult);
        handles.currentatlas{r}{6} = round(handles.currentatlas{r}{6} * mult);
    end

    handles.currentatlas = delete_regions(handles.currentatlas);
    handles.currentatlas =   draw_regions(handles.currentatlas);

    if strcmp(answer,'All')
        disp(['Multiplying ALL atlas panels by ',num2str(mult)]);
        for a = 1:length(handles.region)
            for r = 1:length(handles.region{a})
                handles.region{a}{r}{2} = round(handles.region{a}{r}{2} * mult);
                handles.region{a}{r}{6} = round(handles.region{a}{r}{6} * mult);
            end
        end
    end

    handles = delete_blueobjects(handles,'both');
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


function multiply_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,INUSD,DEFNU>


% --- Executes during object creation, after setting all properties.
function multiply_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in atlaspredictor_toggle.
function atlaspredictor_toggle_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
oldH = handles;

try
    if get(hObject,'value') == 1
        set(hObject,'string','Atlas Predictor ON');
    else
        set(hObject,'string','Atlas Predictor Off');
    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in backwarp_button.
function backwarp_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    F = gcf;
    slice = get(handles.slice_slider,'value');
    atlas = get(handles.atlas_slider,'value');
    if isempty(handles.lockedatlas{slice})
        disp(['No locked atlas for slice ',num2str(slice)]);
        return;
    end
    if (length(handles.userregion) < slice || isempty(handles.userregion{slice})) && (length(handles.manualcount) < slice || isempty(handles.manualcount{slice}))
        disp(['No user region or manual count for slice ',num2str(slice)]);
        return;
    end

    set(gcf,'Pointer','watch'); pause(0.01);
    disp('Loading Raw Atlas.');
    load(handles.atlaspath);
    rawatlas = regions{atlas}; %#ok<USENS>

    for r = 1:length(rawatlas)
        rawatlas{r}{2} = perimdirection(rawatlas{r}{2},rawatlas{r}{6},'cw');
    end    

    usedatlas = handles.lockedatlas{slice};

    for r = 1:length(usedatlas)
        if handles.lockedflip{slice}(r) == 1
            usedatlas{r}{2} = perimdirection(usedatlas{r}{2},usedatlas{r}{6},'ccw');
        end
    end

    oldpoints = [];
    newpoints = [];
    urpoints  = [];
    mcpoints  = [];

    for r = 1:length(usedatlas)
        if strcmp(usedatlas{r}{1},'Whole Left')  ||...
           strcmp(usedatlas{r}{1},'Whole Right') ||...
           strcmp(usedatlas{r}{1},'Whole Section')
            continue;
        end
        oldpoints = [oldpoints; usedatlas{r}{2}]; %#ok<AGROW>
    end

    for r = 1:length(rawatlas)
        if strcmp(rawatlas{r}{1},'Whole Left')  ||...
           strcmp(rawatlas{r}{1},'Whole Right') ||...
           strcmp(rawatlas{r}{1},'Whole Section')
            continue;
        end
        newpoints = [newpoints; rawatlas{r}{2}]; %#ok<AGROW>
    end

    if sum(size(oldpoints) == size(newpoints)) ~= 2
        disp('There is a mismatch in the number of points between the current and raw atlas.');
        set(gcf,'Pointer','arrow');
        return;
    end

    if length(handles.userregion) >= slice && ~isempty(handles.userregion{slice})
        for r = 1:length(handles.userregion{slice})
            urpoints = [urpoints; handles.userregion{slice}{r}]; %#ok<AGROW>
        end
    end
    if length(handles.manualcount) >= slice && ~isempty(handles.manualcount{slice})
        for countid = 1:length(handles.manualcount{slice})
            for p = 1:length(handles.manualcount{slice}{countid})
                mcpoints = [mcpoints; handles.manualcount{slice}{countid}(p,:)]; %#ok<AGROW>
            end
        end
    end

    atlaspoints = getregionpoints(handles.lockedatlas{slice});
    allpoints   = [atlaspoints; urpoints; mcpoints];

    disp('Calculating Back Warp Function.');
    trans   = warpfilter3(oldpoints,newpoints,allpoints);
    transur = trans(size(atlaspoints,1)+1:size(atlaspoints,1)+size(urpoints),:);
    transmc = trans(size(atlaspoints,1)+size(urpoints)+1:end,:);
    
    if ~isempty(transur); newur = urpoints + transur; else newur = []; end
    if ~isempty(transmc); newmc = mcpoints + transmc; else newmc = []; end

    figure;
    if     atlas < 10;  anum = ['00',num2str(atlas)];
    elseif atlas < 100; anum = ['0',num2str(atlas)];
    else                anum = num2str(atlas);
    end
    rawatlaspath = get_atlas_property('raw_atlas_path');
    x = imread([rawatlaspath,anum,'.tif']);
    imshow(x);

    start = 1;
    if length(handles.userregion) >= slice && ~isempty(handles.userregion{slice})
        for r = 1:length(handles.userregion{slice})
            stop = start + size(handles.userregion{slice}{r}) - 1;
            ur{r}.coordinates = newur(start:stop,:); %#ok<AGROW>
            ur{r}.atlas       = atlas; %#ok<AGROW>
            line(newur(start:stop,1),newur(start:stop,2),'color','g','LineWidth',3);
            start = stop + 1;
        end
    end
    start = 1;
    if length(handles.manualcount) >= slice && ~isempty(handles.manualcount{slice})
        for countid = 1:length(handles.manualcount{slice})
            if isempty(handles.manualcount{slice}{countid}); continue; end
            stop = start + size(handles.manualcount{slice}{countid},1) - 1;
            mc{countid}.coordinates = newmc(start:stop,:); %#ok<AGROW>
            mc{countid}.atlas       = atlas; %#ok<AGROW>
            for p = start:stop
                rectangle('Position',[newmc(p,1)-2,newmc(p,2)-2,5,5],'Curvature',1,...
                    'EdgeColor','none','FaceColor',handles.countcolor{countid});
            end
            start = stop + 1;
        end
    end
            

    set(F,'Pointer','arrow');

    answer = questdlg('Do you want to save the back warped user region(s)?','','Yes','No','Cancel','Yes');
    if strcmp(answer,'No') || strcmp(answer,'Cancel'); return; end

    [f p] = uiputfile;
    save([p f],'ur');
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in erasearea_button.
function erasearea_button_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSD,DEFNU>
oldH = handles;

try
    I = handles.image;
    disp('Outline area to be erased.');
    [BW, xi, yi] = roipoly; %#ok<NASGU>
    pause(0.01);

    color = get_atlas_property('erased_area_color');
    if isa(I, 'uint8')
        if     strcmp(color,'white'); value = 255;
        elseif strcmp(color,'black'); value = 0;
        else                          value = str2num(color); %#ok<ST2NM>
        end
    elseif isa(I, 'uint16')
        if     strcmp(color,'white'); value = 65535;
        elseif strcmp(color,'black'); value = 0;
        else                          value = str2num(color); %#ok<ST2NM>
        end
    end
    if isempty(value); 
        disp(['Error: "erased_area_color" must be "black", "white", or a value. ',color,' is not recognized.']);
        return;
    end

    for c = 1:3
        temp = I(:,:,c);
        temp(BW == 1) = value;
        I(:,:,c) = temp;
    end

    set(handles.imagehandle,'cdata',I);

    answer = questdlg('Keep the modified image?','Area Erased','Yes','No','Yes');
    pause(0.01);
    if strcmp(answer,'Yes')
        handles = save_modified_image(handles,I);
    else
        slice = get(handles.slice_slider,'value');
        handles.image = imread(handles.imagepaths{slice});
        set(handles.imagehandle,'cdata',handles.image);
    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in pan_toggle.
function pan_toggle_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
oldH = handles;

try
    if get(hObject,'value') == 1
        pan on;
        try %#ok<TRYNC>
            load([handles.buttonpath 'pan_on.mat']);
            set(handles.pan_toggle,'Cdata',x); %#ok<NODEF>
            set(handles.pan_toggle,'string','');
        end    
    else
        pan off;
        try %#ok<TRYNC>
            load([handles.buttonpath 'pan.mat']);
            set(handles.pan_toggle,'Cdata',x); %#ok<NODEF>
            set(handles.pan_toggle,'string','');
        end
    end

    handles = updateimagesliders(handles);
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in manualcount_button.
function manualcount_button_Callback(hObject, eventdata, handles)
oldH = handles;

try
    slice   = get(handles.slice_slider,'value');
    countid = str2num(get(handles.countid_edit,'string')); %#ok<ST2NM>
    if isempty(countid) || round(countid) ~= countid || countid <= 0;
        disp('Count ID must be an integer.');
        return; 
    end
    button  = 1;
    if length(handles.manualcount) < slice || length(handles.manualcount{slice}) < countid; handles.manualcount{slice}{countid} = []; end
    if length(handles.whitedots)   < countid;                                               handles.whitedots{countid}          = []; end
    if length(handles.countcolor)  < countid || isempty(handles.countcolor{countid})
        color = inputdlg({'Red:','Green:','Blue:','Size'},'Dot Color',1,{'1','1','1','5'});
        if isempty(color); return; end
        for i = 1:4; color{i} = str2num(color{i}); end %#ok<ST2NM>
        for i = 1:3
            if     color{i} < 0; color{i} = 0; 
            elseif color{i} > 1; color{i} = 1; 
            end
        end
        if color{4} < 1; color{4} = 1; end
        handles.countcolor{countid} = [color{1},color{2},color{3},ceil(color{4})]; 
    end
    dotsize = handles.countcolor{countid}(4);
    disp('Begin manually marking objects.');
    while button ~= 3
        [xtemp1,ytemp1,button] = ginput(1);
        if button ~= 3
            xtemp1 = round(xtemp1);
            ytemp1 = round(ytemp1);
            if ~isempty(handles.manualcount{slice}{countid})
                tempsum = findpointinlist([xtemp1 ytemp1],handles.manualcount{slice}{countid},dotsize/2);
            else
                tempsum = [];
            end

            if ~isempty(tempsum)
                %This is a duplicate point, delete it.
                for i = 1:length(tempsum)
                    try delete(handles.whitedots{countid}(tempsum(i))); end %#ok<TRYNC>
                end
                handles.whitedots{         countid}(tempsum)   = [];
                handles.manualcount{slice}{countid}(tempsum,:) = [];

            else
                %This is a new point, add it.
                handles.manualcount{slice}{countid}(end+1,:) = [xtemp1 ytemp1]; 
                handles.whitedots{         countid}(end+1)   = rectangle('Position',...
                    [handles.manualcount{slice}{countid}(end,1)-floor(dotsize/2),...
                     handles.manualcount{slice}{countid}(end,2)-floor(dotsize/2),dotsize,dotsize],...
                    'Curvature',1,'EdgeColor','none','FaceColor',handles.countcolor{countid}(1:3));
            end
        end 
    end

    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes on button press in deletecount_button.
function deletecount_button_Callback(hObject, eventdata, handles)
oldH = handles;

try
    countid = str2num(get(handles.countid_edit,'string')); %#ok<ST2NM>
    if isempty(countid) || round(countid) ~= countid || countid <= 0;
        disp('Count ID must be an integer.');
        return; 
    end
    slice   = get(handles.slice_slider,'value');
    if length(handles.whitedots) < countid || isempty(handles.whitedots{countid})
        disp('There is no manual count to delete.');
    else
        if length(handles.whitedots) > 1 
            answer = questdlg('Do you want to delete all manual counts for this image?','','Yes','No','Cancel','No');
            if     strcmp(answer,'Yes'); I = 1:length(handles.whitedots); 
            elseif strcmp(answer,'No');  I = countid;
            else return; 
            end
        else
            I = countid;
        end
    
        for i = I
            for j = 1:length(handles.whitedots{i});
                try delete(handles.whitedots{i}(j)); end %#ok<TRYNC>
            end
            handles.whitedots{i} = [];
            handles.manualcount{slice}{i} = [];
        end
        
        for i = length(handles.manualcount{slice}):-1:1
            if isempty(handles.manualcount{slice}{i})
                handles.manualcount{slice}(i) = [];
                handles.whitedots(i)          = [];
            else
                break
            end
        end
        
        disp('Manual count deleted.');
    end
    
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


function countid_edit_Callback(hObject, eventdata, handles)
oldH = handles;

try
    countid = str2num(get(handles.countid_edit,'string')); %#ok<ST2NM>
    if isempty(countid) || round(countid) ~= countid || countid <= 0;
        disp('Count ID must be an integer.');
        return; 
    end
    if length(handles.countcolor) < countid || isempty(handles.countcolor{countid})
        defcolor = {'1','1','1','5'};
    else
        oldcolor = handles.countcolor{countid};
        defcolor = {num2str(oldcolor(1)),num2str(oldcolor(2)),num2str(oldcolor(3)),num2str(oldcolor(4))};
    end
        
    color   = inputdlg({'Red:','Green:','Blue:','Size:'},'Dot Color',1,defcolor);
    if isempty(color); return; end
        for i = 1:4; color{i} = str2num(color{i}); end %#ok<ST2NM>
        for i = 1:3
            if     color{i} < 0; color{i} = 0; 
            elseif color{i} > 1; color{i} = 1; 
            end
        end
        if color{4} < 1; color{4} = 1; end
        handles.countcolor{countid} = [color{1},color{2},color{3},ceil(color{4})];
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;


% --- Executes during object creation, after setting all properties.
function countid_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hideobjects_toggle.
function hideobjects_toggle_Callback(hObject, eventdata, handles)
oldH = handles;

try
    if get(handles.hideobjects_toggle,'value') == 0
        set(handles.hideobjects_toggle,'string','Hide Objects');
        handles = update_manualcount(handles,get(handles.slice_slider,'value'));
    else
        set(handles.hideobjects_toggle,'string','Show Objects');
        handles = update_manualcount(handles,get(handles.slice_slider,'value'),1);
        
    end
    guidata(hObject,handles);
catch
    handles = oldH;
    set(gcf,'Pointer','arrow');
    showerror(lasterror);
    guidata(hObject,handles);
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0 && strcmp(varnames(vari).name,'hObject') == 0;
        clear(varnames(vari).name); 
    end
end
clear vari varnames;







