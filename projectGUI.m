%not a folder
function varargout = projectGUI(varargin)
% PROJECTGUI MATLAB code for projectGUI.fig
%      PROJECTGUI, by itself, creates a new PROJECTGUI or raises the existing
%      singleton*.
%
%      H = PROJECTGUI returns the handle to a new PROJECTGUI or the handle to
%      the existing singleton*.
%
%      PROJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTGUI.M with the given input arguments.
%
%      PROJECTGUI('Property','Value',...) creates a new PROJECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before projectGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to projectGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help projectGUI

% Last Modified by GUIDE v2.5 23-Nov-2014 13:19:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @projectGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @projectGUI_OutputFcn, ...
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




% --- Executes just before projectGUI is made visible.
function projectGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to projectGUI (see VARARGIN)

% No idea where to initialize this - I keep getting errors that the
% expression to the left of the equals sign is not a valid target. Also
% can't put it at the top or it will screw with the function
global OB;
OB = Battleship;
%OB=test(1,1);

% Use case to determine what question to put in the static text box.

welcome = OB.getnextquest();
%welcome = 'Hello! Welcome to Neuron Battleship... blah blah blah';
set(handles.text1,'string',welcome,'FontSize',12);

% Do the same for the Notebook
set(handles.text2,'string','Notebook','FontSize',12);

% Choose default command line output for projectGUI
handles.output = hObject;

% Plot grid and neuron
% I know it's not pretty but it's working.
brd = OB.board.getBoard;
shownBrd=zeros(size(brd));
nrn = OB.neuron.getNeuron;

bx=size(brd,2); nx=size(nrn,2);
by=size(brd,1); ny=size(nrn,1);
eXLabel=cell(1,(bx+1));
for i=1:(bx+1)
    eXLabel{i}=num2str(i-1);
end

eYLabel=cell(1,(by+1));
for i=1:(by+1)
    eYLabel{i}=num2str(i-1);
end

imagesc(shownBrd,'parent',handles.axes1);
pbaspect([bx by 1]); %makes it look nice
set(handles.axes1,'xtick',linspace(0.5,bx+0.5,bx+1),'ytick',linspace(0.5,by+0.5,by+1));
set(handles.axes1,'XTickLabel',eXLabel,'YTickLabel',eYLabel);
set(handles.axes1,'xgrid','on','ygrid','on','gridlinestyle','-');

imagesc(nrn,'parent',handles.axes2);
pbaspect([nx ny 1]); %makes it look nice
set(handles.axes2,'xtick',linspace(0.5,nx+0.5,nx+1),'ytick',linspace(0.5,ny+0.5,ny+1));
set(handles.axes2,'XTickLabel','','YTickLabel','');
set(handles.axes2,'xgrid','on','ygrid','on','gridlinestyle','-');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes projectGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = projectGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

%k=waitforbuttonpress - can put this in a loop so that the getpts func only 
%runs when appropriate. I think it can go here? 
% [X,Y]=getpts(handles.axes1);
% varargout{2}=[X,Y];

varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

global OB

str1=get(hObject,'String');
str2=str1{1};
ansNum=str2num(str2);

%b.checkanswer(str2) - global that takes editbox answer and compares to
%answer list. Sends back string to update text1.

newText=OB.checkans(str2);
%newText=sprintf(ansStr);

set(handles.text1,'String',newText);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

