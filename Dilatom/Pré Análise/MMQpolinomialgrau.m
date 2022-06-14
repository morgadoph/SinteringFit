function [par_ajuste, chi2] = MMQpolinomialgrau (dados, graupolinomio)

n_linhas=0;
n_cols=0;
[n_linhas,n_cols]=size(dados);                                             %Lê o número de dados a ajustar
colunas=graupolinomio+1;                                                   %Determina o número de colunas da matriz x e número de parâmetros do ajuste
par_ajuste=zeros(colunas,2);                                               %Parâmetros do ajuste e incertezas (2 colunas)
dadosy=zeros(n_linhas,1);
for i=1:n_linhas
    for j=1:n_linhas
        dadosy(i,1)=dados(i,3);
        if i==j
            V(i,i)=dados(i,4)^2;
        else
            V(i,j)=0;
        end
    end
end
Vinv=inv(V);                                                               %Inversa da matriz de variância dos dados

%Criação da matriz de planejamento
X=zeros(n_linhas,colunas);
for i=1:n_linhas
    for j=1:colunas
        X(i,j)=dados(i,2)^(j-1);
    end
end

aux=zeros(colunas,1);                                                      %Armazenará parâmetros
aux2=zeros(colunas,1);                                                     %Armazenará incertezas dos parâmetros
Xtrans=X';                                                                 %Transposta da matriz de planejamento
Vpar=inv(Xtrans*Vinv*X);                                                   %Calcula matriz de variâncias dos parâmetros
aux=Vpar*Xtrans*Vinv*dadosy;                                               %Determina parâmetros do ajuste
for i=1:colunas
    aux2(i)=Vpar(i,i);                                                   %Determina incerteza dos parâmetros ajustados
end
par_ajuste=[aux aux2];                                                     %Matriz do ajuste final
chi2=((dadosy-X*aux)'*Vinv*(dadosy-X*aux))/(n_linhas-colunas);             %Chi2 do ajuste
par_ajuste= par_ajuste(colunas,:);                                         %devolve apenas parâmetros do monômio de maior grau
end

