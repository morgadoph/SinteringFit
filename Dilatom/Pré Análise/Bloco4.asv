%*******************Função que corrigi expansão térmica dos terminais*****************

function [dadoscor]= Cor_expterm_terminais (dados, fatores)

[n_linhas, n_cols]=size(dados);                                            %Determina número de linhas a corrigir
(n_fator)=size(fatores);                                                   %Determina grau do polinômio utilizado

%Loop que corrigi expansão térmica termo a termo do polinômio
for i=1:n_linhas
    for j=1:n_fator
        dados(i,3)=dados(i,3)+fatores(j)*dados(i,2)^j;
    end
end
end
