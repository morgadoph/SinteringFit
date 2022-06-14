% Decodificado.m
% SONIDO 1.0 ®
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Decodifica el archivo .WAV deseado por el usuario

function Decodificado

    %---------------------------- PANTALLA DE ARCHIVO CODIFICADO --------------------------
    PArchDeco = figure('Color',[1 1 1], ...
        'MenuBar','none', ...
        'Name','Grafica del Archivo .WAV Decodificado', ...
        'NumberTitle','off', ...
        'PaperUnits','points', ...
        'Position',[695 375 450 290], ...
        'Tag','FArchCodi', ...
        'ToolBar','none');

    %-------------------------------------------------------------------------------------
    nameDeco=findobj('Tag','EArchDeco');
    nameDeco=get(nameDeco,'String');
    
    archCod=findobj('Tag','EarchToDeco');
    archCod=get(archCod,'String');
       
    %Recopilando Informacion del archivo de audio que esta Codificado
    [dato,fs,b]=wavread(archCod);
    p=size(dato,1);
    t=(1:p)/fs;
    
    %Etapa de DECODIFICACION
    salidaDECO=2.105*dato./(sin(550*pi.*t').*cos(2020*pi.*t'));

    %Grafica en el tiempo: Archivo de salida DECODIFICADO
    PArchDeco;
    plot(t,salidaDECO);
    grid;
    xlabel('Tiempo');
    ylabel('Amplitud');
    %title('Audio Decodificado Salida'); 

    %Escribiendo el Archivo de salida DECODIFICADO
    wavwrite(salidaDECO,fs,32,nameDeco);
    %wavplay(salidaDECO,fs); 
end