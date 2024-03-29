% FILTROIir.m
% SONIDO 1.0 �
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Filtra 

function FILTROIir

    %------------------------------ PANTALLA DE FILTRADO IIR -------------------       
    %--------------------------------- ventana Filtro Iir -----------------------------------
    PFiltrado = figure('Color',[1 1 1], ...
        'MenuBar','none', ...
        'Name','FILTRADO', ...
        'NumberTitle','off', ...
        'PaperUnits','points', ...
        'Position',[695 380 450 190], ...
        'Tag','Fprinc', ...
        'ToolBar','none');

    %--------------------------------------------------------------------------
    % Obteniendo los valores ingresados
    archivo=findobj('tag','Earch');
    archivo=get(archivo,'string');

    tipoiir=findobj('Tag','tiposIir');
    tipoiir=get(tipoiir,'Value');   

    X=findobj('Tag','Eorden');
    X=get(X,'string');   
    N=str2num(X);

    xW1=findobj('Tag','EfrecLow');
    xW1=get(xW1,'string');
    W1=str2num(xW1);

    xW2=findobj('Tag','EfrecHigh');
    xW2=get(xW2,'string');
    W2=str2num(xW2);
    %Recopilando Informacion del archivo de audio
    [dato,fs]=wavread(archivo);
    p=size(dato,1);
    t=(1:p)/fs;

     %Filtro IIR
     Wl=2*W1/fs; % %Normalizacion de las frecuencias
     Wh=2*W2/fs; %Normalizacion de las frecuencias
     Wn=[Wl Wh]; %Frecuencia Pasabanda
     R=2;   %Risado establecido para rechazabanda 
     Rp=40; %Risado establecido para pasabanda

    switch tipoiir,
           case 1
            [B,A]=butter(N,2*pi*Wn); %Filtrado Butterworth
           case 2 
            [B,A]=cheby1(N,R,2*pi*Wn);%Filtrado Chebyshev
           case 3
            [B,A]=ellip(N,R,Rp,2*pi*Wn);%Filtrado Eliptico  
    end 
   
    %Grafica del filtro en frecuencia

    F=0:10:2500; %Puntos para Evaluar la respuesta frecuencial
    H=freqz(B,A,F,fs);
    PFiltrado;
    semilogy(F,abs(H));%graficando la respuesta frecuencial en decibelios
 
    %Filtrado
    sal=filter(B,A,dato);    

   %Escribiendo el dato de salida
   wavwrite(sal,fs,8,'SalidaFILTRO');
   clc;
end
   
  