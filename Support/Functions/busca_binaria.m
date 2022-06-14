function [j] = busca_binaria(dado, inicio, fim, vetor)
                        %Função que busca valores mais próximos de temperatura utilizando método de
                        %pesquisa binária. 

                        %Variáveis de entrada
                        %dado - dado a ser buscado no arquivo de correção
                        %inicio - Índice inicial de buca
                        %fim - Índice final de busca
                        %vetor - Arquivo com valores de correção no qual é buscado o dado

                        %Variáveis de saída
                        %j - Índice retornado na busca

                        iaux=inicio+ceil((fim-inicio)/2);
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
