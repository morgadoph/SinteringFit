function [Dados, Vcov2] = IgualaDadosMSC2 (Data, Vcov)

%Criação de variáveis auxiliares
nCurves = size(Data);
nCurves= nCurves(1,2);
Dados=cell(1,nCurves);
Vcov2=cell(1,nCurves);
lista=cell(1,nCurves);
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
    ncols=size(Data{i});
    ncols=ncols(1,2);
    Dados{i}=zeros(ndados{imenor}(1,1),ncols);
    Vcov2{i}=zeros(ndados{imenor}(1,1),ndados{imenor}(1,1));
    lista{i}=zeros(ndados{i}(1,1),1);
    fator=1;
    m=1;
    k=1;
    for j=1:ndados{i}(1,1)
        condicao=fator*razao(i);
        if j>=condicao
            fator=fator+1;
            Dados{i}(m,:)=Data{i}(j,:);
            m=m+1;
        else
            lista{i}(k,1)=j;
            k=k+1;
        end
    end
end

for i=1:nCurves
    %Elimina as colunas das matrizes de covariância
    aux=sort(lista{i});
    aux=aux(end:-1:1);
    for j=ndados{i}(1,1):-1:1
        if j==aux(1,1)
            Vcov{i}(:,j)=[];
            Vcov{i}(j,:)=[];
            aux(1,:)=[];
        end
    end
    Vcov2{i}=Vcov{i};
end