[arch2dato,padarch2dato] = uigetfile({'*.dat','arquivos de dados (*.dat)';}, ...
            'Carregue o arquivo');
    
    global arquivo2
    arquivo2 = load (arch2dato);
    
            uicontrol('parent',cargador, ...
        'Units','points', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'Callback','loadArchivo3', ...
        'ListboxTop',0, ...
        'Position',[345 75 90 20], ...
        'String','Browse', ...
        'Tag','Binformacion');

            uicontrol('Parent',cargador,...
        'Style','text', ...
        'Units','points', ...
        'HorizontalAlignment','left', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'ListboxTop',1, ...
        'Position',[240 105 100 18], ...
        'String',arch2dato, ...
        'Visible','on',...
        'Tag','Ttipofuncion');