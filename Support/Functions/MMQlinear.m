function [clin, cang] = MMQlinear (Dados)
                        %Função que realiza o ajuste linear dos dados desconsiderando a matriz de
                        %covariância dos dados devido ao curto intervalo de dados. 

                        %Variável de entrada
                        %Dados - Conjunto de dados com duas colunas (dadosx dadosy)

                        %Variáveis de saída
                        %clin - coeficiente linear do ajuste
                        %cang - coeficiente angular do ajuste


                        ndados=size(Dados);
                        dadosx= Dados(:,1);
                        dadosy= Dados(:,2);

                        %Criação da matriz de planejamento
                        X=zeros(ndados(1),2);
                        for i=1:ndados(1)
                            for j=1:2
                                X(i,j)=dadosx(i)^(j-1);
                            end
                        end

                        %Bloco de ajuste dos dados
                        parametros=X\dadosy;                                                       %Resolução do sistema linear
                        clin = parametros(1,1);                                                    %Atribuição do coeficiente linear
                        cang = parametros(2,1);                                                    %Atribuição do coeficiente angular

                    end
