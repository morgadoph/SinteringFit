function [V]= constroiVII (l0,resolucaoL, resolucaoT, cet, ncor,ndados)
                    %Fun��o que cria matriz de covari�ncia dos dados levando em considera��o
                    %o coeficiente de expans�o t�rmico medido e as resolu��es do sensor de 
                    %deslocamento e da temperatura do termopar.A incerteza � estimada
                    %utilizando a rela��o fornecida pela norma ASTM E228

                    %Vari�veis de entrada
                    %l0 - Comprimento inicial da amostra
                    %resolucaoL - Resolu��o do sensor de deslocamento
                    %resolucaoT - Resolu��o do termopar pr�ximo � amostra
                    %cet - Coeficiente de expans�o t�rmico instant�neo para cada temperatura 
                    %ncor - N�mero de curvas utilizadas para obter corre��o
                    %Ndados - N�mero de dados para cada curva

                    %Vari�vel de sa�da
                    %V - Matriz de covari�ncia dos dados


                    V=zeros(ndados(1),ndados(1));                                                          %Cria matriz de covari�ncia                                        
                        for j=1:ndados(1,1)
                            for k=1:ndados(1,1)
                                if j==k
                                    V(j,j)=(ncor/2)*4/(l0^2)*(resolucaoL^2+(cet(j,2)*l0*resolucaoT)^2);  %Vari�ncia dos dados de retra��o linear
                                else
                                    V(j,k)=0;                                                          %Dados independentes, logo ro=0 
                                end
                            end
                        end
                end
                