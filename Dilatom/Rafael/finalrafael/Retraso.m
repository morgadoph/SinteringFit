% retraso.m
% DECODE 1.0 ®
% Desarrollado Por: Juan Guillermo Valencia Delgado
%                   Sergio Andres Hurtado Ruiz
%                   Felipe Restrepo Naranjo
%                   Jeferson Barrera caceres
% Fecha: Abril de 2009        
% Contenido:    Pausa el corrimiento de la clase principal aproximafamente 3 segundos.

%function d=retraso
function d=Retraso
d=0;
a=fix(clock);
a=a(6);
if a>56
   a=1;
end
while d==0
   c=fix(clock);
   c=c(6);  
   if a<(c-2)
      d=1;
   end
end
