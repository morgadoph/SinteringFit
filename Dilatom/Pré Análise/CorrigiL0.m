%**************Função que corrigi os valores da retração pelo L0*************************

function [acor, Vcov, L0, incerteza, param, chi2aj, chi2teo, var ] = CorrigiL0 (dados, n_linhas, L0, incerteza, V, inicio, fim)
    
%Bloco que determina a linha inicial dos dados que serão utilizados no ajuste
    for i=1:n_linhas
        inicioT=1;
        if dados(i,2)<inicio
            inicioT=incicioT+1;
        else
            break;
        end
    end
    
    %Bloco que determina a linha final dos dados utilizados no ajuste
    for i=1:n_linhas
        fimT=1;
        if dados(i,2)<fim
            fimT= fimT+1;
        else
            break;
        end
    end
    
    %Bloco que prepara dados para ajuste linear
    dadosx=dados(inicioT:fimT,2);                                          %Prepara dados independentes para ajuste linear
    dadosy=dados(inicioT:fimT,3);                                          %Prepara dados dependentes para ajuste linear
    param= zeros(2,2);                                                     %Matriz de parâmetros do ajuste
    Vajuste = V(inicioT:fimT,inicioT:fimT);                                %Matriz de covaiância dos dados utilizados no ajuste
    T0=dados(1,2);                                                         %Temperatura ambiente
    
    %Criação da matriz de planejamento
    ndados=fimT-inicioT;
    X=zeros(ndados,colunas);
    for i=1:ndados
        for j=1:2
            X(i,j)=(dadosx(i)-T0)^(j-1);
        end
    end
    
    %Bloco de ajuste dos dados
    aux=zeros(2,1);                                                        %Armazenará parâmetros
    aux2=zeros(2,1);                                                       %Armazenará incertezas dos parâmetros
    Xtrans=X';                                                             %Transposta da matriz de planejamento
    V1=Xtrans*(Vajuste\X);
    V1inv=inv(V1);
    V2=Xtrans*(Vajuste\dadosy);
    aux=V1\V2;
    for i=1:colunas
        aux2(i,1)=V1inv(i,i)^(1/2);                                         %Determina incerteza dos parâmetros ajustados
    end
    param=[aux aux2];                                                      %Matriz do ajuste final
    [chi2teo, var] = chi2stat(ndados);                                     %Determina chi2 médio e variância para número de dados ajustados
    chi2aj=((dadosy-X*aux)'*(V\(dadosy-X*aux)))/(ndados-k);                %Chi2 do ajuste
    
    %Bloco que efetua correção dos dados e de L0
    acor = dados;                                                          
    for i=1:n_linhas
        acor(i,3)=(dados(i,3)-param(1,1));                                 %Corrigi todos os dados segundo DLfinal - DLinicial
        L0=L0+param(1,1);                                                  %L0 + fator de correção
        L0var=(incerteza^2+aux2(1,1)^2);                                   %Calcula variância em Lo
    end
    
    %Bloco que calcula covariância de parâmetros ajustados e dados não utilizados no ajuste (igual para todos dados)
    C=zeros(ndados,1);
    for i=1:ndados
        C(i)=0.5*0.00005*0.00005;
    end
    Vaux=Xtrans*(Vajuste\C);
    Vpardados=V1*Vaux;
    
    %Bloco que calcula covariância de parâmetros e qualquer um dos dados utilizados no ajuste (igual para todos)
    for i=1:ndados
        if i==1
            C(i)=0.0005*0.0005;
        end
        C(i)=0.5*0.00005*0.00005;
    end
    Vaux=Xtrans*(Vajuste\C);
    Vpardados2=V1*Vaux;
    
    %Bloco que calcula covariância entre dados e L0
    b=n_linhas+1;
    Vcov=zeros(b,b);
    for i=1:n_linhas
        for j=1:n_linhas
            Vcov(i,j)=V(i,j);
        end
    end
    
    for i=1:n_linhas
        Vcov(i,b)=Vpardados(1);
        Vcov(b,i)=Vpardados(1);
    end
    
    for i=inicioT:fimT
        Vcov(i,b)=Vpardados2(1);
        Vcov(b,i)=Vpardados2(1);
    end
    Vcov(b,b)=L0var;
    
         
end


