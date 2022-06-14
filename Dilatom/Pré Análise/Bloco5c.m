function [graufinal, correlacaofinal] = determina_cor_grau (grau, correlacao, n_curvas)
 
graufinal = 0;
for i=1:n_curvas
    graufinal = grau(i) + graufinal;
end
graufinal = round(graufinal/n_curvas);

correlacaofinal = MMQmedia(correlacao,n_curvas);

end