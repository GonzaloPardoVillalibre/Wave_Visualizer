%% Funciones de opening del fichero
function varargout = Proyectov2(varargin)
% PROYECTOV2 MATLAB code for Proyectov2.fig
%      PROYECTOV2, by itself, creates a new PROYECTOV2 or raises the existing
%      singleton*.
%   
%      H = PROYECTOV2 returns the handle to a new PROYECTOV2 or the handle to
%      the existing singleton*.
%
%      PROYECTOV2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYECTOV2.M with the given input arguments.
%
%      PROYECTOV2('Property','Value',...) creates a new PROYECTOV2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Proyectov2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Proyectov2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Proyectov2

% Last Modified by GUIDE v2.5 31-Dec-2018 09:58:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Proyectov2_OpeningFcn, ...
                   'gui_OutputFcn',  @Proyectov2_OutputFcn, ...
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
function Proyectov2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Proyectov2 (see VARARGIN)

% Update handles structure

% Choose default command line output for Proyectov2
handles.output = hObject;
handles.thereis=zeros(7,2);
guidata(hObject, handles);
handles.posicion=0;
handles.escala='V';
handles.numHerramientas=0;
handles.audio=0;
handles.fs=0;
handles.save=0;
handles.savefs=0;
guidata(hObject, handles);

end
function varargout = Proyectov2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

%% Funciones manejan los menus
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function Sec_Callback(hObject, eventdata, handles)
% hObject    handle to Sec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function Help_Callback(hObject, eventdata, handles)
url = 'https://www.youtube.com/user/gonzalo198o';
web(url);
end
function herramientas_Callback(hObject, eventdata, handles)
     
     
end

%% Funciones que se ejecutan cuando se abre un archivo
function abrir_Callback(hObject, eventdata, handles)

    %Abrir el archivo de audio
    [file,path1] = uigetfile('*.wav','*.mp3');
    
    if(file~=0)
    handles.nombre=file;
    s = strcat(path1,file);
    [handles.audio,handles.fs] = audioread(s);
    handles.REP = audioplayer(handles.audio,handles.fs);
    handles.fsREP= handles.fs;
    
%    handles.audio= double(handles.audio);
    %Guardo la informacion en la memora de gui
    guidata(hObject, handles);
    
     %Muestreo en tiempo de la pista de sonido
     MuestreoTiempo(handles);
    
     %Muestreo en frecuencia
    MuestreoFrec(handles);
    
    if (handles.thereis(5,2)==1)
          interp_Callback(handles.RepParam,eventdata,handles);
    end
     if (handles.thereis(4,2)==1)
             Datos_Callback(handles.Datos,eventdata,handles);
     end
    
   end
    
end  
function MuestreoTiempo(handles)
    audio=handles.audio;
    audio = sum(audio, 2) / size(audio, 2); %Esta linea sirve para convertir las señales stereo a mono.
    fs=handles.fs;
    dt = 1/fs;
    t = 0:dt:(length(audio)*dt)-dt;
    hold on
    axes(handles.axes1)
    cla(handles.axes1);
    plot(handles.axes1,t,audio); xlabel('Seconds'); ylabel('Amplitude');
    axis tight;
    hold off
end  
function MuestreoFrec(handles)
    
   if(length(handles.audio)~=1)
    audio=handles.audio;
    audio = sum(audio, 2) / size(audio, 2);
   
    y = get(handles.Espec,'value');
    if y==1 %Espectrograma
        axes(handles.axes2)
        cla(handles.axes2);
        [S,F,T] = spectrogram(audio,800,[],[],handles.fs);
        surf(T,F,abs(S),'EdgeColor','none')
        view([0 90]) %mostramos en 2D
        xlabel('time [s]');
        ylabel('frequency (log) [Hz]');
        axis tight;
    elseif y==2    %FFT
        axes(handles.axes2)
        cla(handles.axes2);
        [TF,f]=transformada(audio,handles.fsREP,handles);
        plot(f,abs(TF));
        xlabel('frequency [Hz]');
        ylabel(['amplitude [',handles.escala,']']);
        axis tight;
    elseif y==3    %Densidad espectral de potencia
        DEP(audio,handles.fs,handles);
        axis tight;
    end
  end
end

%% Funciones correspondientes a abrir-> nuevo

function nuevo_Callback(hObject, eventdata, handles)
% hObject    handle to nuevo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
function grabar_Callback(hObject, eventdata, handles)
    Record
end
function onda_determinista_Callback(hObject, eventdata, handles)
    OndaDeterminista
end

%% Funciones auxiliares para hacer la transformada 

function Espec_Callback(hObject, eventdata, handles)
    MuestreoFrec(handles)
    
    if(get(hObject,'Value')==2 || get(hObject,'Value')==3)
        set(handles.FFTdB, 'visible', 'on');
    else
        set(handles.FFTdB, 'visible', 'off');
    end

end
function Espec_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
function [tf,f] = transformada(x,fs,handles)
    
    
    N=length(x);
    tf=fft(x,N)/N;
    tf = abs(tf(1:floor(N/2+1)));
    f=linspace(0,fs/2,(N/2+1)); 
    
    if(strcmp(handles.escala,'dB'))
        tf=10*log(tf);
    end
        
end
function DEP(x,fs,handles)

    N=length(x);
    tf=fft(x)/N;
    size(tf);
    tf=abs(tf(1:floor(N/2+1)));
    f=linspace(0,fs/2,N/2+1);
    tf=tf.*conj(tf);
    
    axes(handles.axes2)
    cla(handles.axes2);
    
    if(strcmp(handles.escala,'dB'))
        tf=10*log(tf);
    end
    
    plot(f,abs(tf));
    
    


end
function FFTdB_Callback(hObject, eventdata, handles)
    if (get(hObject,'Value')==1)
         handles.escala='dB';
         guidata(hObject,handles);     
    else
         handles.escala='V';
         guidata(hObject,handles);  
    end
    MuestreoFrec(handles);
end

%% Funciones correspondientes al manejo de menus de herramientas
function [herramientaelimino,numHerramientas,posicion,s]=actualizarposicion(hObject,handles,herr)   
  
  currentHer=handles.numHerramientas;
  %Parte que me resuelve la posicion si la necesito
    if (handles.thereis(herr,1)==0)
        if(handles.numHerramientas<=2)
            numHerramientas=handles.numHerramientas+1;
            s=numHerramientas;  
        elseif(handles.numHerramientas==3)
            
             answer = questdlg('¿Qué herramienta desea eliminar? ','Cambia herramienta','1','2','3','3');
            
               s=str2num(answer);
        
              numHerramientas=3;
        end
    else
        s=handles.thereis(herr,1);
    end
    
    switch s
         case 1
           posicion= [0.663 0.703 0.308 0.278];
         case 2
           posicion= [0.663 0.384 0.308 0.278];
         case 3
           posicion = [0.663 0.066 0.308 0.278];
          otherwise
           posicion = [0 0 0 0];  
    end 
     
    herramientaelimino=find(handles.thereis(:,1)==s & handles.thereis(:,2)==1);
    
    if(~isempty(herramientaelimino))
        numHerramientas=currentHer;
        switch  herramientaelimino
              case 1
                 set(handles.RepParamTable,'visible','off'); 
              case 2
                set(handles.sumadorTable,'visible','off');
              case 3
                set(handles.concatenarTable,'visible','off');  
              case 4
                set(handles.potenciaTable,'visible','off');
              case 5
                set(handles.interpolTable,'visible','off');
              case 6
                set(handles.modulacionTable,'visible','off');
              case 7
                set(handles.demodulacionTable,'visible','off');
        end  
    else
        herramientaelimino=0;
    end  
   
end
function RepParam_Callback(hObject, eventdata, handles)
    if (length(handles.audio)~=1)
          set(handles.PVResume,'visible','off');
          set(handles.PVPause,'visible','on');
          set(handles.PVPlay,'CData',imread('icon-play.png','backgroundcolor',[1 1 1]))
        [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,1);
        set(handles.RepParamTable,'position',handles.posicion);
        if(el>0)
        handles.thereis(el,1)=0; 
        handles.thereis(el,2)=0;
        end
        handles.thereis(1,1)=s;
        handles.thereis(1,2)=1;
        handles.audio1=handles.audio; %guardamos en memoria la señal de audio
        guidata(hObject, handles);
        set(handles.RepParamTable,'visible','on'); 
         
   end  
end
function sumador_Callback(hObject, eventdata, handles)
    hacer=0;
    for s=1:3
        if (handles.thereis(s,1)==1)
            hacer=1;
        end
    end
    handles.s1=0;
    handles.fs1=0;
    handles.s2=0;
    handles.fs2=0;
    handles.s3=0;
    handles.fs3=0;
    handles.s4=0;
    handles.fs4=0;
    handles.s5=0;
    handles.fs5=0;
    handles.s6=0;
    [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,2);
    set(handles.sumadorTable,'position',handles.posicion);
    if(el>0)
        handles.thereis(el,1)=0; 
        handles.thereis(el,2)=0;
    end
    handles.thereis(2,1)=s;
    handles.thereis(2,2)=1;
    guidata(hObject, handles);
    set(handles.sumadorTable,'visible','on');
end
function concatenador_Callback(hObject, eventdata, handles)
    handles.sc1=0;
    handles.fsc1=0;
    handles.sc2=0;
    handles.fsc2=0;
    handles.sc3=0;
    handles.fsc3=0;
    handles.sc4=0;
    handles.fsc4=0;
    handles.sc5=0;
    handles.fsc5=0;
    handles.sc6=0;
    handles.fsc6=0;
    [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,3);
    set(handles.concatenarTable,'position',handles.posicion);
    if(el>0)
        handles.thereis(el,1)=0; 
        handles.thereis(el,2)=0;
    end
    handles.thereis(3,1)=s;
    handles.thereis(3,2)=1;
    guidata(hObject, handles);
    set(handles.concatenarTable,'visible','on');
end
function Datos_Callback(hObject, eventdata, handles)
     if(length(handles.audio)~=1)
       [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,4);
        if(el>0)
            handles.thereis(el,1)=0; 
            handles.thereis(el,2)=0;
        end
        handles.thereis(4,1)=s;
        handles.thereis(4,2)=1;
        set(handles.potenciaTable,'position',handles.posicion);
        handles.audio1=handles.audio; %vector con el que vamos a trabajar
        audio=handles.audio;
        audio = sum(audio, 2) / size(audio, 2);
        handles.energia = sum(abs(audio).^2)/(length(audio));
        handles.Pot=handles.energia/(length(audio)/handles.fsREP);
        handles.Pav=handles.Pot/length(audio);
  
        set(handles.d1,'String',strcat('Nombre: ',handles.nombre)); 
        set(handles.d2,'String', strcat('Total Samples:     ',num2str(handles.REP.TotalSamples))); 
        set(handles.d3,'String',strcat('Sample Rate:        ',num2str(handles.REP.SampleRate))); 
        set(handles.d4,'String',strcat('Timer Period:       ',num2str(handles.REP.TimerPeriod))); 
        set(handles.d5,'String',strcat('Energía:',num2str(handles.energia),' Julios')); 
        set(handles.d6,'String',strcat('Potencia Media:     ',num2str(handles.Pav),'Watios')); 
        set(handles.potenciaTable,'visible','on');
        
        guidata(hObject, handles);
        
     end
        
end
function interp_Callback(hObject, eventdata, handles)
   if(length(handles.audio)~=1)
    [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,5);
    set(handles.interpolTable,'position',handles.posicion);
    set(handles.currentfs,'String',strcat('Tasa de muestreo actual: ',num2str(handles.fsREP)));
    
    if(el>0)
        handles.thereis(el,1)=0; 
        handles.thereis(el,2)=0;
    end
    handles.thereis(5,1)=s;
    handles.thereis(5,2)=1;
    guidata(hObject, handles);
    set(handles.interpolTable,'visible','on'); 
  end
end
function modular_Callback(hObject, eventdata, handles)
    handles.moduladora=0;
    handles.fsmod=0;
    handles.modulada=0;
    set(handles.am,'BackgroundColor',[0.94 0.94 0.94]); 
    set(handles.fm,'BackgroundColor',[0.94 0.94 0.94]); 
    
    [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,6);
    set(handles.modulacionTable,'position',handles.posicion);
    if(el>0)
        handles.thereis(el,1)=0; 
        handles.thereis(el,2)=0;
    end
    handles.thereis(6,1)=s;
    handles.thereis(6,2)=1;
    guidata(hObject, handles);
    set(handles.modulacionTable,'visible','on');
end
function demodular_Callback(hObject, eventdata, handles)
    handles.demoduladora=0;
    handles.fsdemod=0;
    handles.demodulada=0;
    set(handles.demodam,'BackgroundColor',[0.94 0.94 0.94]); 
    set(handles.demodfm,'BackgroundColor',[0.94 0.94 0.94]); 
    
    [el,handles.numHerramientas,handles.posicion,s]=actualizarposicion(hObject,handles,7);
    set(handles.demodulacionTable,'position',handles.posicion);
    if(el>0)
        handles.thereis(el,1)=0; 
        handles.thereis(el,2)=0;
    end
    handles.thereis(7,1)=s;
    handles.thereis(7,2)=1;
    guidata(hObject, handles);
    set(handles.demodulacionTable,'visible','on');
end
function FiltradoSenales_Callback(hObject, eventdata, handles)
 filtradoSenales
end

%% Funciones que se encargan de sumar señales
function sumadors1_Callback(hObject, eventdata, handles)
       
        [file,handles.s1,handles.fs1]=cargarsenal(hObject, handles);
        set(handles.sumadors1,'String',file);
        guidata(hObject, handles);

end
function sumadors2_Callback(hObject, eventdata, handles)

        [file,handles.s2,handles.fs2]=cargarsenal(hObject, handles);
        set(handles.sumadors2,'String',file);
        guidata(hObject, handles);

end
function sumadors3_Callback(hObject, eventdata, handles)

        [file,handles.s3,handles.fs3]=cargarsenal(hObject, handles);
        set(handles.sumadors3,'String',file);
        guidata(hObject, handles);

end
function sumadors4_Callback(hObject, eventdata, handles)

        [file,handles.s4,handles.fs4]=cargarsenal(hObject, handles);
        set(handles.sumadors4,'String',file);
        guidata(hObject, handles);

end
function sumadors5_Callback(hObject, eventdata, handles)
        [file,handles.s5,handles.fs5]=cargarsenal(hObject, handles);
        set(handles.sumadors5,'String',file);
        guidata(hObject, handles);
end
function sumadors6_Callback(hObject, eventdata, handles)

        [file,handles.s6,handles.fs6]=cargarsenal(hObject, handles);
        set(handles.sumadors6,'String',file);
        guidata(hObject, handles);   
end
%Suma las 6 muestras
function sumar_Callback(hObject, eventdata, handles)
    
    if(length(handles.audio)~=1)
        answer = questdlg('Esta operacion eliminará los cambios realizados sobre la pista acutal ¿Desea guardarla antes de continuar? ','Guarda pista','Si','No','Cancelar','Cancelar');
       if(strcmp(answer,'Si'))
        [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
        audiowrite(s,handles.audio,handles.fsREP); 
       end
       if(strcmp(answer,'Cancelar'))
        return; 
       end
    end
    suma=0;
    %Vamos a trabajar a una frecuencia siempre de 44100 hz
    if (length(handles.s1)~=1)
        suma=sumar(suma,handles.s1,handles.fs1);
    end
    if (length(handles.s2)~=1)
        suma=sumar(suma,handles.s2, handles.fs2);
    end
    if (length(handles.s3)~=1)
    suma=sumar(suma,handles.s3,handles.fs3);
    end
    if (length(handles.s4)~=1)
        suma=sumar(suma,handles.s4,handles.fs4);
    end
    if (length(handles.s5)~=1)
        suma=sumar(suma,handles.s5,handles.fs5);
    end
    if (length(handles.s6)~=1)
        suma=sumar(suma,handles.s6,handles.fs6);
    end
    
    if(length(suma)~=0)
        handles.audio= suma;
        handles.fs=44100;

        guidata(hObject, handles);

        MuestreoTiempo(handles);

        MuestreoFrec(handles);

        handles.REP = audioplayer(handles.audio,handles.fs);
        handles.fsREP= handles.fs;

        guidata(hObject, handles);

         if (handles.thereis(1,2)==1)
              RepParam_Callback(handles.RepParam,eventdata,handles);
         end
         if (handles.thereis(4,2)==1)
             Datos_Callback(handles.Datos,eventdata,handles);
         end
    end
    
    set(handles.sumadors1, 'String','Señal 1');
    set(handles.sumadors2,'String','Señal 2');
    set(handles.sumadors3,'String','Señal 3');
    set(handles.sumadors4,'String','Señal 4');
    set(handles.sumadors5,'String','Señal 5');
    set(handles.sumadors6,'String','Señal 6');
   
end
%Se encarga de convertir las señales a la misma frecuencia para poder
%sumarlas bien
function [suma]=sumar(suma,senal,fs)
 
      [P,Q] = rat(44100/fs);
      abs(P/Q*fs-44100);
      xnew = resample(senal,P,Q);

      handles.REP = audioplayer(xnew,44100);
      handles.fsREP= 44100;
      
      [f1, c1] = size(suma);
      [f2, c2] = size(senal);
    
    if (f1>f2)
        x=zeros((f1-f2),1);
        senal = [senal;x];
    else
        x=zeros((f2-f1),1);
        suma = [suma;x];
    end
    
    suma= senal+suma;
end
% Se encarga de cargar las señales que vamos a sumar
function [file,audio,fs]=cargarsenal(hObject,handles)

     %Abrir el archivo de audio
    [file,path1] = uigetfile('*.wav','*.mp3');
    
    if(file~=0)
        s = strcat(path1,file);
        [audio,fs] = audioread(s);
        audio= double(audio);
        audio = sum(audio, 2) / size(audio, 2);
    else
        file='Error';
        audio=0;
        fs=0;
    end
    

end

%% Funciones de Parámetros de visualización
% % --- Executes on button press in PVPlay.
function PVPlay_Callback(hObject, eventdata,handles)
  
   play(handles.REP);
 
end
function PVResume_Callback(hObject, eventdata, handles)
     
    resume(handles.REP);
    set(handles.PVResume,'visible','off');
    set(handles.PVPause,'visible','on');
    
end
function PVPause_Callback(hObject, eventdata, handles)
    
    pause(handles.REP);
    set(handles.PVResume,'visible','on');
    set(handles.PVResume,'CData',imread('icon-play.png','backgroundcolor',[1 1 1]));
    set(handles.PVPlay,'CData',imread('icon-reload.png','backgroundcolor',[1 1 1]))
    set(handles.PVPause,'visible','off');
end
function PV2_Callback(hObject, eventdata, handles)
   
   handles.audio=flipud(handles.audio);
   handles.REP = audioplayer(handles.audio,handles.fsREP);
   guidata(hObject, handles);
   
   MuestreoTiempo(handles);
   RepParam_Callback(handles.RepParam,eventdata,handles);
end
function PV1_Callback(hObject, eventdata, handles)
   try 
    A=get(handles.PV3,'String');
    
        if(A~='A')
            A=str2num(A);
            handles.fsREP=A*handles.fsREP;
            set(handles.REP,'SampleRate', handles.fsREP);
            guidata(hObject, handles);
            RepParam_Callback(handles.RepParam,eventdata,handles);

            if (handles.thereis(4,2)==1)
                  Datos_Callback(handles.Datos,eventdata,handles);
            end
            if (handles.thereis(5,2)==1)
                  interp_Callback(handles.interp,eventdata,handles);
            end

            set(handles.PV3,'BackgroundColor',[0.94 0.94 0.94]);

        else
           f = msgbox('Debe introducir un número entero'); 
           set(handles.PV3,'BackgroundColor',[0.94 0.94 0.94]);
        end
    catch
       f = msgbox('Debe introducir un número entero'); 
       set(handles.PV3,'BackgroundColor',[0.94 0.94 0.94]);
       set(handles.PV3,'String','A');
    end
    
end
function PV3_Callback(hObject, eventdata, handles)
        set(handles.PV3,'BackgroundColor',[0 1 0]);
end
function PV3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PV3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%% Funcion que guarda la señal con la que hemos trabjado
function save_Callback(hObject, eventdata, handles)

 if(length(handles.audio)~=1)
    handles.audio=handles.audio/max(abs(handles.audio)+0.1);
    [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
   if(s~=0)
    audiowrite(s,handles.audio,handles.fsREP); 
   end
 end
end

%% Funcion que te deja crear una onda personaliza
function customwave_Callback(hObject, eventdata, handles)
    OndaPersonalizada;
end

%% Funciones que sirven para la herramienta de datos
function informe_Callback(hObject, eventdata, handles)

    fileID = fopen(strcat('.\Informes\Informe-',handles.nombre,'.txt'),'w');
    fprintf(fileID,'%s \n',get(handles.d1,'String'));
    fprintf(fileID,'%s \n',get(handles.d2,'String'));
    fprintf(fileID,'%s \n',get(handles.d3,'String'));
    fprintf(fileID,'%s \n',get(handles.d4,'String'));
    fprintf(fileID,'%s \n',get(handles.d5,'String'));
    fprintf(fileID,'%s \n',get(handles.d6,'String'));
    fclose(fileID);

end

%% Funciones que sirven para concatenar señales
function [concat]=concatenacion(concat,senal,fs)
 
      [P,Q] = rat(44100/fs);
      abs(P/Q*fs-44100);
      xnew = resample(senal,P,Q);
      concat =[concat;xnew];
      handles.REP = audioplayer(xnew,44100);
      handles.fsREP= 44100;
end
function concatenar_Callback(hObject, eventdata, handles)
   
   if(length(handles.audio)~=1)
        answer = questdlg('Esta operacion eliminará los cambios realizados sobre la pista acutal ¿Desea guardarla antes de continuar? ','Guarda pista','Si','No','Cancelar','Cancelar');
       if(strcmp(answer,'Si'))
        [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
        audiowrite(s,handles.audio,handles.fsREP); 
       end
       if(strcmp(answer,'Cancelar'))
        return; 
       end
    end
    concat=0;
    %Vamos a trabajar a una frecuencia siempre de 44100 hz
    if (length(handles.sc1)~=1)
        concat=concatenacion(concat,handles.sc1,handles.fsc1);
    end
    if (length(handles.sc2)~=1)
        concat=concatenacion(concat,handles.sc2, handles.fsc2);
    end
    if (length(handles.sc3)~=1)
    concat=concatenacion(concat,handles.sc3,handles.fsc3);
    end
    if (length(handles.sc4)~=1)
        concat=concatenacion(concat,handles.sc4,handles.fsc4);
    end
    if (length(handles.sc5)~=1)
        concat=concatenacion(concat,handles.sc5,handles.fsc5);
    end
    if (length(handles.sc6)~=1)
        concat=concatenacion(concat,handles.sc6,handles.fsc6);
    end
    
    handles.audio= concat;
    handles.fs=44100;
    
    guidata(hObject, handles);
    
    MuestreoTiempo(handles);
    
    MuestreoFrec(handles);
    
    handles.REP = audioplayer(handles.audio,handles.fs);
    handles.fsREP= handles.fs;
    
    guidata(hObject, handles);
    
     if (handles.thereis(1,2)==1)
         RepParam_Callback(handles.RepParam,eventdata,handles);
     end
     if (handles.thereis(4,2)==1)
         Datos_Callback(handles.Datos,eventdata,handles);
     end
     
    set(handles.concats1, 'String','Señal 1');
    set(handles.concats2,'String','Señal 2');
    set(handles.concats3,'String','Señal 3');
    set(handles.concats4,'String','Señal 4');
    set(handles.concats5,'String','Señal 5');
    set(handles.concats6,'String','Señal 6');
  
end
function concats1_Callback(hObject, eventdata, handles)
    [file,handles.sc1,handles.fsc1]=cargarsenal(hObject, handles);
    set(handles.concats1,'String',file);
    guidata(hObject, handles);
end
function concats2_Callback(hObject, eventdata, handles)
    [file,handles.sc2,handles.fsc2]=cargarsenal(hObject, handles);
    set(handles.concats2,'String',file);
    guidata(hObject, handles);
end
function concats3_Callback(hObject, eventdata, handles)
    [file,handles.sc3,handles.fsc3]=cargarsenal(hObject, handles);
    set(handles.concats3,'String',file);
    guidata(hObject, handles);
end
function concats4_Callback(hObject, eventdata, handles)
   [file,handles.sc4,handles.fsc4]=cargarsenal(hObject, handles);
    set(handles.concats4,'String',file);
    guidata(hObject, handles);      
end
function concats5_Callback(hObject, eventdata, handles)
    [file,handles.sc5,handles.fsc5]=cargarsenal(hObject, handles);
    set(handles.concats5,'String',file);
    guidata(hObject, handles);
end
function concats6_Callback(hObject, eventdata, handles)
    [file,handles.sc6,handles.fsc6]=cargarsenal(hObject, handles);
    set(handles.concats6,'String',file);
    guidata(hObject, handles);
end

%% Funciones que crean los ejes

function axes1_CreateFcn(hObject, eventdata, handles)

end
function axes2_CreateFcn(hObject, eventdata, handles)

end


%% Funciones que se encargan de la herramienta de interpolar y diezmar
function upfactor_Callback(hObject, eventdata, handles)

end
function downfactor_Callback(hObject, eventdata, handles)

end
function compresfactor_Callback(hObject, eventdata, handles)

end
function compresfactor_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function dointerpol_Callback(hObject, eventdata, handles)
    try
    factor=str2num(get(handles.upfactor,'String'));
    handles.audio=upsample(handles.audio,factor);
    handles.fsREP= factor*handles.fsREP;
    guidata(hObject, handles);
   
    handles.REP = audioplayer(handles.audio,handles.fsREP);
    handles.fsREP;
    
     if (handles.thereis(1,2)==1)
             RepParam_Callback(handles.RepParam,eventdata,handles);
    
     end
     if (handles.thereis(4,2)==1)
             Datos_Callback(handles.Datos,eventdata,handles);
     end

     handles.fs=handles.fsREP;
     
     set(handles.currentfs,'String',strcat('Tasa de muestreo actual: ',num2str(handles.fs)));
     
     MuestreoTiempo(handles);
    
     MuestreoFrec(handles);
     
     guidata(hObject, handles);
    catch
         f = msgbox('No se ha podido llevar a cabo la interpolación');     
    end
end
function dodiezmado_Callback(hObject, eventdata, handles)
   
   try
    factor=str2num(get(handles.downfactor,'String'));
    handles.audio=downsample(handles.audio,factor);
    handles.fsREP= handles.fsREP/factor;
    guidata(hObject, handles);
   
    handles.REP = audioplayer(handles.audio,handles.fsREP);
    handles.fsREP;
    
     if (handles.thereis(1,2)==1)
             RepParam_Callback(handles.RepParam,eventdata,handles);
    
     end
     if (handles.thereis(4,2)==1)
             Datos_Callback(handles.Datos,eventdata,handles);
     end
     
     handles.fs=handles.fsREP;
     
     MuestreoTiempo(handles);
    
     MuestreoFrec(handles);
     
     set(handles.currentfs,'String',strcat('Tasa de muestreo actual: ',num2str(handles.fs)));
     
     guidata(hObject, handles);
   catch
      f = msgbox('No se ha podido llevar a cabo el diezmado');     
   end        
end

function docompresion_Callback(hObject, eventdata, handles)

        try
        factor=str2num(get(handles.compresfactor,'String'));
        handles.fsREP= factor*handles.fsREP;
        guidata(hObject, handles);

        handles.REP = audioplayer(handles.audio,handles.fsREP);
        handles.fsREP;

         if (handles.thereis(1,2)==1)
                 RepParam_Callback(handles.RepParam,eventdata,handles);

         end
         if (handles.thereis(4,2)==1)
                 Datos_Callback(handles.Datos,eventdata,handles);
         end

         handles.fs=handles.fsREP;

         set(handles.currentfs,'String',strcat('Tasa de muestreo actual: ',num2str(handles.fs)));

         MuestreoTiempo(handles);

         MuestreoFrec(handles);

         guidata(hObject, handles);
         set(handles.compresfactor,'String','Factor compresión/expansión');
        catch
             f = msgbox('No se ha podido llevar a cabo la compresión');     
        end
    
end

%% Funciones que se encargan del apartado de modulacion
function am_Callback(hObject, eventdata, handles)
    
    if(length(handles.moduladora)~=1)
        set(handles.am,'BackgroundColor',[0 1 0]);
        set(handles.fm,'BackgroundColor',[0.94 0.94 0.94]); 
        dt = 1/handles.fsmod;
        t = 0:dt:(length(handles.moduladora)*dt)-dt;

        Ac=0.85;
        ka = 1;
        fc= 3*handles.fsmod/10 ; %frecuencia de la portadora

        handles.modulada = Ac*ka*modulate(handles.moduladora,fc,handles.fsmod,'amdsb-tc', -1/ka);
        guidata(hObject, handles);
    end
end
function fm_Callback(hObject, eventdata, handles)

    
    if(length(handles.moduladora)~=1)
        set(handles.fm,'BackgroundColor',[0 1 0]);
        set(handles.am,'BackgroundColor',[0.94 0.94 0.94]); 
        dt = 1/handles.fsmod;
        t = 0:dt:(length(handles.moduladora)*dt)-dt;
         
        fc = 2*handles.fsmod/5;
        fm = 1000;
        Ac = 7;
        Am = 3;
        B = 2;
        k=(2*pi*B*fm)/(handles.fsmod*Am);
        N = length(t);
  
        handles.modulada= Ac*modulate(handles.moduladora, fc, handles.fsmod, 'fm', k);
        guidata(hObject, handles);
    end   

end
function addnoise_Callback(hObject, eventdata, handles)
 
        if (length(handles.modulada)~=1)
            N0 = 0.003;
            N = length (handles.modulada);
            w = sqrt(N0/2)*randn(1,N);
            w=w';
            handles.modulada= handles.modulada+ w; 
          set(handles.addnoise,'BackgroundColor',[0 1 0]);
          guidata(hObject, handles);
        end
            
end
function domodulation_Callback(hObject, eventdata, handles)
     
    if(length(handles.audio)~=1 && length(handles.modulada)~=1)
        answer = questdlg('Esta operacion eliminará los cambios realizados sobre la pista acutal ¿Desea guardarla antes de continuar? ','Guarda pista','Si','No','Cancelar','Cancelar');
       if(strcmp(answer,'Si'))
        [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
        audiowrite(s,handles.audio,handles.fsREP); 
       end
       if(strcmp(answer,'Cancelar'))
        return; 
       end
    end
    if(length(handles.modulada)~=1)
            handles.audio= handles.modulada;
            handles.fs=handles.fsmod;


            guidata(hObject, handles);

            MuestreoTiempo(handles);

            MuestreoFrec(handles);

            handles.REP = audioplayer(handles.audio,handles.fs);
            handles.fsREP= handles.fs;

            guidata(hObject, handles);

            if (handles.thereis(1,2)==1)
                 RepParam_Callback(handles.RepParam,eventdata,handles);

            end
           set(handles.fm,'BackgroundColor',[0.94 0.94 0.94]);
           set(handles.am,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.addnoise,'BackgroundColor',[0.94 0.94 0.94]);
           handles.moduladora=0;
           handles.fsmod=0;
           handles.modulada=0;
           set(handles.selecsenal,'String','Selecionar señal');
    end
    
    
    
    
end
function selecsenal_Callback(hObject, eventdata, handles)
   
   [file,path1] = uigetfile('*.wav','*.mp3');
    
   if(file~=0)
        s = strcat(path1,file);
        handles.nombre=file;
        [handles.moduladora,handles.fsmod] = audioread(s);
        handles.moduladora= double(handles.moduladora);
        handles.moduladora = sum(handles.moduladora, 2) / size(handles.moduladora, 2);
    else
        file='Error';
        handles.moduladora=0;
        handles.fsmod=0;
   end
   
    set(handles.selecsenal,'String',file);
    guidata(hObject, handles);
end

%% %% Funciones que se encargan del apartado de demodulacion
function demodam_Callback(hObject, eventdata, handles)
    if(length(handles.demoduladora)~=1)
        set(handles.demodam,'BackgroundColor',[0 1 0]);
        set(handles.demodfm,'BackgroundColor',[0.94 0.94 0.94]); 
        dt = 1/handles.fsdemod;
        t = 0:dt:(length(handles.demoduladora)*dt)-dt;

        Ac=0.85;
        ka = 1;
        fc= 3*handles.fsdemod/10 ; %frecuencia de la portadora

        handles.demodulada = (2/(ka*Ac))*demod(handles.demoduladora, fc, handles.fsdemod, 'amdsb-tc', Ac/2);
        guidata(hObject, handles);
    end
end
function demodfm_Callback(hObject, eventdata, handles)
     if(length(handles.demoduladora)~=1)
        set(handles.demodfm,'BackgroundColor',[0 1 0]);
        set(handles.demodam,'BackgroundColor',[0.94 0.94 0.94]); 
        dt = 1/handles.fsdemod;
        t = 0:dt:(length(handles.demoduladora)*dt)-dt;
         
        fc = 2*handles.fsdemod/5;
        fm = 1000;
        Ac = 7;
        Am = 3;
        B = 2;
        k=(2*pi*B*fm)/(handles.fsdemod*Am);
        N = length(t);
  
        handles.demodulada= demod(handles.demoduladora, fc, handles.fsdemod, 'fm', k);
        guidata(hObject, handles);
    end   

end
function dodemodular_Callback(hObject, eventdata, handles)

    if(length(handles.audio)~=1 && length(handles.demodulada)~=1)
        answer = questdlg('Esta operacion eliminará los cambios realizados sobre la pista acutal ¿Desea guardarla antes de continuar? ','Guarda pista','Si','No','Cancelar','Cancelar');
       if(strcmp(answer,'Si'))
        [s,path]=uiputfile('*.wav','Guardar señal determinista de audio');
        audiowrite(s,handles.audio,handles.fsREP); 
       end
       if(strcmp(answer,'Cancelar'))
        return; 
       end
     
    end
    
    if(length(handles.demodulada)~=1)
        
        handles.audio= handles.demodulada;
        handles.fs=handles.fsdemod;

        guidata(hObject, handles);

        MuestreoTiempo(handles);

        MuestreoFrec(handles);

        handles.REP = audioplayer(handles.audio,handles.fs);
        handles.fsREP= handles.fs;

        guidata(hObject, handles);

        if (handles.thereis(1,2)==1)
             RepParam_Callback(handles.RepParam,eventdata,handles);

        end
        
        set(handles.demodfm,'BackgroundColor',[0.94 0.94 0.94]);
        set(handles.demodam,'BackgroundColor',[0.94 0.94 0.94]);
        handles.demoduladora=0;
        handles.fsdemod=0;
        handles.demodulada=0;
        set(handles.selecsnaldemod,'String','Selecionar señal')
    end
    
    

end
function selecsnaldemod_Callback(hObject, eventdata, handles)

   [file,path1] = uigetfile('*.wav','*.mp3');
    
   if(file~=0)
        s = strcat(path1,file);
        handles.nombre=file;
        [handles.demoduladora,handles.fsdemod] = audioread(s);
        handles.demoduladora= double(handles.demoduladora);
        handles.demoduladora = sum(handles.demoduladora, 2) / size(handles.demoduladora, 2);
    else
        file='Error';
        handles.demoduladora=0;
        handles.fsdemod=0;
   end
   
    set(handles.selecsnaldemod,'String',file);
    guidata(hObject, handles);

end
