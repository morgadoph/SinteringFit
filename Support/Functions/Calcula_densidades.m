function [densidades,massacor] = Calcula_densidades (Acor, dens0, massacor)
                %Função que calcula curvas de densidades

                %Variáveis de entrada
                %Acor - Curvas de deslocamento corrigidas
                %dens0 - Densidades à verde 
                %massacor - Matriz de correção de massa

                %Variáveis de saída
                %densidades - densidades corrigidas
                %densificação - Curva de densificação
                %mcor - matriz com valores de correção de massa


                [nlinhas,~]=size(Acor);
                densidades=Acor;
                [mcor] = massacor;
                for j=1:nlinhas
                    densidades(j,3)=mcor(j,1)*(dens0/(1+Acor(j,3))^3);
                end
                
end
            