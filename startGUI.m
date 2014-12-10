function varargout = startGUI(varargin)
% STARTGUI MATLAB code for startGUI.fig
%      STARTGUI, by itself, creates a new STARTGUI or raises the existing
%      singleton*.
%
%      H = STARTGUI returns the handle to a new STARTGUI or the handle to
%      the existing singleton*.
%
%      STARTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTGUI.M with the given input arguments.
%
%      STARTGUI('Property','Value',...) creates a new STARTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before startGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to startGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help startGUI

% Last Modified by GUIDE v2.5 01-Dec-2014 18:46:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @startGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @startGUI_OutputFcn, ...
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


% --- Executes just before startGUI is made visible.
function startGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to startGUI (see VARARGIN)

global OB
OB = Battleship;

% Choose default command line output for startGUI
handles.output = hObject;

% Set intro text
%intro=OB.getnextquest();
intro = 'Welcome to Neuron Battleship';
set(handles.text1,'string',intro,'FontSize',11);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes startGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = startGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%global selection


uiwait;
varargout{1}=guidata(handles.popupmenu1);

%varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function selection = popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global OB
%global selection

pmStr=cellstr(get(hObject,'String'));
selection=pmStr{get(hObject,'Value')};
%disp(selection)
guidata(handles.popupmenu1,selection);

OB.setLevel(selection);  
% handles.output=selection;
uiresume;


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
