% FILTROFir.m
% SONIDO 1.0 ®
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Filtra

function FILTROFir
   
    %-------------------------------- PANTALLA FILTRADO FIR -------------------       
    %--------------------------------- ventana Filtro fir -----------------------------------

    PFiltrado = figure('Color',[1 1 1], ...
        'MenuBar','none', ...
        'Name','FILTRADO', ...
        'NumberTitle','off', ...
        'PaperUnits','points', ...
        'Position',[695 380 450 190], ...
        'Tag','Fprinc', ...
        'ToolBar','none');
    
    %--------------------------------------------------------------------------
    % ------------------Obteniendo los valores ingresados----------------------
    archivo=findobj('tag','Earch');
    archivo=get(archivo,'string');

    tipofir=findobj('Tag','tiposfir');
    tipofir=get(tipofir,'Value');   

    X=findobj('Tag','Eorden');
    X=get(X,'string');   
    N=str2num(X);

    xW1=findobj('Tag','EfrecLow');
    xW1=get(xW1,'string');
    W1=str2num(xW1);

    xW2=findobj('Tag','EfrecHigh');
    xW2=get(xW2,'string');
    W2=str2num(xW2);
    
    %--------------------------------------------------------------------------
    %---------------Recopilando Informacion del archivo de audio---------------
    [dato,fs]=wavread(archivo);
    p=size(dato,1);
    t=(1:p)/fs;
    
    %--------------------------------------------------------------------------    
    n=1:((N-1)/2);

    switch tipofir,
        case 1,
            w=0.54+0.4*cos(2*pi*n/(N-1)); % HAMMING
        case 2,
            w=0.5+0.5*cos(2*pi*n/(N-1)); % HANNING
        case 3,
            w=0.42+0.5*cos(2*pi*n/(N-1))+0.08*cos(4*pi*n/(N-1)); % BLACKMAN
        case 4,
            w=1; % Rectangular
    end

     %Filtrado
     fc1=W1/fs;
     fc2=W2/fs;
     hd=(sin(2*pi*n*fc2)./(pi*n))-(sin(2*pi*n*fc1)./(pi*n));
     h=w.*hd;
     ht=fliplr(h);
     h0=2*(fc2-fc1);
     vect=cat(2,ht,h0,h);

     proc=filter(vect,1,dato);

    %Grafica de la frecuencia
    PFiltrado;
    [H,W]=freqz(vect,1,1024);
    plot(W*fs/(2*pi),abs(H),'k');
    
    wavwrite(proc,fs,8,'SalidaFILTRO');
end
