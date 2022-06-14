function [j] = busca_binaria(dado, inicio, fim, vetor)
                        %Fun��o que busca valores mais pr�ximos de temperatura utilizando m�todo de
                        %pesquisa bin�ria. 

                        %Vari�veis de entrada
                        %dado - dado a ser buscado no arquivo de corre��o
                        %inicio - �ndice inicial de buca
                        %fim - �ndice final de busca
                        %vetor - Arquivo com valores de corre��o no qual � buscado o dado

                        %Vari�veis de sa�da
                        %j - �ndice retornado na busca

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
