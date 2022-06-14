function [dcor, incerteza]= Corrigi_sample2 (dados, n_linhas, param, grau, L0, j);         %Fun��o que corrigi expans�o t�rmica da amostra

dcor =d;
alfa=zeros(n_linhas,1);                                                    %Fun��o que calcula a expans�o t�rmica total
for i=1:n_linhas
    for j=1:grau
        alfa(i) = alfa(i) + param(j+1,1)*d(i,2)^j;                         %param (j+1,1) porque (1,1) � coeficiente linear do ajuste
    end
end

for i=1:n_linhas
    dcor(i,3) = (d(i,3)- alfa(i)*L0(j,1))/(1+alfa(i));
end

end
    