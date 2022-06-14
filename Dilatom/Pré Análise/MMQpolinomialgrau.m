function [par_ajuste, chi2] = MMQpolinomialgrau (dados, graupolinomio)

n_linhas=0;
n_cols=0;
[n_linhas,n_cols]=size(dados);                                             %L� o n�mero de dados a ajustar
colunas=graupolinomio+1;                                                   %Determina o n�mero de colunas da matriz x e n�mero de par�metros do ajuste
par_ajuste=zeros(colunas,2);                                               %Par�metros do ajuste e incertezas (2 colunas)
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
Vinv=inv(V);                                                               %Inversa da matriz de vari�ncia dos dados

%Cria��o da matriz de planejamento
X=zeros(n_linhas,colunas);
for i=1:n_linhas
    for j=1:colunas
        X(i,j)=dados(i,2)^(j-1);
    end
end

aux=zeros(colunas,1);                                                      %Armazenar� par�metros
aux2=zeros(colunas,1);                                                     %Armazenar� incertezas dos par�metros
Xtrans=X';                                                                 %Transposta da matriz de planejamento
Vpar=inv(Xtrans*Vinv*X);                                                   %Calcula matriz de vari�ncias dos par�metros
aux=Vpar*Xtrans*Vinv*dadosy;                                               %Determina par�metros do ajuste
for i=1:colunas
    aux2(i)=Vpar(i,i);                                                   %Determina incerteza dos par�metros ajustados
end
par_ajuste=[aux aux2];                                                     %Matriz do ajuste final
chi2=((dadosy-X*aux)'*Vinv*(dadosy-X*aux))/(n_linhas-colunas);             %Chi2 do ajuste
par_ajuste= par_ajuste(colunas,:);                                         %devolve apenas par�metros do mon�mio de maior grau
end

