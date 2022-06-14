function [cor] = Determinacor(dados,data)
                    %Fun��o que constr�i arquivos de corre��o, tanto para expans�o t�rmica da
                    %amostra quanto para expans�o t�rmica do terminal. A fun��o procura para
                    %cada dado experimental da curva o respectivo valor de corre��o em uma 
                    %vari�vel com valores de refer�ncia.

                    %Vari�veis de entrada
                    %dados - Dados experimentais da curva
                    %cet_data - Fun��o com os valores de refer�ncia para cada temperatura

                    %Vari�veis de sa�da
                    %cet - Arquivo de corre��o 


                    ndados=size(dados);
                    ndados2=size(data);
                    cor=zeros(ndados(1,1),2);
                    for i=1:ndados(1,1)
                        dado=round(dados(i,2));
                        [j]=busca_binaria(dado, 1, ndados2(1), data(:,1));                     %Fun��o que busca valor de corre��o para o dado para temperatura mais pr�xima
                        cor(i,:)=data(j,2:3);                                                  %Tal corre��o � v�lida devido a incerteza na temperatura de medi��o
                    end



                end
