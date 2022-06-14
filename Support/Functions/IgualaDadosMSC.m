function Dados = IgualaDadosMSC (Data)

%Criação de variáveis auxiliares
nCurves = size(Data);
nCurves= nCurves(1,2);
Dados=cell(1,nCurves);
ndados=cell(1,nCurves);

%Determina o tamanho dos arquivos de dados
for i=1:nCurves
    ndados{i}=size(Data{i});
end

%Determina qual o menor arquivo de dados
imenor=1;
for i=2:nCurves
    if ndados{i}(1,1)<ndados{imenor}(1,1)
        imenor=i;
    end
end

%Determina a proporção entre o tamanho dos arquivos de dados
razao=zeros(nCurves,1);
for i=1:nCurves
    razao(i)=ndados{i}(1,1)/ndados{imenor}(1,1);
end


%Corta os dados
for i=1:nCurves
    aux=ndados{imenor}(1,1);
    ncols=size(Data{i});
    ncols=ncols(1,2);
    Dados{i}=zeros(aux,ncols);
    fator=1;
    m=1;
    for j=1:ndados{i}(1,1)
        condicao=fator*razao(i);
        if j>=condicao
            fator=fator+1;
            Dados{i}(m,:)=Data{i}(j,:);
            m=m+1;
            
        end
    end
end

%Verifica se o último termo é nulo e iguala ao antepenúltimo
for i=1:nCurves
    if Dados{i}(ndados{imenor}(1,1),1)==0
        aux=ndados{imenor}(1,1)-1;
        Dados{i}(ndados{imenor}(1,1),:)=Dados{i}(aux,:);
    end
end

end