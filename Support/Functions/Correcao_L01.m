function [Acor, l0cor, clin] = Correcao_L01 (Arquivo, l0, Tinicio)
                    %Função utilizada para corrigir o valor de L0. É fornecido à função um
                    %intervalo de temperaturas no qual é feito um ajuste linear. O comprimento
                    %inicial é corrigido de acordo com o coeficiente linear deste ajuste.

                    %Variáveis de entrada
                    %Arquivo - dados experimentais
                    %l0 - Comprimento inicial da amostra
                    %Tinicio - Temperaturas inicial e final utilizadas no ajuste (Tinicial Tfinal)

                    %Variáveis de saída
                    %Acor - Dados corrigidos pelo comprimento inicial
                    %l0 - Comprimento inicial corrigido


                    %Bloco de criação de variáveis auxiliares utilizadas para determinar a
                    %posição dos dados para as devidas temperaturas adotadas
                    ndados=size(Arquivo);
                    iinicial=1;
                    ifinal=1;
                    Tinicial=Tinicio(1,1);
                    Tfinal=Tinicio(1,2);
                    Tdifi = ((Arquivo(1,2)-Tinicial)^2)^(1/2);
                    Tdiff = ((Arquivo(1,2)-Tfinal)^2)^(1/2);

                    %Bloco utilizado para determinar as posições dos dados de acordo com as
                    %temperaturas limites adotadas
                    for i=2:ndados(1,1);
                        Tdifi2 = ((Arquivo(i,2)-Tinicial)^2)^(1/2);
                        if Tdifi2 <= Tdifi
                            iinicial = i;
                            Tdifi = Tdifi2;
                        elseif Tdifi2 > (4*Tdifi)
                            break;
                        end
                    end
                    for i=2:ndados(1,1)
                        Tdiff2 = ((Arquivo(i,2)-Tfinal)^2)^(1/2);
                        if Tdiff2 <= Tdiff
                            ifinal = i;
                            Tdiff = Tdiff2;
                        elseif Tdiff2 > (4*Tdiff)
                            break;
                        end
                    end

                    %Bloco que calcula a correção a ser utilizada nos dados
                    Dados = Arquivo( iinicial:ifinal,2:3);
                    [clin] = MMQlinear (Dados);

                    %Bloco que corrige os dados e o comprimento l0 da amostra
                    l0cor = l0 + clin;
                    Acor=Arquivo;
                    Acor(:,3) = Acor (:,3) - clin*ones(ndados(1,1),1);

                end
