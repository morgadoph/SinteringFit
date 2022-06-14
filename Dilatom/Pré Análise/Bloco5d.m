function [V] = Matriz_covar_res (dados, limite, ncurvas, correlacao)
[n_linhas, n_cols] = size(dados);

%Bloco que calcula matriz de variância dos dados e prepara dados para MMQ polinomial com covariância
V=zeros(n_linhas,n_linhas);
aux=1;
for k=1:ncurvas
    for i=aux:limite(k)
        for j=aux:limite(k)
            if i==j
                V(i,i)=dados(i,4)^2;
            else
                V(i,j)=correlacao*dados(i,4)*dados(j,4);
            end
        end
    end
    aux=aux+limite(k);
end
end