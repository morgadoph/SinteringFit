% Programa: MGraph 1.0
% Clase: enlace      
% Contenido:    Llama a la clase que le corresponda graficar sus
%               correspondientes tipos de funciones

function EnlaceFiltro
    
    tipoFiltro=findobj('Tag','Btipo');
    tipoFiltro=get(tipoFiltro,'Value');   
       
    switch tipoFiltro,
        case 1,
            Fir   
        case 2,
            Iir               
    end
end