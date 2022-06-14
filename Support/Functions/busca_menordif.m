function j = busca_menordif (alvo, dados)

ndados=size(dados);
ndados=ndados(1,1);

dif=((alvo-dados(1,1))^2)^(1/2);
j=1;

for i=2:ndados
    aux = ((alvo-dados(i,1))^2)^(1/2);
    if aux <= dif
        dif = aux;
        j=i;
    end
end


end