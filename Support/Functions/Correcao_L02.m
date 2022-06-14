function [Acor, l0cor,delta] = Correcao_L02 (Arquivo, l0, Tinicio, curvaref)
                    %Função utilizada para corrigir o valor de L0. É fornecido à função um
                    %intervalo de temperaturas no qual é feita uma média dos dados no eixo y.
                    %Todas as curvas são deslocadas de modo a esta média coincidir com a média
                    %de uma curva de referência.

                    %Variáveis de entrada
                    %Arquivo - dados experimentais
                    %l0 - Comprimento inicial da amostra
                    %Tinicio - Temperaturas inicial e final utilizadas no ajuste (Tinicial Tfinal)
                    %curvaref - Curva utilizada como referência

                    %Variáveis de saída
                    %Acor - Dados corrigidos pelo comprimento inicial
                    %l0 - Comprimento inicial corrigido

                    ncurvas=size(Arquivo);
                    media=zeros(ncurvas(1,1),1);
                    for i=1:ncurvas
                        %Bloco de criação de variáveis auxiliares utilizadas para determinar a
                        %posição dos dados para as devidas temperaturas adotadas
                        ndados=size(Arquivo{i});
                        dados=Arquivo{i};
                        iinicial=1;
                        ifinal=1;
                        Tinicial=Tinicio(1,1);
                        Tfinal=Tinicio(1,2);
                        Tdifi = ((dados(1,2)-Tinicial)^2)^(1/2);
                        Tdiff = ((dados(1,2)-Tfinal)^2)^(1/2);

                        %Bloco utilizado para determinar as posições dos dados de acordo com as
                        %temperaturas limites adotadas
                        for j=2:ndados(1,1);
                            Tdifi2 = ((dados(j,2)-Tinicial)^2)^(1/2);
                            if Tdifi2 <= Tdifi
                                iinicial = j;
                                Tdifi = Tdifi2;
                            elseif Tdifi2 > (4*Tdifi)
                                break;
                            end
                        end
                        for j=2:ndados(1,1)
                            Tdiff2 = ((dados(j,2)-Tfinal)^2)^(1/2);
                            if Tdiff2 <= Tdiff
                                ifinal = j;
                                Tdiff = Tdiff2;
                            elseif Tdiff2 > (4*Tdiff)
                                break;
                            end
                        end

                        %Bloco que calcula a média de cada curva
                        dadosy = dados(iinicial:ifinal,3);
                        [media(i)]=mean(dadosy);

                    end

                    %Bloco que calcula a correção e corrige os dados
                    delta=media-media(curvaref)*ones(ncurvas(1,1),1);
                    Acor=Arquivo;
                    for i=1:ncurvas
                        Acor{i}(:,3)= Acor{i}(:,3)-delta(i);
                    end
                    l0cor=l0+delta;                  
                end
