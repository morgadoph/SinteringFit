function [dadoscor] = corrigi_expterm (dados, expterm, graufinal, L0)

[n_linhas,n_cols]=size(dados);
dadoscor=zeros(n_linhas,2);
for i=1:n_linhas
    aux=0;
    for j=2:graufinal
        aux=expterm(j)*dados(i,2)^(j-1)+aux;
    end
    dadoscor(i,1)=(dados(i,3)-L0*aux)/(1+aux);
    %Calcular a incerteza
end