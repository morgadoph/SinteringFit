function [V] = constroiVI (ndados,incerteza, ncor, l0)
                    %Fun��o que cria matriz de covari�ncia dos dados de retra��o linear 
                    %levando em considera��o a incerteza experimental fornecida pelo usu�rio. 
                    %Para isto � suposta uma fun��o densidade de probabilidade combinada do tipo gaussiana

                    %Vari�veis de entrada
                    %ndados - n�mero de dados do arquivo a ser criado
                    %incerteza - incerteza fornecida pelo usu�rio
                    %ncor - n�mero de curvas necess�rias para obten��o de dados corrigidos
                    %l0 - comprimento inicial da amostra

                    %Vari�vel de sa�da
                    %Matriz de covari�ncia dos dados

                    nlinhas=ndados(1,1);
                    V=zeros(nlinhas,nlinhas);                                                  %Cria matriz de covari�ncia dos dados de retra��o e de L0                                        
                    for j=1:ndados(1,1)
                            for k=1:ndados(1,1)
                                if j==k
                                    V(j,j)=ncor*(incerteza/l0)^2;                              %Vari�ncia dos dados de retra��o linear
                                else
                                    V(j,k)=0;                                                  %Dados independentes, logo ro=0 
                                end
                            end
                    end
                end
