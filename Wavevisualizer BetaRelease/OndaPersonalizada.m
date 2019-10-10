%% Funciones de opening del fichero
function varargout = OndaPersonalizada(varargin)
% ONDAPERSONALIZADA MATLAB code for OndaPersonalizada.fig
%      ONDAPERSONALIZADA, by itself, creates a new ONDAPERSONALIZADA or raises the existing
%      singleton*.
%
%      H = ONDAPERSONALIZADA returns the handle to a new ONDAPERSONALIZADA or the handle to
%      the existing singleton*.
%
%      ONDAPERSONALIZADA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONDAPERSONALIZADA.M with the given input arguments.
%
%      ONDAPERSONALIZADA('Property','Value',...) creates a new ONDAPERSONALIZADA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OndaPersonalizada_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OndaPersonalizada_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OndaPersonalizada

% Last Modified by GUIDE v2.5 20-Nov-2018 15:08:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OndaPersonalizada_OpeningFcn, ...
                   'gui_OutputFcn',  @OndaPersonalizada_OutputFcn, ...
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
end
function OndaPersonalizada_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OndaPersonalizada (see VARARGIN)

% Choose default command line output for OndaPersonalizada
handles.output = hObject;
handles.final=0;
handles.unidades=0;
handles.senal=0;
handles.tiempos=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OndaPersonalizada wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end
function varargout = OndaPersonalizada_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

%% Funciones que controlan la introducción de parámetros
function funtionhandle_Callback(hObject, eventdata, handles)
           
    set(handles.ok2,'String','ok');
    set(handles.funtionhandle,'BackgroundColor',[0 1 0]);    
 
end
function funtionhandle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funtionhandle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function puntofinal_Callback(hObject, eventdata, handles)
    set(handles.ok1,'String','ok');
    set(handles.puntofinal,'BackgroundColor',[0 1 0]);       
end
function anadir_Callback(hObject, eventdata, handles)
    
    c1=get(handles.ok1,'String');
    c2=get(handles.ok2,'String');
   try
    if (strcmp(c1,'ok') && strcmp(c2,'ok')) 
        f=get(handles.funtionhandle,'String');
        fh = str2func(f);
 
        handles.final= get(handles.puntofinal,'String');
        handles.final=str2num(handles.final);
        inicionum=str2num(get(handles.inicio,'String'));
        handles.unidades= (handles.final)-(inicionum);
   
        handles.T=linspace(inicionum,handles.final, handles.unidades*44100);
   
        funcion=fh(handles.T);
 
        handles.senal= [handles.senal,funcion];
        handles.tiempos=[handles.tiempos,handles.T];
        plot(handles.tiempos,handles.senal);
        
        set(handles.puntofinal,'BackgroundColor',[0.94 0.94 0.94]);
        set(handles.funtionhandle,'BackgroundColor',[0.94 0.94 0.94]);
        set(handles.ok1,'String',' ');
        set(handles.ok2,'String',' ');
        set(handles.puntofinal,'String',' ');
        set(handles.funtionhandle,'String','@(x) ');
        set(handles.inicio,'String',num2str(handles.final));
        
        guidata(hObject, handles);     
        
    end
   catch
        f = msgbox('Expresión no valida');
        set(handles.puntofinal,'BackgroundColor',[0.94 0.94 0.94]);
        set(handles.funtionhandle,'BackgroundColor',[0.94 0.94 0.94]);
        set(handles.ok1,'String',' ');
        set(handles.ok2,'String',' ');
        set(handles.puntofinal,'String',' ');
        set(handles.funtionhandle,'String','@(x) ');             
   end
    
 
end


%% Executes on button press in save.
 function save_Callback(hObject, eventdata, handles)

 if(length(handles.senal)~=1)
    [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
     if(s~=0)
        max(handles.senal)
        handles.senal= handles.senal/max(abs(handles.senal));
        audiowrite(s,handles.senal,44100); 
        close(OndaPersonalizada);
     end
 end
end
