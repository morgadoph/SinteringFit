function [parametros] = MMQlinearpoly (Dados,grau)
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
                        X=zeros(ndados(1),grau+1);
                        for i=1:ndados(1)
                            for j=1:(grau+1)
                                X(i,j)=dadosx(i)^(j-1);
                            end
                        end

                        %Bloco de ajuste dos dados
                        parametros=X\dadosy;                                                       %Resolução do sistema linear

                    end
