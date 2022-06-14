function [V] = constroiVI (ndados,incerteza, ncor, l0)
                    %Função que cria matriz de covariância dos dados de retração linear 
                    %levando em consideração a incerteza experimental fornecida pelo usuário. 
                    %Para isto é suposta uma função densidade de probabilidade combinada do tipo gaussiana

                    %Variáveis de entrada
                    %ndados - número de dados do arquivo a ser criado
                    %incerteza - incerteza fornecida pelo usuário
                    %ncor - número de curvas necessárias para obtenção de dados corrigidos
                    %l0 - comprimento inicial da amostra

                    %Variável de saída
                    %Matriz de covariância dos dados

                    nlinhas=ndados(1,1);
                    V=zeros(nlinhas,nlinhas);                                                  %Cria matriz de covariância dos dados de retração e de L0                                        
                    for j=1:ndados(1,1)
                            for k=1:ndados(1,1)
                                if j==k
                                    V(j,j)=ncor*(incerteza/l0)^2;                              %Variância dos dados de retração linear
                                else
                                    V(j,k)=0;                                                  %Dados independentes, logo ro=0 
                                end
                            end
                    end
                end
