function [V] = Matriz_covar_res (dados, limite, ncurvas, correlacao)
[n_linhas, n_cols] = size(dados);

%Bloco que calcula matriz de variância dos dados e prepara dados para MMQ polinomial com covariância
V=zeros(n_linhas,n_linhas);
aux=1;
limitea=0;
for k=1:ncurvas
    limitea=limite(k)+limitea;
    for i=aux:limitea
        for j=aux:limitea
            if i==j
                V(i,i)=incerteza^2;
            else
                V(i,j)=correlacao*incerteza^2;
            end
        end
    end
    aux=aux+limite(k);
end

end