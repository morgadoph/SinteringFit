function [V]= constroiVII (l0,resolucaoL, resolucaoT, cet, ncor,ndados)
                    %Função que cria matriz de covariância dos dados levando em consideração
                    %o coeficiente de expansão térmico medido e as resoluções do sensor de 
                    %deslocamento e da temperatura do termopar.A incerteza é estimada
                    %utilizando a relação fornecida pela norma ASTM E228

                    %Variáveis de entrada
                    %l0 - Comprimento inicial da amostra
                    %resolucaoL - Resolução do sensor de deslocamento
                    %resolucaoT - Resolução do termopar próximo à amostra
                    %cet - Coeficiente de expansão térmico instantâneo para cada temperatura 
                    %ncor - Número de curvas utilizadas para obter correção
                    %Ndados - Número de dados para cada curva

                    %Variável de saída
                    %V - Matriz de covariância dos dados


                    V=zeros(ndados(1),ndados(1));                                                          %Cria matriz de covariância                                        
                        for j=1:ndados(1,1)
                            for k=1:ndados(1,1)
                                if j==k
                                    V(j,j)=(ncor/2)*4/(l0^2)*(resolucaoL^2+(cet(j,2)*l0*resolucaoT)^2);  %Variância dos dados de retração linear
                                else
                                    V(j,k)=0;                                                          %Dados independentes, logo ro=0 
                                end
                            end
                        end
                end
                