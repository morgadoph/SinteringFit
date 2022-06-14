% PlayArchivo.m
% SONIDO 1.0 ®
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    
%               Se escoge el archivo que se desea reproducir


function PlayArchivo

    [ArchPlay] = uigetfile({'*.wav','Archivos de audio grabados (*.wav)';}, ...
            'Escoja el archivo');
        if isequal(ArchPlay,0)
            PFiltrar = figure('Color',[1 1 1], ...
                 'MenuBar','none', ...
                 'Name','FILTRAR', ...       
                 'Position',[695 150 450 200], ...
                 'Tag','Fprinc', ...
                 'ToolBar','none');
                 close (gcf);
        else
            %------------------Filtrando reproduccion ------------------------------- 
            [dato,fs]=wavread(ArchPlay);
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
        end
end
