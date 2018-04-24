function varargout = detection(varargin)
% DETECTION MATLAB code for detection.fig
%      DETECTION, by itself, creates a new DETECTION or raises the existing
%      singleton*.
%
%      H = DETECTION returns the handle to a new DETECTION or the handle to
%      the existing singleton*.
%
%      DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTION.M with the given input arguments.
%
%      DETECTION('Property','Value',...) creates a new DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detection

% Last Modified by GUIDE v2.5 24-Apr-2018 19:33:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detection_OpeningFcn, ...
                   'gui_OutputFcn',  @detection_OutputFcn, ...
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


% --- Executes just before detection is made visible.
function detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detection (see VARARGIN)

% Choose default command line output for detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
n=get(handles.popupmenu1,'Value');
name={'person','car','aeroplane','bicycle','bird','boat'...
    ,'bottle','bus','cat','chair','cow','diningtable'...
    ,'dog','horse','motorbike','pottedplant','sheep','train','tvmonitor'};
load (['VOC2007/' name{1,n} '_final.mat']); % car model trained on the PASCAL 2007 dataset       % test image
im=imread('00001.jpg');
bbox = process(im, model, -0.5);% detect objects
if length(bbox)==0
    bbox=[0 0 0 0];
end
top = nms(bbox, 0.5);
x1 = top(:,1);
    y1 = top(:,2);
    x2 = top(:,3);
    y2 = top(:,4);
bbox=[x1 y1 x2-x1 y2-y1];
im=insertShape(im, 'Rectangle', bbox);
axes(handles.axes2);
imshow(im);
title('detected photos');

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'});  
if filename==0  
    msgbox('«Î—°‘Ò“ª’≈’’∆¨ºÏ≤‚');  
else  
    filepath=[pathname,filename];  
    axes(handles.axes1);  
    imshow(imread(filepath)); 
    imwrite(imread(filepath),'00001.jpg')
    title('selected photos');
end  
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
