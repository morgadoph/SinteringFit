
function varargout = general(varargin)
% GENERAL M-file for general.fig
%      GENERAL, by itself, creates a new GENERAL or raises the existing
%      singleton*.
%
%      H = GENERAL returns the handle to a new GENERAL or the handle to
%      the existing singleton*.
%
%      GENERAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERAL.M with the given input arguments.
%
%      GENERAL('Property','Value',...) creates a new GENERAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before general_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to general_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help general

% Last Modified by GUIDE v2.5 24-May-2011 16:20:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @general_OpeningFcn, ...
                   'gui_OutputFcn',  @general_OutputFcn, ...
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


% --- Executes just before general is made visible.
function general_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to general (see VARARGIN)

% Choose default command line output for general
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes general wait for user response (see UIRESUME)
% uiwait(handles.covcorr);


% --- Outputs from this function are returned to the command line.
function varargout = general_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in convolucion.
function convolucion_Callback(hObject, eventdata, handles)
% hObject    handle to convolucion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %Juan Camilo Gutiérrez Pineda - 1128468364
%Tarea #2 PDS
%Programa para calcular la convolución entre dos vectores
%se hace con respecto a la respuesta natural de un sistema LTI ante una
%excitación.
%Ejercicio planteado en clase: 
%Hallar la convolución de X(n)={3,11,7,0,-1,4,2} , -3<=n<=3  y
%h(n)={2,3,0,-5,2,1} , -1<=n<=4
clear all;
clc;
x=[3,11,7,0,-1,4,2];
h=[2,3,0,-5,2,1];
nx=-10:1:10;
nh=-10:1:10;
nyb=nx(1)+nh(1);
nye=nx(7)+nh(6);
tiempo=nyb:1:nye;
Y=conv(x,h)
%Graficación de la convolución y visualización de título y ejes. 
stem(tiempo,Y,'filled')
title ('Convolución en timpo discreto de x(n)y h(n)')
xlabel('Número de muestras n')
ylabel('Y(n)')
xlim([nyb-1 nye+1])
hold;
%Grafcación de la señal de excitación y visualización de título y ejes.
% figure;
% hold;
% stem(nx,x,'filled')
% title ('Señal de excitación')
% xlabel('Número de muestras n')
% ylabel('x(n)')
%Grafcación de la respuesta natural del sistema y visualización de título y ejes.
% figure;
% hold;
% stem(nh,h,'filled')
% title ('Respuesta natural del sistema')
% xlabel('Número de muestras n')
% ylabel('h(n)')
% clear all;




% --- Executes on button press in correlacion.
function correlacion_Callback(hObject, eventdata, handles)
% hObject    handle to correlacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all;
clc;
n=-10:1:10;
k=-100:1:100;




% --- Executes on button press in salir.
function salir_Callback(hObject, eventdata, handles)
% hObject    handle to salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close;
