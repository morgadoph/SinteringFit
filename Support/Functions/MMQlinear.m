function [clin, cang] = MMQlinear (Dados)
                        %Fun��o que realiza o ajuste linear dos dados desconsiderando a matriz de
                        %covari�ncia dos dados devido ao curto intervalo de dados. 

                        %Vari�vel de entrada
                        %Dados - Conjunto de dados com duas colunas (dadosx dadosy)

                        %Vari�veis de sa�da
                        %clin - coeficiente linear do ajuste
                        %cang - coeficiente angular do ajuste


                        ndados=size(Dados);
                        dadosx= Dados(:,1);
                        dadosy= Dados(:,2);

                        %Cria��o da matriz de planejamento
                        X=zeros(ndados(1),2);
                        for i=1:ndados(1)
                            for j=1:2
                                X(i,j)=dadosx(i)^(j-1);
                            end
                        end

                        %Bloco de ajuste dos dados
                        parametros=X\dadosy;                                                       %Resolu��o do sistema linear
                        clin = parametros(1,1);                                                    %Atribui��o do coeficiente linear
                        cang = parametros(2,1);                                                    %Atribui��o do coeficiente angular

                    end
