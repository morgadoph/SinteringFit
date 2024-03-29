% tiempo.m
% SONIDO 1.0 �
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Men� seleccion tiempo y nombre de archivo a grabar


function tiempo
 

    %---------------------------- PANTALLA DE MENU DE TIEMPO ---------------------------       
    %--------------------------------- ventana TIEMPO -----------------------------------
    PFiltrar = figure('Color',[1 1 1], ...
        'MenuBar','none', ...
        'Name','Grabador.WAV', ...
        'NumberTitle','off', ...
        'PaperUnits','points', ...
        'Position',[695 150 450 200], ...
        'Tag','Fprinc', ...
        'ToolBar','none');

    %ejeppal=
    axes('Position',[0 0 1 1]);
    imagen=imread('Sonido2.jpg');
    image(imagen);
    axis off;

    %---------------------------- Boton Grabar ---------------------------------
    uicontrol('parent',PFiltrar, ...
        'Units','points', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'Callback','Grabadora', ...
        'ListboxTop',0, ...
        'Position',[175 15 70 20], ...
        'String','Grabar', ...
        'Tag','Baceptar');

    %---------------------------- Boton Cerrar ----------------------------------    
    uicontrol('parent',PFiltrar, ...
        'Units','points', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'Callback','close', ...
        'ListboxTop',0, ...
        'Position',[255 15 70 20], ...
        'String','Salir', ...
        'Tag','Bcerrar');  
    
    %-------------------------------------------------------------------------------------
    %Frame Archivo .Wav a filtrar -------------------------------------------------------- 
    uicontrol('parent',PFiltrar,...
        'Style','frame',...
        'Units','points',...
        'BackgroundColor',[0 0 0],...
        'Position',[175 116 150 10],...
        'Tag','Farch');    
      
    %Texto Archivo .Wav a filtrar --------------------------------------------------------- 
    uicontrol('Parent',PFiltrar,...
        'Style','text', ...
        'Units','points', ...
        'HorizontalAlignment','left', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'ListboxTop',0, ...
        'Position',[177 117 150 12], ...
        'String','  Escriba el nombre que desea para su', ...
        'Visible','on',...
        'Tag','Tarch');
     
    %------------------------------------------------------------------------------------
    %frame Frecuencia Baja de Corte -----------------------------------------------------
    uicontrol('parent',PFiltrar,...
        'Style','frame',...
        'Units','points',...
        'BackgroundColor',[0 0 0],...
        'Position',[175 105 150 10],...
        'Tag','FfrecLow');
      
    %Texto Frecuencia Baja de Corte -----------------------------------------------------
    uicontrol('Parent',PFiltrar,...
        'Style','text', ...
        'Units','points', ...
        'HorizontalAlignment','left', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'ListboxTop',0, ...
        'Position',[177 106 150 12], ...
        'String','  Archivo.WAV', ...
        'Visible','on',...
        'Tag','TfrecLow');
    
    %Espacio Frecuencia Baja de Corte ---------------------------------------------------- 
    uicontrol('parent',PFiltrar, ...
        'Style','edit', ...
        'Units','points', ...
        'HorizontalAlignment','center', ...
        'BackgroundColor',[0.850980392156863 0.925490196078431 1 ], ...
        'ListboxTop',0, ...
        'Position',[245 108 75 10], ...
        'Tag','nombregrab',...
        'String','Grabacion');  
   
   %--------------------------------------------------------------------------------------
    %frame Orden del Filtro ---------------------------------------------------------------
    uicontrol('parent',PFiltrar,...
        'Style','frame',...
        'Units','points',...
        'BackgroundColor',[0 0 0],...
        'Position',[175 75 150 10],...
        'Tag','Forden');

    %Texto Orden del Filtro ----------------------------------------------------------------
    uicontrol('Parent',PFiltrar,...
        'Style','text', ...
        'Units','points', ...
        'HorizontalAlignment','left', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'ListboxTop',0, ...
        'Position',[177 76 150 12], ...
        'String',' Tiempo de grabacion (seg):', ...
        'Visible','on',...
        'Tag','Torden');

    %Espacio Orden del Filtro -------------------------------------------------------------
    uicontrol('parent',PFiltrar, ...
        'Style','edit', ...
        'Units','points', ...
        'HorizontalAlignment','center', ...
        'BackgroundColor',[0.850980392156863 0.925490196078431 1 ], ...
        'ListboxTop',0, ...
        'Position',[280 78 40 10], ...
        'Tag','time',...
        'String','5');
  