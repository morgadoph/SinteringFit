function [j] = busca_binaria2(alvo, 1, densidade)
                        %Função que busca valores mais próximos da densidade utilizando método de
                        %pesquisa binária. 

                        %Variáveis de entrada
                        %dado - dado a ser buscado no arquivo de correção
                        %inicio - Índice inicial de buca
                        %fim - Índice final de busca
                        %vetor - Arquivo com valores de correção no qual é buscado o dado

                        %Variáveis de saída
                        %j - Índice retornado na busca

                        ndados=size(dado);
                        ndados=ndados(1);
                        iaux=1+ceil((ndados-1)/2);
                        if (dado == vetor(iaux,1))
                            j=iaux;
                        else
                            if (inicio==fim)
                                j=1;
                            elseif (dado < vetor(iaux))
                                [j] = busca_binaria (dado, inicio, (iaux-1), vetor);
                            elseif (dado > vetor(iaux))
                                [j] = busca_binaria (dado, (iaux+1), fim, vetor);
                            end
                        end

                    end
