

            alr = figure('Color',[1 1 1], ...
        'MenuBar','none', ...
        'Name','SONIDO 1.0', ...
        'NumberTitle','off', ...
        'PaperUnits','points', ...
        'Position',[100 150 590 420], ...
        'Tag','Fprinc', ...
        'ToolBar','none');
    
            uicontrol('parent',alr, ...
        'Units','points', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'Callback', 'tutorialinicio2', ...
        'ListboxTop',0, ...
        'Position',[345 55 90 20], ...
        'String','Cancelar', ...
        'Tag','Binformacion');


            uicontrol('parent',alr, ...
        'Units','points', ...
        'BackgroundColor',[0.5 0.6 0.8], ...
        'Callback', 'close' , ...
        'ListboxTop',0, ...
        'Position',[45 55 90 20], ...
        'String','Aceptar', ...
        'Tag','Binformacion');