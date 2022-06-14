function [dcor, incerteza]= Corrigi_sample2 (dados, n_linhas, param, grau, L0, j);         %Função que corrigi expansão térmica da amostra

dcor =d;
alfa=zeros(n_linhas,1);                                                    %Função que calcula a expansão térmica total
for i=1:n_linhas
    for j=1:grau
        alfa(i) = alfa(i) + param(j+1,1)*d(i,2)^j;                         %param (j+1,1) porque (1,1) é coeficiente linear do ajuste
    end
end

for i=1:n_linhas
    dcor(i,3) = (d(i,3)- alfa(i)*L0(j,1))/(1+alfa(i));
end

end
    