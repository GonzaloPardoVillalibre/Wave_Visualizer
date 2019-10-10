%% Funciones de opening del fichero
function varargout = filtradoSenales(varargin)
% FILTRADOSENALES MATLAB code for filtradoSenales.fig
%      FILTRADOSENALES, by itself, creates a new FILTRADOSENALES or raises the existing
%      singleton*.
%
%      H = FILTRADOSENALES returns the handle to a new FILTRADOSENALES or the handle to
%      the existing singleton*.
%
%      FILTRADOSENALES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTRADOSENALES.M with the given input arguments.
%
%      FILTRADOSENALES('Property','Value',...) creates a new FILTRADOSENALES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filtradoSenales_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filtradoSenales_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filtradoSenales

% Last Modified by GUIDE v2.5 23-Nov-2018 15:11:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @filtradoSenales_OpeningFcn, ...
    'gui_OutputFcn',  @filtradoSenales_OutputFcn, ...
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
function filtradoSenales_OpeningFcn(hObject, eventdata, handles, varargin)

        
        % Choose default command line output for filtradoSenales
        handles.output = hObject;

        
        
        handles.valor = [0 0 0 0];
        handles.tipoFiltro = 0;
        handles.senalFiltrada = 0;
        handles.senalEntrada = 0;
        handles.frecFiltro = 0;
        handles.NUM=0;
        handles.DEN=0;
        handles.fs=44100;
        
        % Update handles structure
        guidata(hObject, handles);
        % UIWAIT makes filtradoSenales wait for user response (see UIRESUME)
        % uiwait(handles.figure1);
    end
function varargout = filtradoSenales_OutputFcn(hObject, eventdata, handles)

        varargout{1} = handles.output;
end

%% Funciones que manejan los menus superiores
 function archivo_Callback(hObject, eventdata, handles)

        
 end
 function help_Callback(hObject, eventdata, handles)
        url = 'https://www.youtube.com/user/gonzalo198o';
        web(url);
        
 end
 function abrir_Callback(hObject, eventdata, handles)

        [file,path1] = uigetfile('*.wav','*.mp3');

        if(file~=0)

            s = strcat(path1,file);
            [handles.audio,handles.fs] = audioread(s);
            handles.senalEntrada = handles.audio;

            guidata(hObject, handles);

            MuestreoFrec(handles);

        end
    end
 function guardar_Callback(hObject, eventdata, handles)
         if(handles.senalFiltrada~=0)
        [s,~]=uiputfile('*.wav','Guardar señal determinista de audio');
        audiowrite(s,handles.senalFiltrada,44100); 
        close(filtradoSenales);
        end
    end
 function cancelar_Callback(hObject, eventdata, handles)
        close(filtradoSenales);
 end

%% Funciones que se encargan de recoger los puntos clave de frecuencias
function Wp_Callback(hObject, eventdata, handles)
 
        handles.WpValue = str2num(get(handles.Wp,'String'))/(handles.fs/2);
        set(handles.Wp,'BackgroundColor',[0 1 0]);
        handles.valor(1) = 1;
        guidata(hObject, handles);
    end
function Wp_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
end
function Ws_Callback(hObject, eventdata, handles)

        handles.WsValue = str2num(get(handles.Ws,'String'))/(handles.fs/2);
        set(handles.Ws,'BackgroundColor',[0 1 0]);
        handles.valor(2) = 1;
        guidata(hObject, handles);
end
function Ws_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    end
function Rp_Callback(hObject, eventdata, handles)

        handles.RpValue = str2num(get(handles.Rp,'String'));
        set(handles.Rp,'BackgroundColor',[0 1 0]);
        handles.valor(3) = 1;
        guidata(hObject, handles);
    end
function Rp_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    end
function Rs_Callback(hObject, eventdata, handles)

        handles.RsValue = str2num(get(handles.Rs,'String'));
        set(handles.Rs,'BackgroundColor',[0 1 0]);
        handles.valor(4) = 1;
        guidata(hObject, handles);
        
    end
function Rs_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    end
function Wp0_Callback(hObject, eventdata, handles)
        handles.Wp0Value = str2num(get(handles.Wp0,'String'))/(handles.fs/2);
        set(handles.Wp0,'BackgroundColor',[0 1 0]);
        guidata(hObject, handles);
    end
function Wp0_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    end
function Ws0_Callback(hObject, eventdata, handles)
        handles.Ws0Value = str2num(get(handles.Ws0,'String'))/(handles.fs/2);
        set(handles.Ws0,'BackgroundColor',[0 1 0]);
        guidata(hObject, handles);
end
function Ws0_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

%% Funciones que se encargan de generar el filtro y filtrar
function FILTRO_Callback(hObject, eventdata, handles) %#ok<*INUSL>

        if(sum(handles.valor)==4)
            [NUM,DEN]=calculaNumDen(handles);
            handles.senalFiltrada = filter(NUM,DEN,handles.senalEntrada);
            guidata(hObject, handles);
            MuestreoFrec2(handles);
        end
    end
function ActualizarFiltro_Callback(hObject, eventdata, handles)
    
    try
        if(get(handles.radioButterworth,'value') == 1)
            handles.tipoFiltro = 1;
        end
        if(get(handles.radioChebyshev,'value') == 1)
            handles.tipoFiltro = 2;
        end
        if(get(handles.radioCauer,'value') == 1)
            handles.tipoFiltro = 3;
        end
        if(get(handles.LPF,'value') == 1)
            handles.frecFiltro = 1;
            handles.WpValue = str2num(get(handles.Wp,'String'))/(handles.fs/2);
            handles.WsValue = str2num(get(handles.Ws,'String'))/(handles.fs/2);
        end
        if(get(handles.HPF,'value') == 1)
            handles.frecFiltro = 2;
            handles.WpValue = str2num(get(handles.Wp,'String'))/(handles.fs/2);
            handles.WsValue = str2num(get(handles.Ws,'String'))/(handles.fs/2);
        end
        if(get(handles.BPF,'value') == 1)
            handles.frecFiltro = 3;
            handles.WpValue = [str2num(get(handles.Wp0,'String'))/(handles.fs/2) str2num(get(handles.Wp,'String'))/(handles.fs/2)];
            handles.WsValue = [str2num(get(handles.Ws0,'String'))/(handles.fs/2) str2num(get(handles.Ws,'String'))/(handles.fs/2)];
        end
    guidata(hObject, handles);
    
    % Ahora se imprime el axis1 la transformada de la señal y el filtro
    axes(handles.axes1);
    cla(handles.axes1);
    [TF,f]=transformada(handles.audio,handles.fs);
    plot(f,TF);
    axis tight
    handles.V = axis;
    hold on
    [NUM,DEN]=calculaNumDen(handles);
    [h,w]=freqz(NUM,DEN);
    w1=w*handles.fs/8;
    filtro = abs(h)/length(handles.audio)*max(max(abs(fft(handles.audio))));
    plot(w1*max(f)/max(w1),filtro,'r')
    hold off
    
    set(handles.Wp,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.Ws,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.Wp0,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.Ws0,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.Rp,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.Rs,'BackgroundColor',[0.94 0.94 0.94]);
    
    guidata(hObject,handles);
   
    catch
         f = msgbox('Error en la creación del filtro'); 
    end

end

%% Funciones auxiliares para la representación por pantalla
function [tf,f] = transformada(x,fs)
        N=length(x);
        tf=fft(x,N)/N;
        tf = abs(tf(1:(N/2+1)));
        f=linspace(0,fs/2,(N/2+1)); 

end
function MuestreoFrec(handles)

        audio=handles.audio;
        audio = sum(audio, 2) / size(audio, 2);

        axes(handles.axes1);
        cla(handles.axes1);
        [TF,f]=transformada(audio,handles.fs);
        plot(f,TF);
        axis tight;
        xlabel('frequency [Hz]');
        ylabel('amplitude');
    end
function MuestreoFrec2(handles)

        audio=handles.senalFiltrada;
        audio = sum(audio, 2) / size(audio, 2);

        axes(handles.axes2);
        cla(handles.axes2);
        [TF2,f2]=transformada(audio,handles.fs);
        plot(f2,TF2);
        axis(handles.V)
        xlabel('frequency [Hz]');
        ylabel('amplitude');
end
function [NUM,DEN] = calculaNumDen(handles)
    filtro = (handles.tipoFiltro - 1)*3 + handles.frecFiltro;
    switch filtro
        case 0
            NUM=0; DEN=0;
        case 1
            [N,Wn]=buttord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=butter(N,Wn);
        case 2
            [N,Wn]=buttord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=butter(N,Wn,'high');
        case 3
            [N,Wn]=buttord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=butter(N,Wn);
        case 4
            [N,Wn]=cheb1ord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=cheby1(N,handles.RpValue,Wn);
        case 5
            [N,Wn]=cheb1ord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=cheby1(N,handles.RpValue,Wn,'high');
        case 6
            [N,Wn]=cheb1ord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=cheby1(N,handles.RpValue,Wn);
        case 7
            [N,Wn]=ellipord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=ellip(N,handles.RpValue,handles.RsValue,Wn);
        case 8
            [N,Wn]=ellipord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=ellip(N,handles.RpValue,handles.RsValue,Wn,'high');
        case 9
            [N,Wn]=ellipord(handles.WpValue,handles.WsValue,handles.RpValue,handles.RsValue);
            [NUM,DEN]=ellip(N,handles.RpValue,handles.RsValue,Wn);
    end
            
end

%% Funciones que manejan la seleccion del tipo de filtro
function BPF_Callback(hObject, eventdata, handles)
        set(handles.Wp0,'Visible','on');
        set(handles.Ws0,'Visible','on');
        set(handles.text7,'Visible','on');
        set(handles.text8,'Visible','on');
    end
function LPF_Callback(hObject, eventdata, handles)
        handles.WsValue = str2num(get(handles.Ws,'String'))/(handles.fs/2);
        handles.WpValue = str2num(get(handles.Wp,'String'))/(handles.fs/2);
        set(handles.Wp0,'Visible','off');
        set(handles.Ws0,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.text8,'Visible','off');
    end
function HPF_Callback(hObject, eventdata, handles)
        handles.WsValue = str2num(get(handles.Ws,'String'))/(handles.fs/2);
        handles.WpValue = str2num(get(handles.Wp,'String'))/(handles.fs/2);
        set(handles.Wp0,'Visible','off');
        set(handles.Ws0,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.text8,'Visible','off');
end