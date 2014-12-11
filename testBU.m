function varargout = testBU(varargin)
% TESTBU MATLAB code for testBU.fig
%      TESTBU, by itself, creates a new TESTBU or raises the existing
%      singleton*.
%
%      H = TESTBU returns the handle to a new TESTBU or the handle to
%      the existing singleton*.
%
%      TESTBU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTBU.M with the given input arguments.
%
%      TESTBU('Property','Value',...) creates a new TESTBU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testBU_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testBU_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testBU

% Last Modified by GUIDE v2.5 10-Dec-2014 21:29:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testBU_OpeningFcn, ...
                   'gui_OutputFcn',  @testBU_OutputFcn, ...
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


% --- Executes just before testBU is made visible.
function testBU_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testBU (see VARARGIN)
global showB
global x
global y
global map1

nrnB=zeros(5);
nrnB([1:3])=.25;
nrnB(2,2)=1;
nrnB([12,17])=.5;
showB=nrnB;
map1=[1 0 0; 1 0 0; 1 0 0; 1 0 0];
x=0;
y=0;

imagesc(showB,'Parent',handles.axes1);
pbaspect([5 5 1]);
set(handles.axes1,'xtick',linspace(0.5,5+0.5,5+1),'ytick',linspace(0.5,5+0.5,5+1));
set(handles.axes1,'XTickLabel','','YTickLabel','');
set(handles.axes1,'xgrid','on','ygrid','on','gridlinestyle','-');
colormap(map1);
freezeColors(handles.axes1);

% Choose default command line output for testBU
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testBU wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testBU_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
global showB
global x
global y
global map1

if x==0
    [x,y]=getpts(handles.axes1)
    x=round(x);
    y=round(y);
    showB(y,x)=1.5;
    map2=[map1;0 0 1];
    unfreezeColors(handles.axes1);
    imagesc(showB,'Parent',handles.axes1)
    pbaspect([5 5 1]);
    set(handles.axes1,'xtick',linspace(0.5,5+0.5,5+1),'ytick',linspace(0.5,5+0.5,5+1));
    set(handles.axes1,'XTickLabel','','YTickLabel','');
    set(handles.axes1,'xgrid','on','ygrid','on','gridlinestyle','-');
    colormap(map2)
    freezeColors(handles.axes1);    
else
    x=0;
    y=0;
end


