function [Dados,Ndados,L0] = T0cor(Arquivo,T0,L0)
                    %Função que faz com que todas as curvas comecem da mesma temperatura
                    %inicial. O comprimento inicial de cada curva é modificado de acordo.

                    %Variáveis de entrada
                    %Arquivo - dados experimentais para uma curva
                    %T0 - temperatura inicial para todas as curvas
                    %L0 - comprimento inicial da amostra analisada

                    %Variáveis de saída
                    %Dados - Curva corrigida. Com temperatura inicial = T0
                    %Ndados - Número de linhas e colunas do arquivo corrigido
                    %L0 - Comprimento inicial na temperatura T0

                    %Bloco que busca a temperatura de corte nos dados
                    iinicial=1;
                    Tdif= ((Arquivo(1,2)-T0)^2)^(1/2);
                    ndados=size(Arquivo);
                    for i=2:ndados(1,1)
                        Tdif2= ((Arquivo(i,2)-T0)^2)^(1/2);
                        if Tdif2 <= Tdif                                                       
                            Tdif=Tdif2;
                            iinicial=i;
                        elseif Tdif2 > (4*Tdif)                                                %Condição evita o loop completo nos dados e evita que dados de resfriamento sejam usados
                            break;
                        end

                    end

                    %Corrige L0 e os dados de deslocamento
                    L0 = L0 + Arquivo(iinicial,3);
                    Dados=Arquivo(iinicial:ndados(1,1),:);
                    Ndados = size(Dados);
                    Dados(:,3)= Dados(:,3)-Dados(1,3)*ones(Ndados(1,1),1);

                end
