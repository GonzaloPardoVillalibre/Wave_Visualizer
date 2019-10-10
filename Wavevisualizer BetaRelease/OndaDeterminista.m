%% Funciones de opening del fichero
function varargout = OndaDeterminista(varargin)
% ONDADETERMINISTA MATLAB code for OndaDeterminista.fig
%      ONDADETERMINISTA, by itself, creates a new ONDADETERMINISTA or raises the existing
%      singleton*.
%
%      H = ONDADETERMINISTA returns the handle to a new ONDADETERMINISTA or the handle to
%      the existing singleton*.
%
%      ONDADETERMINISTA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONDADETERMINISTA.M with the given input arguments.
%
%      ONDADETERMINISTA('Property','Value',...) creates a new ONDADETERMINISTA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OndaDeterminista_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OndaDeterminista_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OndaDeterminista

% Last Modified by GUIDE v2.5 04-Nov-2018 19:40:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OndaDeterminista_OpeningFcn, ...
                   'gui_OutputFcn',  @OndaDeterminista_OutputFcn, ...
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
function OndaDeterminista_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

end
function varargout = OndaDeterminista_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

%% Funcion que me permite determinar la forma que voy a elegir
function format_Callback(hObject, eventdata, handles)
set(handles.paramt1,'BackgroundColor',[1 1 1]);
set(handles.paramt2,'BackgroundColor',[1 1 1]);
set(handles.numpert,'BackgroundColor',[1 1 1]);


forma = get(handles.format,'value');
changeInterface(handles,forma);

end

%% Funcion que se encarga de coordinar la representacion
function [pista,fs]=dibujando_tiempo_Callback(hObject, eventdata, handles)

  dbt = get(handles.dibujando_tiempo,'value');

                       %Comienzo a generar mi señal en tiempo

  set(handles.dibujando_tiempo,'value',1);
  
  axes(handles.axes2)
  cla(handles.axes2);
  axes(handles.axes1)
  cla(handles.axes1);
% %Valoro el tipo de onda con el que quiero trabajar
% dbf = get(handles.dibujando_tiempo,'value');

%Veo qué funcion estoy queriendo representar
forma = get(handles.format,'value');

    switch forma
        case 1
            [pista,fs]=buildcos(hObject,handles);
        case 2
            [pista,fs]=buildsin(hObject,handles);
        case 3
            [pista,fs]=buildsinc(hObject,handles);
        case 4
           [pista,fs]=buildtriang(hObject, handles);
        case 5
            [pista,fs]=buildrectan(hObject,handles);
        case 6
            [pista,fs]=buildescalon(hObject,handles);
        case 7
            [pista,fs]=buildescalondisc(hObject,handles);
        case 8
            [pista,fs]=buildpulso(hObject,handles);
        otherwise
            exit;

    end
        

end

%% Funcion característica para generar cada señal
%% Funcion característica para generar cada señal
function [pista,fs]=buildcos(hObject,handles)

   a = get(handles.paramt1,'string');
   a=str2double(a);
   T= get(handles.paramt2,'string');
   T=str2double(T);
   
   if get(handles.periodicat,'value')==1
     numpert=get(handles.numpert,'string'); 
     numpert=str2double(numpert);
     t=linspace(0,T*numpert,44100);
   else
       numpert=1;
       t=linspace(0,T,44100);
   end
   pista=a*cos(2*pi*1/T*t);
   fs=44100/(T*numpert);
   plot(handles.axes1,t,pista);
   axis([0 max(t) -a-a/5 a+a/5])

end
function [pista,fs]=buildsin(hObject,handles)
       
   a = get(handles.paramt1,'string');
   a=str2double(a);
   T= get(handles.paramt2,'string');
   T=str2double(T);
   
   if get(handles.periodicat,'value')==1
     numpert=get(handles.numpert,'string'); 
     numpert=str2double(numpert);
     t=linspace(0,T*numpert,44100);
   else
        numpert=1;
        t=linspace(0,T,44100);
   end
  pista=a*sin(2*pi*1/T*t);
  fs=44100/(T*numpert);
  plot(handles.axes1,t, pista);
  axis([0 max(t) -a-a/5 a+a/5])
  



end
function [pista,fs]=buildrectan(hObject,handles)
        
   a = get(handles.paramt1,'string');
   a=str2double(a);
   T= get(handles.paramt2,'string');
   T=str2double(T);
    
   f=1/T;
   w = 2*pi*f;
   
   
   if get(handles.periodicat,'value')==1
     numpert=get(handles.numpert,'string'); 
     numpert=str2double(numpert);
     t=linspace(0,numpert*T,44100);
     
   else
     numpert=1;
     t=linspace(0,1*T,44100);
   end
     
   sq = a*square(w*t);
   plot(handles.axes1,t,sq);
   axis([0 max(t) -a-a/5 a+a/5])


   pista=sq;
   fs=44100/(T*numpert);
 
   
end
function [pista,fs]=buildtriang(hObject,handles)
     
   a = get(handles.paramt1,'string');
   a=str2double(a);
   T= get(handles.paramt2,'string');
   T=str2double(T);
    
   f=1/T;
   w = 2*pi*f;
   
   
   if get(handles.periodicat,'value')==1
     numpert=get(handles.numpert,'string'); 
     numpert=str2double(numpert);
     t=linspace(0,numpert*T,44100);
     
   else
     numpert=1;
     t=linspace(0,1*T,44100);
   end
     
   sq=a*sawtooth(w * t + 0);
   plot(handles.axes1,t,sq);
   axis([0 max(t) -a-a/5 a+a/5])

   pista=sq/max(abs(sq));
  fs=44100/(T*numpert);
end
function [pista,fs]= buildpulso(hObject,handles)
    a = get(handles.paramt1,'string');
    a=str2double(a);
    T= get(handles.paramt2,'string');
    T=str2double(T);
    if (T<20)
        u=a*[zeros(1,T) ones(1,1) zeros(1,18)];
        t=linspace(0,T+19,T+19);
    end
    if (T >= 20)
       u=a*[zeros(1,T) ones(1,1) zeros(1,2*T)];
       t=linspace(0,3*T+1,3*T+1);
    end
    stem(t,u);
    axis([0 max(t) -a-a/5 a+a/5])
    xlabel('milisegundos')

    pista= u;
    fs=2000;

end
function [pista,fs]=buildescalondisc(hObject,handles)
 
    a = get(handles.paramt1,'string');
    a=str2double(a);
    T= get(handles.paramt2,'string');
    T=str2double(T);
    if (T<20)
        u=a*[zeros(1,T), ones(1,30)];
        t=linspace(0,30+T,30+T);
    end
    if (T >= 20)
       u=a*[zeros(1,T), ones(1,2*T)];
       t=linspace(0,3*T,3*T);
    end
    stem(t,u);
    axis([0 max(t) -a-a/5 a+a/5])
    xlabel('milisegundos')

    pista= u;
    fs=2000;

end
function [pista,fs]=buildescalon(hObject,handles)

   a = get(handles.paramt1,'string');
   a=str2double(a);
   T= get(handles.paramt2,'string');
   T=str2double(T);
 
   U = a*[zeros(1, 50 ), ones(1, 50)];
   t=linspace(0,2*T,length(U));
   
   plot(handles.axes1,t,U);
   axis tight
   axis([0 max(t) -a-a/5 a+a/5])
   
    pista= U;
    fs=floor(44100/(2*T));
  
end
function [pista,fs]=buildsinc(hObject,handles)

   a = get(handles.paramt1,'string');
   a=str2double(a);
   T= get(handles.paramt2,'string');
   T=str2double(T)/2;
   
   x=linspace(-T,T,44100*2);
   plot(x,sinc(x))
   axis([0 max(t) -a-a/5 a+a/5])
   
   pista= a*sinc(x);
   fs=floor(44100/(2*T));
  
  
end

%% Función que modifica la interfaz dependiendo del tipo de señal
function changeInterface(handles,form)

if (form == 7 || form==8 || form==3)
    set(handles.periodicat,'visible','off');
    set(handles.text15,'visible','off');
    set(handles.numpert,'visible','off');   
else
    set(handles.periodicat,'visible','on');  
    set(handles.text15,'visible','on');
    set(handles.numpert,'visible','on');
end

switch form
   case 1
      set(handles.textot1,'String','Amplitud');
      set(handles.textot2,'String','Anchura periodo');
   case 2
      set(handles.textot1,'String','Amplitud');
      set(handles.textot2,'String','Anchura periodo');
   case 3
      set(handles.textot1,'String','Atura máx.');
      set(handles.textot2,'String','Anchura        ');
   case 4
      set(handles.textot1,'String','Pendiente');
      set(handles.textot2,'String','Ordenada origen');
   case 5
      set(handles.textot1,'String','Altura     ');
      set(handles.textot2,'String','Anchura base   ');
   case 6
      set(handles.textot1,'String','Altura     ');
      set(handles.textot2,'String','Anchura periodo');
   case 7
      set(handles.textot1,'String','Altura     ');
      set(handles.textot2,'String','Instante             ');
   case 8
      set(handles.textot1,'String','Altura     ');
      set(handles.textot2,'String','Instante             ');
   case 9
      set(handles.textot1,'String','Altura     ');
      set(handles.textot2,'String','Anchura periodo');
      
      
   otherwise
      exit;
end
    
end

%% Funcion que actuilizar la memoria de la señal que guardamos y de hacer la TF
function dt_Callback(hObject, eventdata, handles)

    [handles.pista,handles.fs]=dibujando_tiempo_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
    axes(handles.axes2)
    cla(handles.axes2);
    [TF,f]=transformada(handles.pista,handles.fs,handles);
    plot(f,abs(TF));
    xlabel('frequency [Hz]');
    ylabel('amplitude [Hz]');
    
end

%% Funcion que se encarga de hacer la transformada de fourir
function [tf,f] = transformada(x,fs,handles)

    N=length(x);
    tf=fft(x)/N;
    size(tf);
    tf=abs(tf(1:floor(N/2+1)));
    f=linspace(0,fs/2,N/2+1);
  
end

%% Funcion que se encarga de guardar la pista
function save_ClickedCallback(hObject, eventdata, handles)
try
if get(handles.dibujando_tiempo,'value')==0 
   return 
end

[s,path]=uiputfile('*.wav','Guardar señal determinista de audio');

 if(s~=0)
    handles.pista= handles.pista/max(abs(handles.pista));
    audiowrite(s,handles.pista,handles.fs); 
    close(OndaDeterminista);
 end
catch
 f = msgbox('Periodo grande grande disminuya la anchura de periodo"'); 
end
end


%% Callbacks de botones
function paramt2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paramt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function paramt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paramt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function periodicat_Callback(hObject, eventdata, handles)
% hObject    handle to periodicat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of periodicat
end
function numpert_Callback(hObject, eventdata, handles)
 set(handles.numpert,'BackgroundColor',[0 1 0]);
end
function numpert_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numpert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function Coseno_Callback(hObject, eventdata, handles)
% hObject    handle to Coseno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function Seno_Callback(hObject, eventdata, handles)
% hObject    handle to Seno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function Triangular_Callback(hObject, eventdata, handles)
% hObject    handle to Triangular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function Tipo_Callback(hObject, eventdata, handles)
% hObject    handle to Tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function format_CreateFcn(hObject, eventdata, handles)

end
function paramt1_Callback(hObject, eventdata, handles)
  set(handles.paramt1,'BackgroundColor',[0 1 0]);
end
function paramt2_Callback(hObject, eventdata, handles)
 set(handles.paramt2,'BackgroundColor',[0 1 0]);
end
