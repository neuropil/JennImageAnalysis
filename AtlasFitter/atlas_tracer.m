function varargout = atlas_tracer(varargin)
% ATLAS_TRACER M-file for atlas_tracer.fig
%      ATLAS_TRACER, by itself, creates a new ATLAS_TRACER or raises the existing
%      singleton*.
%
%      H = ATLAS_TRACER returns the handle to a new ATLAS_TRACER or the handle to
%      the existing singleton*.
%
%      ATLAS_TRACER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATLAS_TRACER.M with the given input arguments.
%
%      ATLAS_TRACER('Property','Value',...) creates a new ATLAS_TRACER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before atlas_tracer_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to atlas_tracer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help atlas_tracer

% Last Modified by GUIDE v2.5 24-Nov-2010 13:04:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atlas_tracer_OpeningFcn, ...
                   'gui_OutputFcn',  @atlas_tracer_OutputFcn, ...
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


% --- Executes just before atlas_tracer is made visible.
function atlas_tracer_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to atlas_tracer (see VARARGIN)

% Choose default command line output for atlas_tracer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes atlas_tracer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = atlas_tracer_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function atlasfile_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>



% --- Executes during object creation, after setting all properties.
function atlasfile_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tracefile_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

% --- Executes during object creation, after setting all properties.
function tracefile_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadatlas_button.
function loadatlas_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

[f p] = uigetfile('*.mat;*.tif');
if isempty(p); return; end
[pname, fname, ext, v] = fileparts([p f]);

if strcmp(ext,'.mat')
    load([p f]);
elseif strcmp(ext,'.tif') || strcmp(ext,'.tiff');
    x = imread([p f]);
end
cd(p);
handles.path = p;
imagesc(x); colormap(gray);

handles.atlas = x;
set(handles.atlasfile_edit,'string',f);

handles.region = [];

guidata(hObject,handles);


% --- Executes on button press in loadtrace_button.
function loadtrace_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

str = get(handles.atlasfile_edit,'string');
if ~isempty(str)
    [f p] = uigetfile('*.mat','',[str(1:end-4),'_trace.mat']);
else
    [f p] = uigetfile('*.mat');
end
load([p f]);

numregions = length(regions); %#ok<USENS>

answer = questdlg('Load All or Half of the Trace Regions?','','All','Half','Half');
if strcmp(answer,'All')
    regioncount = numregions;
else
    regioncount = floor(numregions / 2);
end

for r = 1:regioncount
    
    handles.region{r}{1} = regions{r}{1};
    handles.region{r}{2} = regions{r}{2};
    handles.region{r}{6} = regions{r}{6};
    try    handles.region{r}{7} = regions{r}{7};
    catch; handles.region{r}{7} = 0; %#ok<CTCH>
    end
    
    xi      = handles.region{r}{2}(:,1);
    yi      = handles.region{r}{2}(:,2);
    xcenter = handles.region{r}{6}(1);
    ycenter = handles.region{r}{6}(2);
    zpos    = handles.region{r}{7};
    
    set(handles.zpos_edit,'string',num2str(zpos));
    
    hpoints = zeros(length(xi));
    for p = 1:length(xi)
        hpoint = rectangle('Position',[xi(p)-10,yi(p)-10,20,20],...
                'Curvature',1,'EdgeColor','r','LineWidth',2);
        hpoints(p) = hpoint; 
    end
    
    %color = get(handles.region{r}{4},'FaceColor');
    region_name = handles.region{r}{1};
    if strcmp(region_name,'Whole Right')==1 || strcmp(region_name,'Whole Left')==1 || strcmp(region_name,'Whole Section')==1
        hpatch = patch(xi,yi,(rand(1,3)*0.5)+0.5,'FaceColor','none','EdgeColor','r','LineWidth',3);
    else
        hpatch = patch(xi,yi,(rand(1,3)*0.5)+0.5);
    end
    htext  = text(xcenter,ycenter,region_name);

    handles.region{r}{3} = []; 
    handles.region{r}{4} = [];
    handles.region{r}{5} = [];
    
    handles.region{r}{3} = hpoints; 
    handles.region{r}{4} = hpatch;
    handles.region{r}{5} = htext;
end

guidata(hObject,handles);



% --- Executes on button press in savetrace_button.
function savetrace_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

cd(handles.path);
str = get(handles.atlasfile_edit,'string');
[f p] = uiputfile('*.mat','',[str(1:end-4),'_trace']);
regions = handles.region; 
for i = 1:length(regions)
    regions{i}{7} = str2num(get(handles.zpos_edit,'string')); %#ok<ST2NM>
end
save([p f],'regions');



function brainregionfile_edit_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

[f p] = uigetfile('*.txt');
fid   = fopen([p f]);

set(hObject,'string',[p f]);

S = textscan(fid,'%s','delimiter','');
set(handles.brainregions_list,'string',' ');
set(handles.brainregions_list,'string',S{1});
guidata(hObject,handles);
fclose(fid);

% --- Executes during object creation, after setting all properties.
function brainregionfile_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in brainregions_list.
function brainregions_list_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>


% --- Executes during object creation, after setting all properties.
function brainregions_list_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in outlineregion_button.
function outlineregion_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

if ~isfield(handles,'region');  handles.region  = []; end

allpoints = [];
for r = 1:length(handles.region)
    if isempty(allpoints)
        allpoints = handles.region{r}{2};
    else
        allpoints(end+1:end+size(handles.region{r}{2},1),:) = handles.region{r}{2};
    end
end

region_names = get(handles.brainregions_list,'string');
region_numb  = get(handles.brainregions_list,'value');
region_name  = region_names{region_numb};
hpoints      = [];

nonspaces = find(region_name ~= ' ',1,'last');
region_name(nonspaces+1:end) = [];
region_name(double(region_name)==10) = [];
region_name(double(region_name)==13) = [];

if strcmp(region_name,'Whole Right') || strcmp(region_name,'Whole Section')
    %answer = questdlg('Use Automated Boundary Detection?','','Yes','No','Yes');
    answer = 'Yes';
else
    answer = 'No';
end
pause(0.1);
if strcmp(answer,'No')
    button = 1;
    xi = [];
    yi = [];
    xtemp = [];
    ytemp = [];
    while button ~= 3
        if ~isempty(xtemp) && ~isempty(ytemp)
            if ~isempty(allpoints)
                difx = abs(allpoints(:,1) - xtemp);
                dify = abs(allpoints(:,2) - ytemp);
                dif  = [difx dify];
            else
                dif = [100 100];
            end

            diflogic = sum(dif < 10,2);

            if ~isempty(find(diflogic == 2,1)) && get(handles.nearbypoints_check,'value') == 1
                oldpoint = allpoints(diflogic == 2,:);
                xtemp    = oldpoint(1,1);
                ytemp    = oldpoint(1,2);
            end

            hpoint = rectangle('Position',[round(xtemp)-10,round(ytemp)-10,20,20],...
                'Curvature',1,'EdgeColor','r','LineWidth',2);
            allpoints(end+1,:) = [round(xtemp) round(ytemp)]; %#ok<AGROW>
            hpoints(end+1) = hpoint; %#ok<AGROW>
            pause(0.1);

        end
        xi = [xi; round(xtemp)]; %#ok<AGROW>
        yi = [yi; round(ytemp)]; %#ok<AGROW>
        [xtemp,ytemp,button]   = ginput(1);

    end
else
    I = zeros(size(handles.atlas,1),size(handles.atlas,2));
    J = I;

    for r = 1:length(handles.region)
        %if strcmp(handles.region{r}{1},'Whole Right') || strcmp(handles.region{r}{1},'Whole Left')
            xi = handles.region{r}{2}(:,1);
            yi = handles.region{r}{2}(:,2);
            BW = roipoly(I,xi,yi);
            J(BW == 1) = 1;
        %end
    end
    
    J = imfill(J,'holes'); 
    jp = bwperim(J);
    jp = smoothperim(jp);
    jperim = traceboundary(jp);
    jp2 = [jperim(:,2) jperim(:,1)];
    bps = [];
    ap = allpoints;
    for b = 1:size(jp2,1)
        d = ((ap(:,1)-jp2(b,1)) .^ 2 + (ap(:,2)-jp2(b,2)) .^2 ) .^ 0.5;

        if min(d) <= 2; 
            p1 = find(d == min(d));
            p2 = p1(1);
            bps(end+1,:) = ap(p2,:);  %#ok<AGROW>
            ap(p1,:) = 0;
        end
    end
    xi = bps(:,1);
    yi = bps(:,2);
end

xcenter = mean([max(xi) min(xi)]);
ycenter = mean([max(yi) min(yi)]);

xi(end + 1) = xi(1);
yi(end + 1) = yi(1);

if strcmp(region_name,'Whole Right')==1 || strcmp(region_name,'Whole Left')==1 || strcmp(region_name,'Whole Section')==1
    hpatch = patch(xi,yi,(rand(1,3)*0.5)+0.5,'FaceColor','none','EdgeColor','r','LineWidth',3);
else
    hpatch = patch(xi,yi,(rand(1,3)*0.5)+0.5);
end
htext   = text(xcenter,ycenter,region_name);

handles.region{end+1}{1} = region_name;
handles.region{end}{2} = [xi yi];
handles.region{end}{3} = hpoints; 
handles.region{end}{4} = hpatch;
handles.region{end}{5} = htext;
handles.region{end}{6} = [xcenter ycenter];
handles.region{end}{7} = str2num(get(handles.zpos_edit,'string')); %#ok<ST2NM>

pause(0.1);

guidata(hObject,handles);

% --- Executes on button press in deleteregion_button.
function deleteregion_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

region_names = get(handles.brainregions_list,'string');
region_numb  = get(handles.brainregions_list,'value');
region_name  = region_names{region_numb};
goodr        = [];

for r = 1:length(handles.region)
    if ~isempty(handles.region{r})
        if strcmp(handles.region{r}{1},region_name)
            for p = 1:length(handles.region{r}{3})
                delete(handles.region{r}{3}(p));
            end
            delete(handles.region{r}{4});
            delete(handles.region{r}{5});

            handles.region{r} = [];

        else
            goodr = [goodr r]; %#ok<AGROW>
        end
        
    end
end

handles.region = handles.region(goodr);

guidata(hObject,handles);


% --- Executes on button press in nearbypoints_check.
function nearbypoints_check_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>




% --- Executes on button press in addregion_button.
function addregion_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

newregion  = get(handles.addregion_edit,'string');
regionlist = get(handles.brainregions_list,'string');

for r = 1:length(regionlist)
    nummat(r,1:length(regionlist{r})) = char2num(regionlist{r}); %#ok<AGROW>
end
nummat(r+1,1:length(newregion)) = char2num(newregion);
nummat(:,end+1) = 1:r+1;

sortmat = sortrows(nummat);
newpos  = find(sortmat(:,end) == r+1);

for r = r:-1:newpos
    regionlist{r+1} = regionlist{r};
end
regionlist{newpos} = newregion;

set(handles.brainregions_list,'string',regionlist);
set(handles.brainregions_list,'value' ,newpos);

guidata(hObject,handles);


function addregion_edit_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>


% --- Executes during object creation, after setting all properties.
function addregion_edit_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in savelist_button.
function savelist_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

[f p] = uiputfile('*.txt');
if exist([p f]) == 2; delete([p f]); end
    
regionlist = get(handles.brainregions_list,'string');

fid = fopen([p,f,'.txt'],'a');
for r=1:length(regionlist)
    fprintf(fid,'%s\n',regionlist{r});
end
fclose(fid);





% --- Executes on button press in reflect_button.
function reflect_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

numregions = length(handles.region);
allpoints = getregionpoints(handles.region);

refx = min(allpoints(:,1));
for r = 1:length(handles.region)
    for p = 1:size(handles.region{r}{2},1)
        if abs(handles.region{r}{2}(p,1) - refx) <= 5
            handles.region{r}{2}(p,1) = refx;
        end
    end
end

for r = 1:numregions

    xi      = refx - (handles.region{r}{2}(:,1) - refx);
    yi      = handles.region{r}{2}(:,2);
    xcenter = refx - (handles.region{r}{6}(1) - refx);
    ycenter = handles.region{r}{6}(2);
    
    hpoints = zeros(length(xi));
    for p = 1:length(xi)
        hpoint = rectangle('Position',[xi(p)-10,yi(p)-10,20,20],...
                'Curvature',1,'EdgeColor','r','LineWidth',2);
        hpoints(p) = hpoint; 
    end
    
    region_name = handles.region{r}{1};
    color = get(handles.region{r}{4},'FaceColor');
    if strcmp(color,'none')==1; color = (rand(1,3)*0.5)+0.5; end
    
    if     strcmp(region_name,'Whole Left')==1;  region_name = 'Whole Right'; 
        hpatch = patch(xi,yi,color,'FaceColor','none','EdgeColor','r','LineWidth',3);
        xi = xi(end:-1:1);
        yi = yi(end:-1:1);
    elseif strcmp(region_name,'Whole Right')==1; region_name = 'Whole Left';
        xi = xi(end:-1:1);
        yi = yi(end:-1:1);
        hpatch = patch(xi,yi,color,'FaceColor','none','EdgeColor','r','LineWidth',3);
    else
        hpatch = patch(xi,yi,color);
    end
    htext  = text(xcenter,ycenter,region_name);

    handles.region{end+1}{1} = region_name;
    handles.region{end}{2} = [xi yi];
    handles.region{end}{3} = hpoints; 
    handles.region{end}{4} = hpatch;
    handles.region{end}{5} = htext;
    handles.region{end}{6} = [xcenter ycenter];
    handles.region{end}{7} = str2num(get(handles.zpos_edit,'string')); %#ok<ST2NM>
end

guidata(hObject,handles);



% --- Executes on button press in undoreflect_button.
function undoreflect_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

numregions = length(handles.region);
goodr      = 1:numregions/2; 

for r = (numregions/2) + 1 : numregions
    if ~isempty(handles.region{r})
        for p = 1:length(handles.region{r}{3})
            delete(handles.region{r}{3}(p));
        end
        delete(handles.region{r}{4});
        delete(handles.region{r}{5});

        handles.region{r} = [];
    end
end

handles.region = handles.region(goodr);

guidata(hObject,handles);




% --- Executes on button press in deleteall_button.
function deleteall_button_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>

answer = questdlg('Do you really want to delete all regions?');

if strcmp(answer,'Yes')
    if isfield(handles,'region')
        for r = 1 : length(handles.region)
            if ~isempty(handles.region{r})
                for p = 1:length(handles.region{r}{3})
                    delete(handles.region{r}{3}(p));
                end
                delete(handles.region{r}{4});
                delete(handles.region{r}{5});

                handles.region{r} = [];
            end
        end
    end
    
    handles.region = [];
    guidata(hObject,handles);
end




% --- Executes on button press in zoom_toggle.
function zoom_toggle_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if get(hObject,'value') == 1
    zoom on;
else
    zoom off;
end

% --- Executes on button press in pan_toggle.
function pan_toggle_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

if get(hObject,'value') == 1
    pan on;
else
    pan off;
end



% --- Executes on button press in compile_button.
function compile_button_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>

p       = uigetdir;
if isempty(p); return; end
f       = dir(p);
cnt     = 0;
ftrace  = [];
rtemp   = [];

for n = 3:length(f);
    try %#ok<TRYNC>
        if strcmp(f(n).name(end-8:end),'trace.mat')
            cnt = cnt + 1;
            ftrace{cnt} = f(n).name(1:end-10); %#ok<AGROW>
            
        end
    end
end

for n = 1:length(ftrace)
    load([p filesep ftrace{n} '_trace.mat']);
    trace = str2double(ftrace{n}(end-2:end));
    
    rtemp{trace} = regions; %#ok<AGROW,NODEF>
end

regions = rtemp; %#ok<NASGU>

[f p] = uiputfile('*.mat');
if isempty(p); return; end
save([p f],'regions');


% --- Executes on button press in boundary_toggle.
function boundary_toggle_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL,INUSD,DEFNU>

points = getregionpoints(handles.region);
button = 1;
xi = [];
yi = [];
xtemp = [];
ytemp = [];
while button ~= 3
    if ~isempty(xtemp) && ~isempty(ytemp)

        difx = abs(points(:,1) - xtemp);
        dify = abs(points(:,2) - ytemp);
        dif  = [difx dify];
        
        diflogic = sum(dif < 10,2);

        if ~isempty(find(diflogic == 2,1))
            oldpoint = points(diflogic == 2,:);
            xtemp    = oldpoint(1,1);
            ytemp    = oldpoint(1,2);
        end
            
        hpoint = rectangle('Position',[round(xtemp)-10,round(ytemp)-10,20,20],...
            'Curvature',1,'EdgeColor','r','FaceColor','r');
        hpoints(end+1) = hpoint; %#ok<NASGU,AGROW>
        pause(0.1);
        
    end
    xi = [xi; round(xtemp)]; %#ok<AGROW>
    yi = [yi; round(ytemp)]; %#ok<AGROW>
    [xtemp,ytemp,button]   = ginput(1);
     
end



function zpos_edit_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function zpos_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


