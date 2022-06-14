function [dados, Valfay]= Corrigi_sample (d, n_linhas, param, grau, L0, k, C, Vres, correlacao)

%Bloco que calcula matriz de covariâncias entre dados utilizados no ajuste
%e dados de aquecimento
[n_lin, n_col]=size(Vres);
A=zeros(n_lin,n_linhas);
for i=1:n_lin
    for j=1:n_linhas
        A(i,j)=correlacao*d(j,4)*(Vres(i,i)^(1/2));
    end
end

%Bloco que calcula matriz de transformação entre matriz de covariâncias dos
%parâmetros e de alfa
aux=grau-1;
X=zeros(n_linhas,aux);
for i=1:n_linhas
    for j=2:grau
        X(i,j-1)=d(i,2)^(j-1);
    end
end
Valfay=X*C*A; %Calculo da matriz de covariância de alfa com os dados

%Bloco que compõe matriz de covariância dos dados utilizados para correção
%do deslocamento
aux=2*n_linhas+1;
Vdados = zeros (aux,aux);
for i=1:n_linhas
    for j=1:n_linhas
        Vdados(i,j)=correlacao*d(i,4)*d(j,4);
    end
end
for i=n_linhas+1:2*n_linhas
    for j=n_linhas+1:2*n_linhas
        Vdados(i,j)=Valfay(i,j);
end

    



Vcov=

dados=zeros(d);
for j=2:n_linhas
    aux=0;
    aux2=0;
    for i=2:grau
        aux=param(i,1)*(d(j,2)-d(j-1,2))^(i-1);
        aux2=param(i,2)*(d(j,2)-d(j-1,2))^(i-1);
    end
    dados(j,3)=(d(j,3)-aux*L0(k,1))/(1+aux);
end


end