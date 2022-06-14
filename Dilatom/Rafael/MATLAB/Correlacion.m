clc
clear all

func1 = input('joder1  :                       ','s');
tt1i  = input('limite inferior del intervalo : ');
tt1s  = input('limite superior del intervalo : ');
%peri1 = input('es periodica?  : 1 o 0          ');
%Per1  = input('periodo  :                      ');
func2 = input('joder2  :                       ','s');
tt2i  = input('limite inferior del intervalo : ');
tt2s  = input('limite superior del intervalo : ');
%peri2 = input('es periodica?  : 1 o 0          ');
%Per2  = input('periodo  :                      ');
n1    = input('muestras  :                     ');
paso1 = (tt1s - tt1i)/n1;
n2    = (tt2s - tt2i)/paso1;
%paso2 = (tt2s - tt2i)/n2;
t     = -(tt1i+tt2i):paso1:(tt1s+tt2s);
a     = size(t);
b     = a(2);
vec1  = zeros(1, n1+1);
vec2  = zeros(1, n2+1);
t1=zeros(1, n1+1);
t2=zeros(1, n2+1);
for i=1 : 1 : n1 + 1, %vector de la funcion 1
    s = tt1i + (i-1)*paso1;
    mientras = eval(func1);
    vec1(i) = mientras;
    t1(i) = tt1i+(i-1)*paso1 ;
end
i=0;
s=0;
for i=1 : 1 : n2 + 1, %vector de la funcion 2
    s = tt2i + (i-1)*paso1;
    vec2(i) = eval(func2);
    t2(i) = tt2i+(i-1)*paso1 ;
end
vec1;
vec2;
hold on;
plot(t1,vec1);
hold on;
plot(t2,vec2);
hold on;
i=0;
correlacion = zeros(1, b);
primo = zeros(1, n2+1);
%terco = zeros(1, n2+1);
estacion = [primo, vec1, primo];
estaciont = zeros(1, (2*(n2)+n1));
correlacion = zeros(1, n1 + n2 + 1);
for i = 1 : 1: (n1 + n2) , % ciclo de ubicacion de los vectores            Correlacion
    primo2 = zeros(1, i);
    terco2 = zeros(1, ((2*(n2)+n1)-i-n2));
    estaciont = [primo2, vec2, terco2];
    for j = 1 : 1 : (n1 + 2*n2) , % ciclo de integracion
        multiplicacion(j) = estacion(j) * estaciont(j);
    end
    for k = 1 : 1 : (n1 + 2*n2) ,
        correlacion(i)= correlacion(i) + (multiplicacion(k) * paso1);
    end
end
tt = -((tt2s - tt2i)/2) : paso1 : (((n1 + n2)*paso1)-((tt2s - tt2i)/2));
subplot
figure
plot(tt, correlacion);

        

    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
 
