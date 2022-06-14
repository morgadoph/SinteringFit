% Grabadora.m
% SONIDO 1.0 ®
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Graba archivo.WAV segun especificaciones del usuario


function Grabadora

    tempo=findobj('Tag','time');
    tempo=get(tempo,'string');   
    ti=str2num(tempo);

    Enpla=findobj('Tag','Enableplay');
    Enpla=get(Enpla,'Value');  

    nome=findobj('Tag','nombregrab');
    nome=get(nome,'string');

    Fs = 11025;
    y = wavrecord(ti*Fs, Fs, 'single' );
    wavwrite(y,Fs,32,nome);

    ending=1;

    if ending == 1
        
        %---------------------------- PANTALLA DE MENU DE TIEMPO ---------------------------       
        %--------------------------------- ventana TIEMPO -----------------------------------
        PFiltrar = figure('Color',[1 1 1], ...
            'MenuBar','none', ...
            'Name','Finaliza grabacion', ...
            'NumberTitle','off', ...
            'PaperUnits','points', ...
            'Position',[695 380 450 190], ...
            'Tag','Fprinc', ...
            'ToolBar','none');

        axes('Position',[0 0 1 1]);
        imagen=imread('microfono.jpg');
        image(imagen);
        axis off;


         %---------------------------- Boton OK ----------------------------------    
        uicontrol('parent',PFiltrar, ...
            'Units','points', ...
            'BackgroundColor','white', ...
            'Callback','close', ...
            'ListboxTop',0, ...
            'Position',[95 25 70 20], ...
            'String','OK', ...
            'Tag','Bcerrar');  
        % ---------------------------------------------------------------------

         %------------------------------------------------------------------------------------
        %frame Frecuencia Baja de Corte -----------------------------------------------------
        uicontrol('parent',PFiltrar,...
            'Style','frame',...
            'Units','points',...
            'BackgroundColor',[0 0 0],...
            'Position',[55 85 150 10],...
            'Tag','FfrecLow');

        %Texto Frecuencia Baja de Corte -----------------------------------------------------
        uicontrol('Parent',PFiltrar,...
            'Style','text', ...
            'Units','points', ...
            'HorizontalAlignment','left', ...
            'BackgroundColor','white', ...
            'ListboxTop',0, ...
            'Position',[57 86 150 12], ...
            'String','    Su grabacion finalizo correctamente', ...
            'Visible','on',...
            'Tag','TfrecLow');

         %------------------------------------------------------------------------------------
    
        %----------------------Sonido de Advertencia--------------------------------
     
            [dato,fs]=wavread('aviso(nomodificar)');
            p=size(dato,1);
            t=(1:p)/fs;
            N=200;
            n=1:((N-1)/2);
            w=0.54+0.4*cos(2*pi*n/(N-1));
            fc1=40/fs;
            fc2=5000/fs;
            hd=(sin(2*pi*n*fc2)./(pi*n))-(sin(2*pi*n*fc1)./(pi*n));
            h=w.*hd;
            ht=fliplr(h);
            h0=2*(fc2-fc1);
            vect=cat(2,ht,h0,h);
            %------------------Ejecutando reproduccion ------------------------------- 
            proc=filter(vect,1,dato);
            wavplay(proc,fs);
     %---------------------------------------------------------------------
     %---------------  
    end
end
  