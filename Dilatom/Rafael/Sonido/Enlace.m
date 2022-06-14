% Programa: MGraph 1.0
% Clase: enlace
% Desarrollado por: Juan Guillermo Valencia
%                   Sergio Andrés Hurtado Ruiz
% Fecha: Julio de 2008        
% Contenido:    Llama a la clase que le corresponda graficar sus
%               correspondientes tipos de funciones

function Enlace
    
    tipofuncion=findobj('Tag','Btipofuncion');
    tipofuncion=get(tipofuncion,'Value');   
       
    switch tipofuncion,
        case 1,
            Filtrar                             
        case 2,
            Codificar                
        case 3,
            Decodificar               
    end
end