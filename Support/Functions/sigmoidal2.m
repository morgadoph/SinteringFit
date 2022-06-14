function F = sigmoidal2(x0,S)

    dados=S{1};
    ndados=S{2};
    nlinhas=size(dados);
    F=zeros(nlinhas(1,1),1);
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
    for i=1:nlinhas
        F(i)=x0(2)+(100-x0(2))/(1+exp((-xdata(i)+x0(3))/x0(4)));
    end
    
end
