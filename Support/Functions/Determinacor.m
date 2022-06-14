function [cor] = Determinacor(dados,data)
                    %Função que constrói arquivos de correção, tanto para expansão térmica da
                    %amostra quanto para expansão térmica do terminal. A função procura para
                    %cada dado experimental da curva o respectivo valor de correção em uma 
                    %variável com valores de referência.

                    %Variáveis de entrada
                    %dados - Dados experimentais da curva
                    %cet_data - Função com os valores de referência para cada temperatura

                    %Variáveis de saída
                    %cet - Arquivo de correção 


                    ndados=size(dados);
                    ndados2=size(data);
                    cor=zeros(ndados(1,1),2);
                    for i=1:ndados(1,1)
                        dado=round(dados(i,2));
                        [j]=busca_binaria(dado, 1, ndados2(1), data(:,1));                     %Função que busca valor de correção para o dado para temperatura mais próxima
                        cor(i,:)=data(j,2:3);                                                  %Tal correção é válida devido a incerteza na temperatura de medição
                    end



                end
