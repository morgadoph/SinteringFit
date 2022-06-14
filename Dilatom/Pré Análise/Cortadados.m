function [curvaresa,nlin, limite] = Cortadados (curvares, corte)

[n_lin,ncol] = size(curvares);
aux = curvares(1,2) - corte;

for i=1:n_lin
    if curvares(i,2) < aux
        limite = i;
        break;
    end
end

curvares = curvares (limite:n_lin,:);
curvaresa= curvares;
nlin=n_lin-limite;

end