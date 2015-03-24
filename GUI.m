function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 24-Mar-2015 15:00:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadLeft.
function loadLeft_Callback(hObject, eventdata, handles)

%Allow user to select an image file to process
[fileName,pathName] = uigetfile({'*.bmp';'*.jpg'},'Select image to process');

%get image name and read in image
imageName = [pathName,fileName];
image = imread(imageName);

%store image so it can be used in other functions

data = guidata(hObject);
data.leftImage = image;
guidata(hObject,data);

%display image
axes(handles.leftAxes);
imshow(image);


% --- Executes on button press in rightLoad.
function rightLoad_Callback(hObject, eventdata, handles)

%Allow user to select an image file to process
[fileName,pathName] = uigetfile({'*.bmp';'*.jpg'},'Select image to process');

%get image name and read in image
imageName = [pathName,fileName];
image = imread(imageName);

%store image so it can be used in other functions
data = guidata(hObject);
data.rightImage = image;
guidata(hObject,data);

%display image
axes(handles.rightAxes);
imshow(image);


% --- Executes on button press in makeMap.
function makeMap_Callback(hObject, eventdata, handles)

data = guidata(hObject);

try
%get images
leftImage = data.leftImage;
rightImage = data.rightImage;
catch
 h = msgbox('You must select a right and left image!');   
end

%get search window size
contents = get(handles.searchSize,'String'); 
searchSize = str2double(contents{get(handles.searchSize,'Value')});

%get support window size
contents = get(handles.supportSize,'String'); 
supportSize = str2double(contents{get(handles.supportSize,'Value')});

contents = get(handles.dispMethod,'String'); 
dispMethod = contents{get(handles.dispMethod,'Value')};

if searchSize < supportSize
h = msgbox('Search window must be larger than support window!');
else       
dispMap = DISP_MAP(leftImage, rightImage, searchSize, searchSize,supportSize,supportSize,dispMethod);
figure, imshow(mat2gray(dispMap));
end



% --- Executes on selection change in supportSize.
function supportSize_Callback(hObject, eventdata, handles)
% hObject    handle to supportSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns supportSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from supportSize


% --- Executes during object creation, after setting all properties.
function supportSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to supportSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in searchSize.
function searchSize_Callback(hObject, eventdata, handles)
% hObject    handle to searchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns searchSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from searchSize


% --- Executes during object creation, after setting all properties.
function searchSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to searchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function dispMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dispMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dispMethod.
function dispMethod_Callback(hObject, eventdata, handles)
% hObject    handle to dispMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dispMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dispMethod
