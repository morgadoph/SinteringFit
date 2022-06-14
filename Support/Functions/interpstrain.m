function ydata = interpstrain (Shrinkage, alvos)

ndados=size(Shrinkage);
ndados=ndados(1,1);

dados=zeros(ndados,2);
dados(:,2)=Shrinkage(:,3);
dados(:,1)=Shrinkage(:,2);
xdata=alvos;

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

ydata=interp1(dados(:,1),dados(:,2),alvos);




end