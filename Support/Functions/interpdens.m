function [xdata,ydata,taxaaq,xdata2] = interpdens (Densidades, alvos)

ndados=size(Densidades);
ndados=ndados(1,1);

dados=zeros(ndados,3);
dados(:,1)=Densidades(:,3);
dados(:,2)=Densidades(:,2);
dados(:,3)=Densidades(:,1);
ydata=alvos;

%Bloco que organiza as linhas em ordem crescente e elimina dados com mesmo
dados = sortrows(dados);                                  
ndados=size(dados);
i=2;
while i<=ndados(1)
    if dados(i,1)==dados(i-1,1)
        dados(i,:)=[];
        ndados=size(dados);
        i=i-1;
    end
    i=i+1;
end

taxaaq=(Densidades(ndados(1,1),2)-Densidades(1,2))/((Densidades(ndados(1,1),1)-Densidades(1,1)));
xdata=interp1(dados(:,1),dados(:,2),alvos);
xdata2=interp1(dados(:,1),dados(:,3),alvos);




end