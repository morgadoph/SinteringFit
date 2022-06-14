%******************Função que separa as curvas em aquecimento e resfriamento****************
function [curvaaq, curvares] = Separador (dados, n_linhas)


maior = dados(1,2);                                             %Variável que guardará maior temperatura
maiori = 1;                                                     %Variável que guardará número da linha de maior temperatura __ Divide aquecimento e resfriamento
for i=2:n_linhas                                                %Loop que testa se a próxima temperatura é maior
    if dados(i,2) >= maior                                    
        maiori = i;
        maior = dados(i,2);
    end
end

%Variáveis auxiliares
aux=n_linhas-maiori;                                            %Determina número de linhas para matriz de resfriamento
curvaaq = zeros(maiori,4);
curvares = zeros(aux,4);

%Cria matriz do primeiro arquivo de dados (Aquecimento)
for i=1:maiori
    for j=1:4
        curvaaq(i,j)=dados(i,j);
    end
end

%Cria matriz do segundo arquivo de dados (Resfriamento)
inicial=maiori+1;
for i=inicial:n_linhas
    for j=1:4
        curvares(i-maiori,j)=dados(i,j);
    end
end

end
    
