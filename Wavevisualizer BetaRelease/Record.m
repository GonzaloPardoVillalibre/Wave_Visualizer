%% Funciones de opening del fichero
function varargout = Record(varargin)
% RECORD MATLAB code for Record.fig
%      RECORD, by itself, creates a new RECORD or raises the existing
%      singleton*.
%
%      H = RECORD returns the handle to a new RECORD or the handle to
%      the existing singleton*.
%
%      RECORD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECORD.M with the given input arguments.
%
%      RECORD('Property','Value',...) creates a new RECORD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Record_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      finalizar.  All inputs are passed to Record_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Record

% Last Modified by GUIDE v2.5 14-Nov-2018 18:55:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Record_OpeningFcn, ...
                   'gui_OutputFcn',  @Record_OutputFcn, ...
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
function Record_OpeningFcn(hObject, eventdata, handles, varargin)
handles.pista=audiorecorder(44100,16,1); %Generamos la varibale donde vamos a guardar nuestra pista en mono.
handles.PistaVector=0;

%Choose default command line output for Record
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end
function varargout = Record_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

end

%% Funciones que manejan los botones de la interfaz
function start_Callback(hObject, eventdata, handles)

%Control apariencia boton
str = get(handles.start,'String')
if strcmp('Empezar',str)
   set(handles.start,'String','Pausar');
    set(handles.start,'CData',imread('icon-pause.png','backgroundcolor',[1 1 1]))
   set(handles.finalizar,'visible','on');
   record(handles.pista);
elseif strcmp('Empezar de nuevo',str)
   set(handles.pushbutton9,'visible','off');
   handles.PistaVector=0;
   guidata(hObject, handles);
   axes(handles.axes1);
   cla(handles.axes1);
   axes(handles.axes2);
   cla(handles.axes2);
   set(handles.start,'String','Pausar');
   set(handles.start,'CData',imread('icon-pause.png','backgroundcolor',[1 1 1]))
   record(handles.pista);
elseif strcmp('Pausar',str)
  set(handles.start,'String','Continuar');
  set(handles.start,'CData',imread('icon-play.png','backgroundcolor',[1 1 1]))
  pause(handles.pista);
else 
  set(handles.start,'String','Pausar');
  set(handles.start,'CData',imread('icon-pause.png','backgroundcolor',[1 1 1]))
  resume(handles.pista);
 end
end
function finalizar_Callback(hObject, eventdata, handles)

%    try
    set(handles.pushbutton9,'visible','on');
    set(handles.start,'String','Empezar de nuevo');               %Al dar al boton de finalizar paramos la grabacion
    set(handles.start,'CData',imread('icon-reload.png','backgroundcolor',[1 1 1]));
    stop(handles.pista);                                 %y creamos el archivo de audi

    handles.PistaVector= getaudiodata(handles.pista);    %En esta fila lo que hacemos es pasarlo a vector
    guidata(hObject,handles);
    axes(handles.axes1);
    cla(handles.axes1);
    plot(handles.axes1,handles.PistaVector);             %Mostramos la señal que acabamos de crear
    xlabel('Seconds'); ylabel('Amplitude');

    handles.PistaVector = sum(handles.PistaVector, 2) / size(handles.PistaVector, 2);
    axes(handles.axes2)
    cla(handles.axes2);
    [TF,f]=transformada(handles.PistaVector,44100,handles);
    plot(f,abs(TF));
    xlabel('frequency [Hz]');
    ylabel('amplitude [Hz]');
%    catch
%     f = msgbox('No hay audio ');     
%    end


end
function cancelar_Callback(hObject, eventdata, handles)
    close(Record);
end
function guardar_Callback(hObject, eventdata, handles)
 if(length(handles.PistaVector)~=1)
     [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
    if(s~=0)
          audiowrite(s,handles.PistaVector,44100); 
          close(Record);
    end
    
 end
end
function pushbutton9_Callback(hObject, eventdata, handles)
 
  sound(handles.PistaVector,44100);
 
end

%% Funcion que hace la transformada de la señal grabada
function [tf,f] = transformada(x,fs,handles)

   
    N=length(x);
    tf=fft(x,N)/N;
    tf = abs(tf(1:(N/2+1)));
    f=linspace(0,fs/2,(N/2+1)); 
  
      
end
