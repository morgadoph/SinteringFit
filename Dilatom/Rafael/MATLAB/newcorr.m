function varargout = newcorr(varargin)
% NEWCORR M-file for newcorr.fig
%      NEWCORR, by itself, creates a new NEWCORR or raises the existing
%      singleton*.
%
%      H = NEWCORR returns the handle to a new NEWCORR or the handle to
%      the existing singleton*.
%
%      NEWCORR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWCORR.M with the given input arguments.
%
%      NEWCORR('Property','Value',...) creates a new NEWCORR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newcorr_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newcorr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Edit the above text to modify the response to help newcorr
%
% Last Modified by GUIDE v2.5 11-Jun-2011 14:50:41
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newcorr_OpeningFcn, ...
                   'gui_OutputFcn',  @newcorr_OutputFcn, ...
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

% --- Executes just before newcorr is made visible.
function newcorr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newcorr (see VARARGIN)
%
% Choose default command line output for newcorr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%subplot
%figure
%plot(tt, correlacion);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using newcorr.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
    
end

% UIWAIT makes newcorr wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newcorr_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    func1 = input('joder1  :                       ','s');
    tt1i  = input('limite inferior del intervalo : ');
    tt1s  = input('limite superior del intervalo : ');
    %peri1 = input('es periodica?  : 1 o 0          ');
    %Per1  = input('periodo  :                      ');
    func2 = input('joder2  :                       ','s');
    tt2i  = input('limite inferior del intervalo : ');
    tt2s  = input('limite superior del intervalo : ');
    %peri2 = input('es periodica?  : 1 o 0          ');
    %Per2  = input('periodo  :                      ');
    n1    = input('muestras  :                     ');
    selector = 1;


% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');



%     func1 = input('joder1  :                       ','s');
%     tt1i  = input('limite inferior del intervalo : ');
%     tt1s  = input('limite superior del intervalo : ');
%     %peri1 = input('es periodica?  : 1 o 0          ');
%     %Per1  = input('periodo  :                      ');
%     func2 = input('joder2  :                       ','s');
%     tt2i  = input('limite inferior del intervalo : ');
%     tt2s  = input('limite superior del intervalo : ');
%     %peri2 = input('es periodica?  : 1 o 0          ');
%     %Per2  = input('periodo  :                      ');
%     n1    = input('muestras  :                     ');
%     selector = 1;


paso1 = (tt1s - tt1i)/n1;
n2    = (tt2s - tt2i)/paso1;
%paso2 = (tt2s - tt2i)/n2;
t     = -(tt1i+tt2i):paso1:(tt1s+tt2s);
a     = size(t);
b     = a(2);
vec1  = zeros(1, n1+1);
vec2  = zeros(1, n2+1);
t1=zeros(1, n1+1);
t2=zeros(1, n2+1);
for i=1 : 1 : n1 + 1, %vector de la funcion 1
    s = tt1i + (i-1)*paso1;
    mientras = eval(func1);
    vec1(i) = mientras;
    t1(i) = tt1i+(i-1)*paso1 ;
end
i=0;
s=0;
for i=1 : 1 : n2 + 1, %vector de la funcion 2
    s = tt2i + (i-1)*paso1;
    vec2(i) = eval(func2);
    t2(i) = tt2i+(i-1)*paso1 ;
end
vec1;
vec2;
%hold on;
%plot(t1,vec1);
%hold on;
%plot(t2,vec2);
%hold on;
i=0;
correlacion = zeros(1, b);
primo = zeros(1, n2+1);
%terco = zeros(1, n2+1);
estacion = [primo, vec1, primo];
estaciont = zeros(1, (2*(n2)+n1));
correlacion = zeros(1, n1 + n2 + 1);
for i = 1 : 1: (n1 + n2) , % ciclo de ubicacion de los vectores            Correlacion
    primo2 = zeros(1, i);
    terco2 = zeros(1, ((2*(n2)+n1)-i-n2));
    estaciont = [primo2, vec2, terco2];
    for j = 1 : 1 : (n1 + 2*n2) , % ciclo de integracion
        multiplicacion(j) = estacion(j) * estaciont(j);
    end
    for k = 1 : 1 : (n1 + 2*n2) ,
        correlacion(i)= correlacion(i) + (multiplicacion(k) * paso1);
    end
end
tt = -((tt2s - tt2i)/2) : paso1 : (((n1 + n2)*paso1)-((tt2s - tt2i)/2));



switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
    case 6
        plot(t2,vec2);
    case 7
        plot(t1,vec1);
    case 8
        plot(tt,correlacion);
        
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%
%plot(correlacion)
%
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)', 'plot(funcion 1)', 'plot(funcion 2)', 'plot(correlacion)'});
