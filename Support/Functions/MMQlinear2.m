function [clin, cang,canginc,clininc] = MMQlinear2 (Dados)
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
                        Residuo=(dadosy-X*parametros);                                             %Calcula resíduo do ajuste
                        [chi2teo] = chi2stat(ndados(1)-2);                                %Determina chi2 médio e variância para número de dados ajustados
                        RSSaj=Residuo'*(Residuo);                                                                     %RSS do ajuste
                        incerteza=(RSSaj/chi2teo(1))^(1/2);                           %Estima incerteza para o ajuste
                        Vcov=inv(X'*X);
                        clininc = incerteza*(Vcov(1,1))^(1/2);
                        canginc = incerteza*(Vcov(2,2))^(1/2);


                        clin = parametros(1,1);                                                    %Atribuição do coeficiente linear
                        cang = parametros(2,1);                                                    %Atribuição do coeficiente angular

                    end
