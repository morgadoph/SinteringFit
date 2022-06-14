% Codificado.m
% SONIDO 1.0 ®
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Codifica el archivo .WAV deseado por el usuario


function Codificado

    %---------------------------- PANTALLA DE ARCHIVO CODIFICADO --------------------------
    PArchCodi = figure('Color',[1 1 1], ...
        'MenuBar','none', ...
        'Name','Grafica del Archivo .WAV Codificado', ...
        'NumberTitle','off', ...
        'PaperUnits','points', ...
        'Position',[695 375 450 290], ...
        'Tag','FArchCodi', ...
        'ToolBar','none');

    %-------------------------------------------------------------------------------------
    archOrig=findobj('Tag','EarchToCodi');
    archOrig=get(archOrig,'String');
    
    nameCodi=findobj('Tag','ENameArchCodi');
    nameCodi=get(nameCodi,'String');

    %Recopilando Informacion del archivo de audio
    [dato,fs,b]=wavread(archOrig);
    p=size(dato,1);
    t=(1:p)/fs;

    %Parametros del filtro
    W1 = 300; %Frecuencia Baja
    W2 = 3600; %Frecuencia Alta     
    N = 4; %Orden del FIltro
    n=1:((N-1)/2);

    %Filtro FIR HAMMING
    w=0.54+0.4*cos(2*pi*n/(N-1));
    fc1=W1/fs;
    fc2=W2/fs;
    hd=(sin(2*pi*n*fc2)./(pi*n))-(sin(2*pi*n*fc1)./(pi*n));
    h=w.*hd;
    ht=fliplr(h);
    h0=2*(fc2-fc1);
    vect=cat(2,ht,h0,h);
    audiofiltrado=filter(vect,1,dato);

    %Etapa de CODIFICACION
    salidaCODI=(audiofiltrado).*(sin(550*pi.*t').*cos(2020*pi.*t'));%320
       
    %Grafica en el tiempo: Archivo de salida CODIFICADO
    PArchCodi;
    plot(t,salidaCODI);
    grid;
    xlabel('Tiempo(seg)');
    ylabel('Amplitud');
    %title('Audio Codificado'); 

    %Escribiendo el Archivo de salida CODIFICADO
    wavwrite(salidaCODI,fs,32,nameCodi);
end