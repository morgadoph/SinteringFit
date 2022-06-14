function Parametros =  ScaleBackParameters2 (x0, ndados, dados, grau)

fator=grau+2;
Parametros=zeros(fator,1);
nlinhas=size(dados);
xdata=zeros(nlinhas(1,1),1);
nCurves=size(ndados);
aux=2;
aux2=0;
dados(:,2)=dados(:,2)+273.15*ones(nlinhas(1,1),1);
R=8.31447e-3;
for i=1:nCurves(1,1)
    aux2=aux2+ndados{i}(1,1);
    for k=aux:aux2
        soma=(1/dados(k,2)*exp(-x0(1)/(R*dados(k,2)))+1/dados(k-1,2)*exp(-x0(1)/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-x0(1)/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
        xdata(k,1)= soma+xdata(k-1,1);
    end
    aux=aux+ndados{i}(1,1);

end
xdata=log10(xdata);
naux=0;
for i=nCurves(1,1):-1:1
    naux=naux+ndados{i}(1,1);
    xdata(nlinhas(1,1)-naux+1,:)=xdata(nlinhas(1,1)-naux+2,:);

end
m=mean(xdata);
stv=std(xdata);

if grau==7
    Parametros(1,1)=x0(1);
    Parametros(2,1)= x0(2)/stv^7;
    Parametros(3,1)= -7*x0(2)*m/stv^7     +x0(3)/stv^6;
    Parametros(4,1)= 21*x0(2)*m^2/stv^7   -6*x0(3)*m/stv^6    +x0(4)/stv^5;
    Parametros(5,1)= -35*x0(2)*m^3/stv^7  +15*x0(3)*m^2/stv^6 -5*x0(4)*m/stv^5    +x0(5)/stv^4;
    Parametros(6,1)= 35*x0(2)*m^4/stv^7   -20*x0(3)*m^3/stv^6 +10*x0(4)*m^2/stv^5 -4*x0(5)*m/stv^4   +x0(6)/stv^3;
    Parametros(7,1)= -21*x0(2)*m^5/stv^7  +15*x0(3)*m^4/stv^6 -10*x0(4)*m^3/stv^5 +6*x0(5)*m^2/stv^4 -3*x0(6)*m/stv^3   +x0(7)/stv^2;
    Parametros(8,1)= 7*x0(2)*m^6/stv^7    -6*x0(3)*m^5/stv^6  +5*x0(4)*m^4/stv^5  -4*x0(5)*m^3/stv^4 +3*x0(6)*m^2/stv^3 -2*x0(7)*m/stv^2 +x0(8)/stv;
    Parametros(9,1)= -x0(2)*m^7/stv^7      +x0(3)*m^6/stv^6   -x0(4)*m^5/stv^5    +x0(5)*m^4/stv^4   -x0(6)*m^3/stv^3   +x0(7)*m^2/stv^2 -x0(8)*m/stv +x0(9);
elseif grau ==6
    Parametros(1,1)=x0(1);
    Parametros(2,1)= +x0(2)/stv^6;
    Parametros(3,1)= -6*x0(2)*m/stv^6    +x0(3)/stv^5;
    Parametros(4,1)= +15*x0(2)*m^2/stv^6 -5*x0(3)*m/stv^5    +x0(4)/stv^4;
    Parametros(5,1)= -20*x0(2)*m^3/stv^6 +10*x0(3)*m^2/stv^5 -4*x0(4)*m/stv^4   +x0(5)/stv^3;
    Parametros(6,1)= +15*x0(2)*m^4/stv^6 -10*x0(3)*m^3/stv^5 +6*x0(4)*m^2/stv^4 -3*x0(5)*m/stv^3   +x0(6)/stv^2;
    Parametros(7,1)= -6*x0(2)*m^5/stv^6  +5*x0(3)*m^4/stv^5  -4*x0(4)*m^3/stv^4 +3*x0(5)*m^2/stv^3 -2*x0(6)*m/stv^2 +x0(7)/stv;
    Parametros(8,1)= +x0(2)*m^6/stv^6    -x0(3)*m^5/stv^5    +x0(4)*m^4/stv^4   -x0(5)*m^3/stv^3   +x0(6)*m^2/stv^2 -x0(7)*m/stv +x0(8);
elseif grau ==5
    Parametros(1,1)=x0(1);
    Parametros(2,1)= +x0(2)/stv^5;
    Parametros(3,1)= -5*x0(2)*m/stv^5    +x0(3)/stv^4;
    Parametros(4,1)= +10*x0(2)*m^2/stv^5 -4*x0(3)*m/stv^4   +x0(4)/stv^3;
    Parametros(5,1)= -10*x0(2)*m^3/stv^5 +6*x0(3)*m^2/stv^4 -3*x0(4)*m/stv^3   +x0(5)/stv^2;
    Parametros(6,1)= +5*x0(2)*m^4/stv^5  -4*x0(3)*m^3/stv^4 +3*x0(4)*m^2/stv^3 -2*x0(5)*m/stv^2 +x0(6)/stv;
    Parametros(7,1)= -x0(2)*m^5/stv^5    +x0(3)*m^4/stv^4   -x0(4)*m^3/stv^3   +x0(5)*m^2/stv^2 -x0(6)*m/stv +x0(7);
elseif grau ==4
    Parametros(1,1)=x0(1);
    Parametros(2,1)= +x0(2)/stv^4;
    Parametros(3,1)= -4*x0(2)*m/stv^4   +x0(3)/stv^3;
    Parametros(4,1)= +6*x0(2)*m^2/stv^4 -3*x0(3)*m/stv^3   +x0(4)/stv^2;
    Parametros(5,1)= -4*x0(2)*m^3/stv^4 +3*x0(3)*m^2/stv^3 -2*x0(4)*m/stv^2 +x0(5)/stv;
    Parametros(6,1)= +x0(2)*m^4/stv^4   -x0(3)*m^3/stv^3   +x0(4)*m^2/stv^2 -x0(5)*m/stv +x0(6);
elseif grau ==3
    Parametros(1,1)=x0(1);
    Parametros(2,1)= +x0(2)/stv^3;
    Parametros(3,1)= -3*x0(2)*m/stv^3   +x0(3)/stv^2;
    Parametros(4,1)= +3*x0(2)*m^2/stv^3 -2*x0(3)*m/stv^2 +x0(4)/stv;
    Parametros(5,1)= -x0(2)*m^3/stv^3   +x0(3)*m^2/stv^2 -x0(4)*m/stv +x0(5);
elseif grau ==2
    Parametros(1,1)=x0(1);
    Parametros(2,1)= +x0(2)/stv^2;
    Parametros(3,1)= -2*x0(2)*m/stv^2 +x0(3)/stv;
    Parametros(4,1)= +x0(2)*m^2/stv^2 -x0(3)*m/stv +x0(4);
elseif grau ==1
    Parametros(1,1)=x0(1);
    Parametros(2,1)= +x0(2)/stv;
    Parametros(3,1)= -x0(2)*m/stv +x0(3);
end

end