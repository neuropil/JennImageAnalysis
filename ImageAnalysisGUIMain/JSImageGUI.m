function varargout = JSImageGUI(varargin)
% JSIMAGEGUI MATLAB code for JSImageGUI.fig
%      JSIMAGEGUI, by itself, creates a new JSIMAGEGUI or raises the existing
%      singleton*.
%
%      H = JSIMAGEGUI returns the handle to a new JSIMAGEGUI or the handle to
%      the existing singleton*.
%
%      JSIMAGEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JSIMAGEGUI.M with the given input arguments.
%
%      JSIMAGEGUI('Property','Value',...) creates a new JSIMAGEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before JSImageGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to JSImageGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JSImageGUI

% Last Modified by GUIDE v2.5 04-Jul-2013 00:00:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JSImageGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @JSImageGUI_OutputFcn, ...
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


% --- Executes just before JSImageGUI is made visible.
function JSImageGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to JSImageGUI (see VARARGIN)

% Choose default command line output for JSImageGUI
handles.output = hObject;

%-------------------------------------------------------------------------%
% Start Axes blank ------------------------%
%-------------------------------------------------------------------------%
set(handles.ImageShow,'XTick',[]);
set(handles.ImageShow,'YTick',[]);

set(handles.CellCountImage,'XTick',[]);
set(handles.CellCountImage,'YTick',[]);

set(handles.cellsignTog,'Value',1);
set(handles.cellsignTog, 'BackgroundColor',[1 1 0])

set(handles.findedgeTog,'Value',1);
set(handles.findedgeTog, 'BackgroundColor',[1 1 0])

set(handles.redradio,'Enable','off')
set(handles.greenradio,'Enable','off')
set(handles.blueradio,'Enable','off')
set(handles.mergeradio,'Enable','off')
set(handles.horzvert,'Enable','off')

set(handles.rotateme,'Enable','off')
set(handles.loadUserSettings,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JSImageGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = JSImageGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%-------------------------------------------------------------------------%
%----------------------------PARAMETERS-----------------------------------%
%-------------------------------------------------------------------------%

%--------------------Minimum Water Size-----------------------------------%

function minwatersizeVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_mws,'Min') && value < get(handles.sl_mws,'Max')
    set(handles.sl_mws,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_mws,'Value',30);
    set(handles.minwatersizeVal,'String',num2str(30));
end

% --- Executes during object creation, after setting all properties.
function minwatersizeVal_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_mws_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
minWaterSize = get(hObject,'Value');

roundVal = round(minWaterSize);

set(handles.minwatersizeVal,'String', num2str(roundVal));
updateVal = get(handles.minwatersizeVal,'String');
set(hObject,'Value', str2double(updateVal));

% --- Executes during object creation, after setting all properties.
function sl_mws_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject, 'SliderStep', [0.01 0.1])
set(hObject,'Min',10)
set(hObject,'Max',150)
set(hObject,'Value',30)


%----------------------------Cell-----------------------------------------%

function cellVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_c,'Min') && value < get(handles.sl_c,'Max')
    set(handles.sl_c,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_c,'Value',0.05);
    set(handles.cellVal,'String',num2str(0.05));
end


% --- Executes during object creation, after setting all properties.
function cellVal_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_c_Callback(hObject, eventdata, handles)
% hObject    handle to sl_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cell = get(hObject,'Value');

roundVal = round(cell*1000)/1000;

set(handles.cellVal,'String', num2str(roundVal));
updateVal = get(handles.cellVal,'String');
set(hObject,'Value', str2double(updateVal));


% --- Executes during object creation, after setting all properties.
function sl_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject, 'SliderStep', [0.03 0.3])
set(hObject,'Min',0.01)
set(hObject,'Max',0.3)
set(hObject,'Value',0.05)


%--------------------Minimum Cell Size------------------------------------%

function mincellsizeVal_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of mincellsizeVal as text
%        str2double(get(hObject,'String')) returns contents of mincellsizeVal as a double

value = str2double(get(hObject,'String'));

if value > get(handles.sl_mcs,'Min') && value < get(handles.sl_mcs,'Max')
    set(handles.sl_mcs,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_mcs,'Value',2);
    set(handles.mincellsizeVal,'String',num2str(2));
end


% --- Executes during object creation, after setting all properties.
function mincellsizeVal_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_mcs_Callback(hObject, eventdata, handles)

mincell = get(hObject,'Value');

roundVal = round(mincell);

set(handles.mincellsizeVal,'String', num2str(roundVal));
updateVal = get(handles.mincellsizeVal,'String');
set(hObject,'Value', str2double(updateVal));


% --- Executes during object creation, after setting all properties.
function sl_mcs_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

small_step = 1/(30 - 3);
large_step = small_step * 10;

set(hObject,'SliderStep', [small_step large_step])
set(hObject,'Min',3)
set(hObject,'Max',30)
set(hObject,'Value',3)


%--------------------Maximum Cell Size------------------------------------%

function maxcellsizeVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_macs,'Min') && value < get(handles.sl_macs,'Max')
    set(handles.sl_macs,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_macs,'Value',40);
    set(handles.maxcellsizeVal,'String',num2str(40));
end


% --- Executes during object creation, after setting all properties.
function maxcellsizeVal_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_macs_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

maxCellSize = get(hObject,'Value');

roundVal = round(maxCellSize);

set(handles.maxcellsizeVal,'String', num2str(roundVal));
updateVal = get(handles.maxcellsizeVal,'String');
set(hObject,'Value', str2double(updateVal));

% --- Executes during object creation, after setting all properties.
function sl_macs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_macs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'SliderStep', [0.01 0.1])
set(hObject,'Min',20)
set(hObject,'Max',100)
set(hObject,'Value',40)


%-----------------------------Boundary------------------------------------%


function boundaryVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_b,'Min') && value < get(handles.sl_b,'Max')
    set(handles.sl_b,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_b,'Value',0);
    set(handles.boundaryVal,'String',num2str(0));
end

% --- Executes during object creation, after setting all properties.
function boundaryVal_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_b_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

boundary = get(hObject,'Value');

roundVal = round(boundary*1000)/1000;

set(handles.boundaryVal,'String', num2str(roundVal));
updateVal = get(handles.boundaryVal,'String');
set(hObject,'Value', str2double(updateVal));

% --- Executes during object creation, after setting all properties.
function sl_b_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'SliderStep', [0.1 0.2])
set(hObject,'Min',0)
set(hObject,'Max',0.01)
set(hObject,'Value',0)


%-----------------------------Blur Size-----------------------------------%


function blursizeVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_bs,'Min') && value < get(handles.sl_bs,'Max')
    set(handles.sl_bs,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_bs,'Value',5);
    set(handles.blursizeVal,'String',num2str(5));
end


% --- Executes during object creation, after setting all properties.
function blursizeVal_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_bs_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
blurSize = get(hObject,'Value');

roundVal = round(blurSize);

set(handles.blursizeVal,'String', num2str(roundVal));
updateVal = get(handles.blursizeVal,'String');
set(hObject,'Value', str2double(updateVal));


% --- Executes during object creation, after setting all properties.
function sl_bs_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'SliderStep', [0.05 0.25])
set(hObject,'Min',3)
set(hObject,'Max',15)
set(hObject,'Value',5)


%-----------------------------Blur Spread---------------------------------%


function blurspreadVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_bsp,'Min') && value < get(handles.sl_bsp,'Max')
    set(handles.sl_bsp,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_bsp,'Value',1);
    set(handles.blurspreadVal,'String',num2str(1));
end


% --- Executes during object creation, after setting all properties.
function blurspreadVal_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_bsp_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
blurSpread = get(hObject,'Value');

roundVal = round(blurSpread);

set(handles.blurspreadVal,'String', num2str(roundVal));
updateVal = get(handles.blurspreadVal,'String');
set(hObject,'Value', str2double(updateVal));

% --- Executes during object creation, after setting all properties.
function sl_bsp_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'SliderStep', [0.1 0.2])
set(hObject,'Min',0)
set(hObject,'Max',10)
set(hObject,'Value',1)


%-----------------------------Cell Pixels---------------------------------%


function cellpixelsVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_cp,'Min') && value < get(handles.sl_cp,'Max')
    set(handles.sl_cp,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_cp,'Value',16);
    set(handles.cellpixelsVal,'String',num2str(16));
end


% --- Executes during object creation, after setting all properties.
function cellpixelsVal_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_cp_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
cellPixels = get(hObject,'Value');

roundVal = round(cellPixels);

set(handles.cellpixelsVal,'String', num2str(roundVal));
updateVal = get(handles.cellpixelsVal,'String');
set(hObject,'Value', str2double(updateVal));

% --- Executes during object creation, after setting all properties.
function sl_cp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

small_step = 1/(30 - 3);
large_step = small_step * 10;

set(hObject,'SliderStep', [small_step large_step])
set(hObject,'Min',3)
set(hObject,'Max',30)
set(hObject,'Value',16)


%-----------------------------Back Percent--------------------------------%


function backpercentVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value > get(handles.sl_bp,'Min') && value < get(handles.sl_bp,'Max')
    set(handles.sl_bp,'Value',value);
else
    msgbox('Input value outside range of parameter','Range Exceeded','warn') 
    set(handles.sl_bp,'Value',0.16);
    set(handles.backpercentVal,'String',num2str(0.16));
end


% --- Executes during object creation, after setting all properties.
function backpercentVal_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sl_bp_Callback(hObject, eventdata, handles)

backPercent = get(hObject,'Value');

roundVal = round(backPercent*100)/100;

set(handles.backpercentVal,'String', num2str(roundVal));
updateVal = get(handles.backpercentVal,'String');
set(hObject,'Value', str2double(updateVal));


% --- Executes during object creation, after setting all properties.
function sl_bp_CreateFcn(hObject, eventdata, handles)


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'SliderStep', [0.02 0.2])
set(hObject,'Min',0.1)
set(hObject,'Max',0.6)
set(hObject,'Value',0.16)


%-----------------------------Cell Sign-----------------------------------%


function cellsignVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value
    set(handles.cellsignTog,'Value',value);
    set(handles.cellsignTog, 'BackgroundColor',[1 1 0])
else
    set(handles.cellsignTog,'Value',value);
    set(handles.cellsignTog, 'BackgroundColor',[1 0 0])
end

% --- Executes during object creation, after setting all properties.
function cellsignVal_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in cellsignTog.
function cellsignTog_Callback(hObject, eventdata, handles)

cellsignPress = get(hObject,'Value');

if cellsignPress
    set(hObject, 'BackgroundColor',[1 1 0])
else
    set(hObject, 'BackgroundColor',[1 0 0])
end

set(handles.cellsignVal,'String',num2str(cellsignPress));


%-----------------------------Find Edge-----------------------------------%

function findedgeVal_Callback(hObject, eventdata, handles)

value = str2double(get(hObject,'String'));

if value
    set(handles.findedgeTog,'Value',value);
    set(handles.findedgeTog, 'BackgroundColor',[1 1 0])
else
    set(handles.findedgeTog,'Value',value);
    set(handles.findedgeTog, 'BackgroundColor',[1 0 0])
end

% --- Executes during object creation, after setting all properties.
function findedgeVal_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in findedgeTog.
function findedgeTog_Callback(hObject, eventdata, handles)

findedgePress = get(hObject,'Value');

if findedgePress
    set(hObject, 'BackgroundColor',[1 1 0])
else
    set(hObject, 'BackgroundColor',[1 0 0])
end

set(handles.findedgeVal,'String',num2str(findedgePress));

%-------------------------------------------------------------------------%
%------------------------------BUTTONS------------------------------------%
%-------------------------------------------------------------------------%


% --- Executes on button press in loaddefaultsbutton.
function loaddefaultsbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loaddefaultsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = hObject;

set(handles.minwatersizeVal,'String','30');
set(handles.sl_mws,'Value',30);

set(handles.cellVal,'String','0.05');
set(handles.sl_c,'Value',0.05);

set(handles.mincellsizeVal,'String','3');
set(handles.sl_mcs,'Value',3);

set(handles.maxcellsizeVal,'String','40');
set(handles.sl_macs,'Value',40);

set(handles.boundaryVal,'String','0');
set(handles.sl_b,'Value',0);

set(handles.blursizeVal,'String','5');
set(handles.sl_bs,'Value',5);

set(handles.blurspreadVal,'String','1');
set(handles.sl_bsp,'Value',1);

set(handles.cellpixelsVal,'String','16');
set(handles.sl_cp,'Value',16);

set(handles.backpercentVal,'String','0.16');
set(handles.sl_bp,'Value',0.16);

set(handles.cellsignVal,'String','1');
set(handles.cellsignTog, 'BackgroundColor',[1 1 0])
set(handles.cellsignTog,'Value', 1);

set(handles.findedgeVal,'String','1');
set(handles.findedgeTog, 'BackgroundColor',[1 1 0])
set(handles.findedgeTog,'Value', 1);

guidata(hObject, handles);

% --- Executes on button press in applyparamsbutton.
function applyparamsbutton_Callback(hObject, eventdata, handles)
% hObject    handle to applyparamsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Just a personal log of values we've used.
%for Chuck  50 0.08 15 300 0.0005 5 1 15 0.3    0 1
%for Bo     10 0.12  3  20 0      3 1  3 0.3    1 0
%for Sergei 30 0.16  6  80 0      5 1 16 0.1631 1 1

handles.x.thresholds.minwatersize = str2double(get(handles.minwatersizeVal,'String'));
handles.x.thresholds.cell = str2double(get(handles.cellVal,'String'));
handles.x.thresholds.mincellsize = str2double(get(handles.mincellsizeVal,'String'));
handles.x.thresholds.maxcellsize = str2double(get(handles.maxcellsizeVal,'String'));
handles.x.thresholds.boundary = str2double(get(handles.boundaryVal,'String'));
handles.x.thresholds.blursize = str2double(get(handles.blursizeVal,'String'));
handles.x.thresholds.blurspread = str2double(get(handles.blurspreadVal,'String'));
handles.x.thresholds.cellpixels = str2double(get(handles.cellpixelsVal,'String'));
handles.x.thresholds.backpercent = str2double(get(handles.backpercentVal,'String'));
handles.x.thresholds.cellsign = str2double(get(handles.cellsignVal,'String'));
handles.x.thresholds.findedge = str2double(get(handles.findedgeVal,'String'));

sw = 1; %if you set this to 1 it will display waitbars

if handles.x.thresholds.cellsign == 1
    %cells are maxima. the image must be inverted since the algorithm looks for minima.
    if strcmp(class(handles.I),'uint8');
        handles.I = 255 - handles.I;
    elseif strcmp(class(handles.I),'uint16');
        handles.I = 65536 - handles.I;
    else
        handles.I = max(max(max(handles.I))) - handles.I;
    end
end

if sw==1; handles.h = waitbar(0.1,'Preprocessing Image.'); end

%lowpass filter the image, sum across color channels, and take the natural log
if ~isfield(handles.x,'log')
    if handles.x.thresholds.blursize == 0 || handles.x.thresholds.blurspread == 0
        temp = handles.I;
    else
        temp  = imfilter(handles.I,fspecial('gaussian',handles.x.thresholds.blursize,handles.x.thresholds.blurspread));
        if sw==1; waitbar(0.4); end
    end
    temp  = sum(temp,3);
    temp(temp == 0) = 1;
    handles.x.log  = log(temp);
else
    handles.mask = sum(handles.I,3);
    handles.x.log(handles.mask == 0) = 0;
end

%Run edge detection.
if ~isfield(handles.x,'edg')
    if handles.x.thresholds.findedge == 1
        %So far I've found this first method works well for colorimetric
        %images while the second works well for fluorescence images.  Feel
        %free to modify this code to best work in your images.
        if handles.x.thresholds.cellsign == 0
            handles.x.edg = logical(edge(handles.x.log,'sobel')); if sw==1; waitbar(0.7); end
            handles.x.edg = imdilate(handles.x.edg,strel('disk',2));
            handles.x.edg = bwareaopen(handles.x.edg,100,8);
            handles.x.edg = imdilate(handles.x.edg,strel('disk',8));
            
        else
            handles.x.edg = logical(edge(handles.x.log,'canny',[0.0125 0.05],5));
            handles.x.edg = bwareaopen(handles.x.edg,250,8);
            handles.x.edg = imdilate(handles.x.edg,strel('disk',8));
        end
    else
        handles.x.edg = false(size(handles.x.log));
    end
end

%If all the user wants to do is find the edge, stop here.
% if strcmp(action,'findedge') == 1
%     if sw==1; close(h); pause(0.1); end
%     return;
% end

%If the user has supplied a mask, apply it to the log image.
if isfield(handles.x,'mask'); handles.x.log(handles.x.mask == 0) = Inf; end

%Identify subregions using the watershed algorithm
if ~isfield(handles.x,'water')
    handles.x.water = watershed(handles.x.log); if sw==1; waitbar(0.9); end
    handles.x.fullwater = false(size(handles.x.water));
    handles.x.fullwater(handles.x.water == 0) = 1;
end

if isfield(handles.x,'mask'); handles.x.water(handles.x.mask == 0) = 0; end

%Remove small watersheds, those remaining are our first pass potential cells
temp = false(size(handles.x.water));
temp(handles.x.water ~= 0) = 1;
temp = bwareaopen(temp,handles.x.thresholds.minwatersize,4); if sw==1; waitbar(1); end
handles.x.cells = bwlabel(temp);

if sw==1; close(handles.h); pause(0.1); end

%Index the image
if ~isfield(handles.x,'index')
    handles.x = index_image(handles.x);
end

%Remove any subregions that touch previously detected edges
handles.x = removeedge(handles.x);

%Apply significance test to remaining subregions, those that pass threshold
%are deemed to contian cells.
handles.x.cellcores = false(size(handles.I,1),size(handles.I,2));
handles.x.cellnorm  = zeros(size(handles.x.log));
handles.x = cellid(handles.x);

%Remove expty elements from index and pixels, renumber the cells
%accordingly so there are no skipped numbers
if sw==1; handles.h = waitbar(0.1,'Cleaning Up Cells.'); end
handles.x = compressids(handles.x); if sw==1; waitbar(0.3); end

%Identify pixels that are the perimeter of the cell cores
handles.x.cellCperim = logical(bwperim(handles.x.cellcores)); if sw==1; waitbar(0.5); end

%Identify pixels that are the perimeter of the subregions with cells
temp = false(size(handles.x.cells));
temp(handles.x.cells ~= 0) = 1;
handles.x.cellWperim = logical(bwperim(temp)); if sw==1; waitbar(0.7); end

if handles.x.thresholds.boundary > 0
    %Calculate bound
    temp = imdilate(temp,strel('disk',1)); if sw==1; waitbar(0.9); end
    handles.x.bound = find(handles.x.cells == 0 & temp == 1);
    if sw==1; close(handles.h); end
    
    %Determine which cells border one another
    handles.x = get_neighbor_regions(handles.x);
    
    %Find those cell cores that touch the subregion boundaries
    temp = handles.x.cells(handles.x.cellCperim == 1 & handles.x.cellWperim == 1);
    temp = unique(temp);
    handles.x.cellatbound = temp(temp ~= 0);
    
    %Determine which neighboring cells to fuse
    handles.x = modify_neighbors(handles.x);
    
    if sw==1; h = waitbar(0.1,'Cleaning Up Cells.'); end
    temp = false(size(handles.x.cells));
    temp(handles.x.cells ~= 0) = 1;
    handles.x.cellWperim = logical(bwperim(temp)); if sw==1; waitbar(0.3); end
end

%Remove large cells
temp = bwareaopen(handles.x.cellcores,handles.x.thresholds.maxcellsize,4);
handles.x.cellcores = handles.x.cellcores - temp; if sw==1; waitbar(0.5); end
handles.x.cellnorm(handles.x.cellcores == 0) = 0;

handles.x.cellCperim = logical(bwperim(handles.x.cellcores)); if sw==1; waitbar(0.7); end

handles.x.cellcores = logical(handles.x.cellcores);
if sw==1; close(handles.h); pause(0.1); end

handles.L = bwlabel(handles.x.cellcores);
count = max(unique(handles.L));
handles.x.cellcount = count; % OUTPUT x.cellcount FOR CELL COUNT

%To superimpose the cells on the image do the following
handles.I(:,:,1) = handles.x.cellcores; %the red channel will now have the identified cells

handles.I = handles.I(:,:,1);

handles.red_overlay = cat(3, ones(size(handles.I)), zeros(size(handles.I)), zeros(size(handles.I)));

axes(handles.CellCountImage);
set(handles.CellCountImage,'XTick',[]);
set(handles.CellCountImage,'YTick',[]);

handles.x.Original_Image = handles.merge;

handles.himage = imshow(handles.red_overlay);
set(handles.himage, 'AlphaData', handles.x.Original_Image(:,:,1));
hold on
handles.iim3 = imshow(handles.x.Original_Image(:,:,1));
set(handles.iim3,'AlphaData',double(handles.I));
plot(handles.borders{1,1}(:,2),handles.borders{1,1}(:,1),'k')


set(handles.cellCounttext,'String',num2str(handles.x.cellcount));

guidata(hObject, handles);


% --- Executes on button press in redradio.
function redradio_Callback(hObject, eventdata, handles)
% hObject    handle to redradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of redradio

radioVal = get(hObject,'Value');

handles.globalImage = handles.r;

if radioVal
    axes(handles.ImageShow);
    imshow(handles.globalImage);   
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
    set(handles.mergeradio,'Value',0)
    set(handles.redradio,'Value',1)
    set(handles.greenradio,'Value',0)
    set(handles.blueradio,'Value',0)
    
    handles.image2analyze = handles.r;
    
    zoom on;
end

guidata(hObject, handles);

% --- Executes on button press in greenradio.
function greenradio_Callback(hObject, eventdata, handles)
% hObject    handle to greenradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of greenradio
radioVal = get(hObject,'Value');

handles.globalImage = handles.g;

if radioVal
    axes(handles.ImageShow);
    imshow(handles.g);
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
    set(handles.mergeradio,'Value',0)
    set(handles.redradio,'Value',0)
    set(handles.greenradio,'Value',1)
    set(handles.blueradio,'Value',0)

    handles.image2analyze = handles.g;
    
    zoom on;
end

guidata(hObject, handles);

% --- Executes on button press in blueradio.
function blueradio_Callback(hObject, eventdata, handles)
% hObject    handle to blueradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blueradio
radioVal = get(hObject,'Value');

handles.globalImage = handles.b;

if radioVal
    axes(handles.ImageShow);
    imshow(handles.b);
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
    set(handles.mergeradio,'Value',0)
    set(handles.redradio,'Value',0)
    set(handles.greenradio,'Value',0)
    set(handles.blueradio,'Value',1)

    handles.image2analyze = handles.b;
    
    zoom on;
end

guidata(hObject, handles);

% --- Executes on button press in mergeradio.
function mergeradio_Callback(hObject, eventdata, handles)
% hObject    handle to mergeradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mergeradio

radioVal = get(hObject,'Value');

handles.globalImage = handles.merge;

if radioVal
    axes(handles.ImageShow);
    imshow(handles.merge);
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
    set(handles.mergeradio,'Value',1)
    set(handles.redradio,'Value',0)
    set(handles.greenradio,'Value',0)
    set(handles.blueradio,'Value',0)
    
    zoom on;
end

guidata(hObject, handles);


% --- Executes on selection change in horzvert.
function horzvert_Callback(hObject, eventdata, handles)
% hObject    handle to horzvert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns horzvert contents as cell array
%        contents{get(hObject,'Value')} returns selected item from horzvert

contents = cellstr(get(hObject,'String'));

getSelection = contents{get(hObject,'Value')};

if strcmp(getSelection, 'Horizontal Flip')
    handles.globalImage = flipdim(handles.globalImage, 2);
    
    axes(handles.ImageShow)
    imshow(handles.globalImage)
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
elseif strcmp(getSelection, 'Vertical Flip')
    handles.globalImage = flipdim(handles.globalImage, 1);
    
    axes(handles.ImageShow)
    imshow(handles.globalImage)
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
     
end


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function horzvert_CreateFcn(hObject, eventdata, handles)
% hObject    handle to horzvert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rotateme.
function rotateme_Callback(hObject, eventdata, handles)
% hObject    handle to rotateme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rotateme contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rotateme
contents = cellstr(get(hObject,'String'));

getSelection = contents{get(hObject,'Value')};

angle = str2double(getSelection);

if angle == 90
    axes(handles.ImageShow)
    
    handles.globalImage = imrotate(handles.globalImage,angle);
    imshow(handles.globalImage)
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
elseif angle == 180
    axes(handles.ImageShow)
    
    handles.globalImage = imrotate(handles.globalImage,angle);
    imshow(handles.globalImage)
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
      
elseif angle == 270
    axes(handles.ImageShow)
    
    handles.globalImage = imrotate(handles.globalImage,angle);
    imshow(handles.globalImage)
    set(handles.ImageShow,'XTick',[]);
    set(handles.ImageShow,'YTick',[]);
    
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rotateme_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotateme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in setUserparams.
function setUserparams_Callback(hObject, eventdata, handles)
% hObject    handle to setUserparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.minwatersizeVal,'String',get(handles.msw_user,'String'));
set(handles.sl_mws,'Value',str2double(get(handles.msw_user,'String')));

set(handles.cellVal,'String',get(handles.c_user,'String'));
set(handles.sl_c,'Value',str2double(get(handles.c_user,'String')));

set(handles.mincellsizeVal,'String',get(handles.mics_user,'String'));
set(handles.sl_mcs,'Value',str2double(get(handles.mics_user,'String')));

set(handles.maxcellsizeVal,'String',get(handles.macs_user,'String'));
set(handles.sl_macs,'Value',str2double(get(handles.macs_user,'String')));

set(handles.boundaryVal,'String',get(handles.b_user,'String'));
set(handles.sl_b,'Value',str2double(get(handles.b_user,'String')));

set(handles.blursizeVal,'String',get(handles.bsi_user,'String'));
set(handles.sl_bs,'Value',str2double(get(handles.bsi_user,'String')));

set(handles.blurspreadVal,'String',get(handles.bsp_user,'String'));
set(handles.sl_bsp,'Value',str2double(get(handles.bsp_user,'String')));

set(handles.cellpixelsVal,'String',get(handles.cp_user,'String'));
set(handles.sl_cp,'Value',str2double(get(handles.cp_user,'String')));

set(handles.backpercentVal,'String',get(handles.bp_user,'String'));
set(handles.sl_bp,'Value',str2double(get(handles.bp_user,'String')));

guidata(hObject, handles);

% --- Executes on button press in cellMasktog.
function cellMasktog_Callback(hObject, eventdata, handles)
% hObject    handle to cellMasktog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cellMasktog




% --- Executes on selection change in saveUserSettings.
function saveUserSettings_Callback(hObject, eventdata, handles)
% hObject    handle to saveUserSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns saveUserSettings contents as cell array
%        contents{get(hObject,'Value')} returns selected item from saveUserSettings

contents = cellstr(get(hObject,'String'));

getSelection = contents{get(hObject,'Value')};

UserSaveNum = str2double(getSelection(end));

handles.UserSave.(strcat('set',num2str(UserSaveNum))).minwatersizeVal = get(handles.minwatersizeVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).cellVal = get(handles.cellVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).mincellsizeVal = get(handles.mincellsizeVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).maxcellsizeVal = get(handles.maxcellsizeVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).boundaryVal = get(handles.boundaryVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).blursizeVal = get(handles.blursizeVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).blurspreadVal = get(handles.blurspreadVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).blurspreadVal = get(handles.blurspreadVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).cellpixelsVal = get(handles.cellpixelsVal,'String');
handles.UserSave.(strcat('set',num2str(UserSaveNum))).backpercentVal = get(handles.backpercentVal,'String');

set(handles.loadUserSettings,'Enable','on');

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function saveUserSettings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saveUserSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in loadUserSettings.
function loadUserSettings_Callback(hObject, eventdata, handles)
% hObject    handle to loadUserSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns loadUserSettings contents as cell array
%        contents{get(hObject,'Value')} returns selected item from loadUserSettings

contents = cellstr(get(hObject,'String'));

getSelection = contents{get(hObject,'Value')};

UserSaveNum = str2double(getSelection(end));

setName = strcat('set',num2str(UserSaveNum)); 

if ~isfield(handles,'UserSave')
    warndlg('No Settings Saved','!! Warning !!')
    
elseif ~isfield(handles.UserSave,setName)  
    warndlg('No settings saved for this User Number','!! Warning !!')
    
else
    loadUserParams = handles.UserSave.(strcat('set',num2str(UserSaveNum)));
    
    set(handles.msw_user,'String',loadUserParams.minwatersizeVal);
    set(handles.c_user,'String',loadUserParams.cellVal);
    set(handles.mics_user,'String',loadUserParams.mincellsizeVal);
    set(handles.macs_user,'String',loadUserParams.maxcellsizeVal);
    set(handles.b_user,'String',loadUserParams.boundaryVal);
    set(handles.bsi_user,'String',loadUserParams.blursizeVal);
    set(handles.bsp_user,'String',loadUserParams.blurspreadVal);
    set(handles.cp_user,'String',loadUserParams.cellpixelsVal);
    set(handles.bp_user,'String',loadUserParams.backpercentVal);
end


% --- Executes during object creation, after setting all properties.
function loadUserSettings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadUserSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% % --- Executes on button press in set_sliders.
% function set_sliders_Callback(hObject, eventdata, handles)
% % hObject    handle to set_sliders (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% reset_mws = get(handles.minwatersizeVal,'String');
% set(handles.sl_mws,'Value',str2double(reset_mws));
% 
% reset_c = get(handles.cellVal,'String');
% set(handles.sl_c,'Value',str2double(reset_c));
% 
% reset_mics = get(handles.mincellsizeVal,'String');
% set(handles.sl_mcs,'Value',str2double(reset_mics));
% 
% reset_macs = get(handles.maxcellsizeVal,'String');
% set(handles.sl_macs,'Value',str2double(reset_macs));
% 
% reset_b = get(handles.boundaryVal,'String');
% set(handles.sl_b,'Value',str2double(reset_b));
% 
% reset_bsi = get(handles.blursizeVal,'String');
% set(handles.sl_bs,'Value',str2double(reset_bsi));
% 
% reset_bsp = get(handles.blurspreadVal,'String');
% set(handles.sl_bsp,'Value',str2double(reset_bsp));
% 
% reset_cp = get(handles.cellpixelsVal,'String');
% set(handles.sl_cp,'Value',str2double(reset_cp));
% 
% reset_bp = get(handles.backpercentVal,'String');
% set(handles.sl_bp,'Value',str2double(reset_bp));




















% --------------------------------------------------------------------
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function loadrgb_Callback(hObject, eventdata, handles)
% hObject    handle to loadrgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function loadTri_Callback(hObject, eventdata, handles)
% hObject    handle to loadTri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.IMname,handles.PathName,~] = uigetfile({'*.tif;*.tiff',...
    'Image Files (*.tif,*.tiff)';...
    '*.*',  'All Files (*.*)'},'File Selector');

cd(handles.PathName);
axes(handles.ImageShow);
testImage = imread(handles.IMname);

handles.merge = testImage;
[handles.IMrows,handles.IMcols,~] = size(handles.merge);

handles.globalImage = testImage;

handles.r = cat(3, handles.merge(:,:,1), zeros(handles.IMrows,handles.IMcols), zeros(handles.IMrows,handles.IMcols));
handles.g = cat(3, zeros(handles.IMrows,handles.IMcols), handles.merge(:,:,2), zeros(handles.IMrows,handles.IMcols));
handles.b = cat(3, zeros(handles.IMrows,handles.IMcols), zeros(handles.IMrows,handles.IMcols), handles.merge(:,:,3));

imshow(handles.merge);
set(handles.ImageShow,'XTick',[]);
set(handles.ImageShow,'YTick',[]);

set(handles.mergeradio,'Value',1)
set(handles.redradio,'Value',0)
set(handles.greenradio,'Value',0)
set(handles.blueradio,'Value',0)

zoom on;

set(handles.redradio,'Enable','on')
set(handles.greenradio,'Enable','on')
set(handles.blueradio,'Enable','on')
set(handles.mergeradio,'Enable','on')
set(handles.horzvert,'Enable','on')
set(handles.rotateme,'Enable','on')

guidata(hObject, handles);

% --------------------------------------------------------------------
function loadDi_Callback(hObject, eventdata, handles)
% hObject    handle to loadDi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function loadMono_Callback(hObject, eventdata, handles)
% hObject    handle to loadMono (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function loadgray_Callback(hObject, eventdata, handles)
% hObject    handle to loadgray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function roiOptions_Callback(hObject, eventdata, handles)
% hObject    handle to roiOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function drawROI_Callback(hObject, eventdata, handles)
% hObject    handle to roiOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.ImageShow);
handles.mask = roipoly; 

handles.I = zeros(size(handles.merge));
for i = 1:size(handles.merge,3);
    tempImage = handles.merge(:,:,i);
    tempImage(handles.mask == 0) = 0;
    handles.I(:,:,i) = tempImage;
end

[handles.borders,~] = bwboundaries(handles.mask);

guidata(hObject, handles);
