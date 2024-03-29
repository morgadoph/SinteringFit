% Decodificar.m
% SONIDO 1.0 �
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Men� de Decodificado 

function Decodificar

    [indeco] = uigetfile({'*.wav','Archivos de audio (*.wav)';}, ...
            'Escoja el archivo');
    if isequal(indeco,0)
        PFiltrar = figure('Color',[1 1 1], ...
             'MenuBar','none', ...
             'Name','FILTRAR', ...       
             'Position',[695 150 450 200], ...
             'Tag','Fprinc', ...
             'ToolBar','none');
             close (gcf);
    else

        %---------------------------- PANTALLA DE DECODIFICADO ----------------------------------
        %------------------------------ Ventana Decodificado ------------------------------------
        PDecodificar = figure('Color',[1 1 1], ...
            'MenuBar','none', ...
            'Name','Decodificar .WAV', ...
            'NumberTitle','off', ...
            'PaperUnits','points', ...
            'Position',[695 150 450 210], ...
            'Tag','Fprinc', ...
            'ToolBar','none');

            %ejeppal=
        axes('Position',[0 0 1 1]);
        imagen=imread('Sonido2.jpg');
        image(imagen);
        axis off;

        %---------------------------- Boton Aceptar ---------------------------------
        uicontrol('parent',PDecodificar, ...
            'Units','points', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'Callback','Decodificado', ...
            'ListboxTop',0, ...
            'Position',[175 15 70 20], ...
            'String','Aceptar', ...
            'Tag','Baceptar');

        %---------------------------- Boton Cerrar ----------------------------------    
        uicontrol('parent',PDecodificar, ...
            'Units','points', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'Callback','close', ...
            'ListboxTop',0, ...
            'Position',[255 15 70 20], ...
            'String','Cerrar', ...
            'Tag','Bcerrar');  

        %-------------------------------------------------------------------------------------
        %Frame Archivo a Decodificar ----------------------------------------------------------- 
        uicontrol('parent',PDecodificar,...
            'Style','frame',...
            'Units','points',...
            'BackgroundColor',[0 0 0],...
            'Position',[175 120 153 10],...
            'Tag','FarchToDeco');    

        %Texto Archivo a Decodificar ------------------------------------------------------------ 
        uicontrol('Parent',PDecodificar,...
            'Style','text', ...
            'Units','points', ...
            'HorizontalAlignment','left', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'ListboxTop',0, ...
            'Position',[177 121 153 12], ...
            'String','   Archivo a Decodificar:', ...
            'Visible','on',...
            'Tag','TarchToDeco');

        %Espacio Archivo a Decodificar -----------------------------------------------------------
        uicontrol('parent',PDecodificar, ...
           'Style','edit', ...
           'Units','points', ...
           'HorizontalAlignment','center', ...
           'BackgroundColor',[0.850980392156863 0.925490196078431 1 ], ...
           'ListboxTop',0, ...
           'Position',[267 123 60 10], ...
           'Tag','EarchToDeco',...
           'String',indeco);  


        %------------------------------------------------------------------------------------
        %frame Nombre del archivo Decodificado ------------------------------------------------
        uicontrol('parent',PDecodificar,...
            'Style','frame',...
            'Units','points',...
            'BackgroundColor',[0 0 0],...
            'Position',[175 105 153 10],...
            'Tag','FArchDeco');

        %Texto Nombre del archivo Decodificado -------------------------------------------------
        uicontrol('Parent',PDecodificar,...
            'Style','text', ...
            'Units','points', ...
            'HorizontalAlignment','left', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'ListboxTop',0, ...
            'Position',[177 106 153 12], ...
            'String','   Guardar Decodificado como:', ...
            'Visible','on',...
            'Tag','TArchDeco');

        %Espacio Nombre del archivo Decodificado ----------------------------------------------- 
        uicontrol('parent',PDecodificar, ...
            'Style','edit', ...
            'Units','points', ...
            'HorizontalAlignment','center', ...
            'BackgroundColor',[0.850980392156863 0.925490196078431 1 ], ...
            'ListboxTop',0, ...
            'Position',[287 108 40 10], ...
            'Tag','EArchDeco',...
            'String','DECO');  
    end
end