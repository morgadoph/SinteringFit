% Codificar.m
% SONIDO 1.0 �
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Men� de Codificado 

function Codificar

    [incode] = uigetfile({'*.wav','Archivos de audio (*.wav)';}, ...
            'Escoja el archivo');
    if isequal(incode,0)
        PFiltrar = figure('Color',[1 1 1], ...
             'MenuBar','none', ...
             'Name','FILTRAR', ...       
             'Position',[695 150 450 200], ...
             'Tag','Fprinc', ...
             'ToolBar','none');
             close (gcf);
    else

        %---------------------------- PANTALLA DE CODIFICADO ----------------------------------
        %------------------------------ Ventana Codificado ------------------------------------
        PCodificar = figure('Color',[1 1 1], ...
            'MenuBar','none', ...
            'Name','Codificar .WAV', ...
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
        uicontrol('parent',PCodificar, ...
            'Units','points', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'Callback','Codificado', ...
            'ListboxTop',0, ...
            'Position',[175 15 70 20], ...
            'String','Aceptar', ...
            'Tag','Baceptar');

        %---------------------------- Boton Cerrar ----------------------------------    
        uicontrol('parent',PCodificar, ...
            'Units','points', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'Callback','close', ...
            'ListboxTop',0, ...
            'Position',[255 15 70 20], ...
            'String','Cerrar', ...
            'Tag','Bcerrar');  

        %-------------------------------------------------------------------------------------
        %Frame Archivo a Codificar ----------------------------------------------------------- 
        uicontrol('parent',PCodificar,...
            'Style','frame',...
            'Units','points',...
            'BackgroundColor',[0 0 0],...
            'Position',[175 120 150 10],...
            'Tag','FarchToCodi');    

        %Texto Archivo a Codificar ------------------------------------------------------------ 
        uicontrol('Parent',PCodificar,...
            'Style','text', ...
            'Units','points', ...
            'HorizontalAlignment','left', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'ListboxTop',0, ...
            'Position',[177 121 150 12], ...
            'String','   Archivo a Codificar:', ...
            'Visible','on',...
            'Tag','TarchToCodi');

        %Espacio Archivo a Codificar -----------------------------------------------------------
        uicontrol('parent',PCodificar, ...
           'Style','edit', ...
           'Units','points', ...
           'HorizontalAlignment','center', ...
           'BackgroundColor',[0.850980392156863 0.925490196078431 1 ], ...
           'ListboxTop',0, ...
           'Position',[265 123 55 10], ...
           'Tag','EarchToCodi',...
           'String',incode);        


        %------------------------------------------------------------------------------------
        %frame Nombre del archivo codificado ------------------------------------------------
        uicontrol('parent',PCodificar,...
            'Style','frame',...
            'Units','points',...
            'BackgroundColor',[0 0 0],...
            'Position',[175 105 150 10],...
            'Tag','FNameArchCodi');

        %Texto Nombre del archivo codificado -------------------------------------------------
        uicontrol('Parent',PCodificar,...
            'Style','text', ...
            'Units','points', ...
            'HorizontalAlignment','left', ...
            'BackgroundColor',[0.5 0.6 0.8], ...
            'ListboxTop',0, ...
            'Position',[177 106 150 12], ...
            'String','   Guardar Codificado como:', ...
            'Visible','on',...
            'Tag','TNameArchCodi');

        %Espacio Nombre del archivo codificado ----------------------------------------------- 
        uicontrol('parent',PCodificar, ...
            'Style','edit', ...
            'Units','points', ...
            'HorizontalAlignment','center', ...
            'BackgroundColor',[0.850980392156863 0.925490196078431 1 ], ...
            'ListboxTop',0, ...
            'Position',[283 108 40 10], ...
            'Tag','ENameArchCodi',...
            'String','CODE');  
    end
end