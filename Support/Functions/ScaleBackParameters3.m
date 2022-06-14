function Parametros =  ScaleBackParameters3 (x0, ndados, dados)

Parametros=zeros(3,1);
nlinhas=size(dados);
xdata=zeros(nlinhas(1,1),1);
nCurves=size(ndados);
aux=2;
aux2=0;
aux3=1;
dados(:,2)=dados(:,2)+273.15*ones(nlinhas(1,1),1);
R=8.31447e-3;
for i=1:nCurves(1,1)
    soma=0;
    aux2=aux2+ndados{i}(1,1);
    for j=aux:aux2
        for k=aux:j
            soma=soma+(1/dados(k,2)*exp(-x0(1)/(R*dados(k,2)))+1/dados(k-1,2)*exp(-x0(1)/(R*dados(k-1,2))))/2*(dados(k,1)-dados(k-1,1));
        end
        xdata(j,1)= log10(soma);
    end
    aux=aux+ndados{i}(1,1);
        
end
    
for i=1:nCurves(1,1)
    xdata(aux3,1)=xdata(aux3+1,1);
    aux3=aux3+ndados{i}(1,1);
end
m=mean(xdata);
stv=std(xdata);

Parametros(1,1)=x0(1);
Parametros(2,1)= x0(2)/stv;
Parametros(3,1)= -x0(2)*m/stv +x0(3);




end
