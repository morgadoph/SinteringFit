function [param, chi2aj, C]=MMQ_pol_cov (dadosx, dadosy, V, grau, ndados)

%Laço que ajusta polinômio e testa hipótese ao final para verificar grau do polinômio
for k=grau:-1:1
    colunas=grau+1;                                                            %Determina o número de colunas da matriz x e número de parâmetros do ajuste
    param=zeros(colunas,2);                                                    %Parâmetros do ajuste e incertezas (2 colunas)

    %Criação da matriz de planejamento
    X=zeros(ndados,colunas);
    for i=1:ndados
        for j=1:colunas
            X(i,j)=dadosx(i,1)^(j-1);
        end
    end
    
    %Bloco de ajuste do polinômio por MMQ
    aux=zeros(colunas,1);                                                      %Armazenará parâmetros
    aux2=zeros(colunas,1);                                                     %Armazenará incertezas dos parâmetros
    Xtrans=X';                                                                 %Transposta da matriz de planejamento
    V1=Xtrans*(V\X);                                                           %Calcula termo auxiliar do ajuste
    V1inv=inv(V1);                                                             %Calcula matriz de variâncias dos parâmetros
    V2=Xtrans*(V\dadosy);                                                      %Calcula termo auxiliar do ajuste
    aux=V1\V2;                                                                 %Determina parâmetros do ajuste
    for i=1:colunas
        aux2(i,1)=V1inv(i,i)^(1/2);                                            %Determina incerteza dos parâmetros ajustados
    end
    param=[aux aux2];                                                          %Matriz de parâmetros do ajuste final
    
    
    %Bloco de teste de hipótese a=0 e teste de chi2
    [chi2teo, var] = chi2stat(ndados);                                         %Determina chi2 médio e variância para número de dados ajustados
    h = ztest( param(colunas,1),0,paraminc(colunas,2)^(1/2));                  %Efetua o teste z para parâmetro = 0 dentro da incerteza alfa=5%
    valorz=param(colunas,1)/(param(colunas,2)^(1/2));                          %Calcula o valor da variável z
    if h==1
        break;
    end

end
    
    chi2aj=((dadosy-X*aux)'*(V\(dadosy-X*aux)))/(ndados-colunas);             %Chi2 do ajuste
    C=(V1\Xtrans)/V;
end

end
